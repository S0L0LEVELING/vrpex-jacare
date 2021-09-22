/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function(){
	window.addEventListener("message",function(event){
		switch(event.data.action){
			case "openSystem":
				$("#button-bar").fadeIn(100);
			break;

			case "closeSystem":
				$("#button-bar").fadeOut(100);
			break;
		};
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_tencode/closeSystem");
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
const clickCode = (data) => {
	$.post("http://vrp_tencode/sendCode",JSON.stringify({ code: data }));
};