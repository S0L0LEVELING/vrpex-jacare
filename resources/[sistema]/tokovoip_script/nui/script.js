function getTickCount(){
	let date = new Date();
	let tick = date.getTime();
	return (tick);
}

let websocket;
let connected = false;
let lastPing = 0;
let lastReconnect = 0;
let lastOk = 0;

let voip = {};

const OK = 0;
const NOT_CONNECTED = 1;
const PLUGIN_INITIALIZING = 2;
const WRONG_SERVER = 3;
const WRONG_CHANNEL = 4;
const INCORRECT_VERSION = 5;

function init() {
	websocket = new WebSocket('ws://127.0.0.1:38204/tokovoip');

	websocket.onopen = () => {
		connected = true;
		lastPing = getTickCount();
	};

	websocket.onmessage = (evt) => {
		if (evt.data.includes('TokoVOIP status:')){
			connected = true;
			lastPing = getTickCount();
			forcedInfo = false;
			const pluginStatus = evt.data.split(':')[1].replace(/\./g, '');
			updateScriptData('pluginStatus', parseInt(pluginStatus));
		}

		if (evt["data"].includes("TokoVOIP version:")){
			updateScriptData("pluginVersion",evt["data"].split(":")[1]);
		}

		if (evt["data"].includes("TokoVOIP UUID:")){
			updateScriptData("pluginUUID",evt["data"].split(":")[1]);
		}

		if (evt.data == 'startedtalking'){
			$.post('http://tokovoip_script/setPlayerTalking',JSON.stringify({ state: 1 }));
		}

		if (evt.data == 'stoppedtalking'){
			$.post('http://tokovoip_script/setPlayerTalking',JSON.stringify({ state: 0 }));
		}
	};

	websocket.onclose = () => {
		sendData("disconnect");

		updateScriptData("pluginStatus",-1);
		lastReconnect = getTickCount();
		displayPluginScreen(true);
		connected = false;
		init();
	};
}

function sendData(message){
	if (websocket["readyState"] == websocket["OPEN"]){
		websocket.send(message);
	}
}

function receivedClientCall(event){
	const payload = event["data"]["payload"];
	const eventName = event["data"]["type"];
	voipStatus = 0;

	if (eventName == "updateConfig"){
		updateConfig(payload);
	} else if (voip){
		if (eventName == "initializeSocket"){
			lastReconnect = getTickCount();
			lastPing = getTickCount();
			init();
		} else if (eventName == "updateTokoVoip"){
			voip["plugin_data"] = payload;
			updatePlugin();
		} else if (eventName == "disconnect"){
			sendData("disconnect");
			voipStatus = 1;
		}
	}

	checkPluginStatus();

	if (voipStatus != 0){
		if (getTickCount() - lastOk > 5000){
			displayPluginScreen(true);
		}
	} else {
		displayPluginScreen(false);
		lastOk = getTickCount();
	}
}

function checkPluginStatus(){
	switch (parseInt(voip["pluginStatus"])){
		case -1:
			voipStatus = 1;
			break;

		case 0:
			voipStatus = 2;
			break;

		case 1:
			voipStatus = 3;
			break;

		case 2:
			voipStatus = 4;
			break;

		case 3:
			voipStatus = 0;
			break;
	}

	if (getTickCount() - lastPing > 5000){
		voipStatus = 1;
	}
}

function isPluginVersionCorrect(){
	if (parseInt(voip["pluginVersion"].replace(/\./g,"")) < parseInt(voip["minVersion"].replace(/\./g,""))) return false;

	return true;
}

function displayPluginScreen(toggle){
	document.getElementById("pluginScreen")["style"]["display"] = (toggle) ? "block" : "none";
}

function updateConfig(payload){
	voip = payload;
}

function updatePlugin(){
	const timeout = getTickCount() - lastPing;
	const lastRetry = getTickCount() - lastReconnect;

	if (timeout >= 10000 && lastRetry >= 5000){
		lastReconnect = getTickCount();
		connected = false;
		updateScriptData("pluginStatus",-1);
		init();
	} else if (connected){
		sendData(JSON.stringify(voip["plugin_data"]));
	}
}

function updateScriptData(key,data){
	if (voip[key] === data) return;

	$.post("http://tokovoip_script/updatePluginData",JSON.stringify({ payload: { key,data }	}));
}

window.addEventListener("message",receivedClientCall,false);