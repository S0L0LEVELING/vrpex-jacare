const mySlots = 50;
const inSlots = 100;
let shiftPressed = true;

$(document).ready(function(){
	window.addEventListener("message",function(event){
		switch(event.data.action){
			case "showMenu":
				updateChest();
				$(".inventory").css("display","flex")
			break;

			case "hideMenu":
				$(".inventory").css("display","none")
			break;

			case "updateChest":
				updateChest();
			break;
		}
	});

	document.onkeydown = data => {
		const key = data.key;
		if (key === "Shift") {
			shiftPressed = false;
		}
	}

	document.onkeyup = data => {
		const key = data.key;
		if (key === "Escape"){
			$.post("http://vrp_inspect/chestClose",JSON.stringify({}));
		} else if (key === "Shift") {
			shiftPressed = true;
		}
	}
});

const updateDrag = () => {
	$('.populated').draggable({
		helper: 'clone'
	});

	$('.empty').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;

			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = $(".amount").val();
			if (shiftPressed) amount = ui.draggable.data('amount');

			if (tInv === "invLeft") {
				if (origin === "invLeft") {
					$.post("http://vrp_inspect/populateSlot",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}))

					$('.amount').val("");
				} else if (origin === "invRight") {
					$.post("http://vrp_inspect/takeItem",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				}
			} else if ( tInv === "invRight" ) {
				if ( origin === "invRight" ) {
					$.post("http://vrp_inspect/populateSlot2",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}))

					$('.amount').val("");
				} else if ( origin === "invLeft" ) {
					$.post("http://vrp_inspect/storeItem",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				}
			}
		}
	});

	$('.populated').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;
			
			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = $(".amount").val();
			if (shiftPressed) amount = ui.draggable.data('amount');


			if ( tInv === "invLeft" ) {
				if (origin === "invLeft"){
					$.post("http://vrp_inspect/updateSlot",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				} else if (origin === "invRight"){
					$.post("http://vrp_inspect/sumSlot",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				}
			} else if ( tInv === "invRight" ) {
				if ( origin === "invRight" ) {
					$.post("http://vrp_inspect/updateSlot2",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				} else if ( origin === "invLeft" ) {
					$.post("http://vrp_inspect/sumSlot2",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				}
			}
		}
	});
}

const updateChest = () => {
	$.post("http://vrp_inspect/requestChest",JSON.stringify({}),(data) => {
		$("#weightTextLeft").html(`${(data.peso).toFixed(2)}   /   ${(data.maxpeso).toFixed(2)}`);
		$("#weightTextRight").html(`${(data.peso2).toFixed(2)}   /   ${(data.maxpeso2).toFixed(2)}`);

		$("#weightBarLeft").html(`<div id="weightContent" style="width: ${data.peso / data.maxpeso * 100}%"></div>`);
		$("#weightBarRight").html(`<div id="weightContent" style="width: ${data.peso2 / data.maxpeso2 * 100}%"></div>`);

		$(".invLeft").html("");
		$(".invRight").html("");
		
		for (let x = 1; x <= 100; x++) {
			const slot = x.toString();

			if (data.inventario[slot] !== undefined){
				const v = data.inventario[slot];
				const item = `<div class="item populated" style="background-image: url('nui://vrp_inventory/web-side/imagens/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-item-key="${v.key}" data-name-key="${v.name}" data-amount="${v.amount}" data-slot="${slot}">
					<div class="top">
						<div class="itemWeight">${(v.peso*v.amount).toFixed(2)}</div>
						<div class="itemAmount">${formatarNumero(v.amount)}x</div>
					</div>
					<div class="itemname">${v.name}</div>
				</div>`;

				$(".invLeft").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invLeft").append(item);
			}
		}

		for (let x = 1; x <= 100; x++) {
			const slot = x.toString();

			if (data.inventario2[slot] !== undefined) {
				const v = data.inventario2[slot];
				const item = `<div class="item populated" style="background-image: url('nui://vrp_inventory/web-side/imagens/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-item-key="${v.key}" data-name-key="${v.name}" data-amount="${v.amount}" data-slot="${slot}">
					<div class="top">
						<div class="itemWeight">${(v.peso*v.amount).toFixed(2)}</div>
						<div class="itemAmount">${formatarNumero(v.amount)}x</div>
					</div>
					<div class="itemname">${v.name}</div>
				</div>`;

				$(".invRight").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invRight").append(item);
			}
		}
		updateDrag();
	});
}

const formatarNumero = n => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}