﻿

$(document).ready(function () {
	window.addEventListener("message", function (event) {
		switch (event.data.action) {
			case "showMenu":
				updateMochila();
				$(".inventory").css("display", "flex")
				break;

			case "hideMenu":
				$(".inventory").css("display", "none")
				break;

			case "updateMochila":
				updateMochila();
				break;
		}
	});

	document.onkeyup = data => {
		const key = data.key;
		if (key === "Escape") {
			$.post("http://vrp_inventory/invClose", JSON.stringify({}));
		}
	};

	$('body').mousedown(e => {
		if (e.button == 1) return false;
	});
});

let weightLeft = 0;
let maxWeightLeft = 0;

const updateDrag = () => {
	$('.populated').draggable({
		helper: 'clone'
	});

	$('.empty').droppable({
		hoverClass: 'hoverControl',
		drop: function (event, ui) {
			if (ui.draggable.parent()[0] == undefined) return;

			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;

			if (origin === "invRight" && tInv === "invRight") return;

			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = 0;
			let itemAmount = parseInt(ui.draggable.data('amount'));

			if ($(".amount").val() == "" | parseInt($(".amount").val()) == 0)
				amount = itemAmount;
			else
				amount = parseInt($(".amount").val());


			if (amount > itemAmount)
				amount = itemAmount;

			$('.populated, .empty, .use').off("draggable droppable");

			let clone1 = ui.draggable.clone();
			let slot2 = $(this).data("slot");

			if (amount == itemAmount) {
				let clone2 = $(this).clone();
				let slot1 = ui.draggable.data("slot");

				$(this).replaceWith(clone1);
				ui.draggable.replaceWith(clone2);

				$(clone1).data("slot", slot2);
				$(clone2).data("slot", slot1);
			} else {
				let newAmountOldItem = itemAmount - amount;
				let weight = parseFloat(ui.draggable.data("peso"));
				let newWeightClone1 = (amount*weight).toFixed(2);
				let newWeightOldItem = (newAmountOldItem*weight).toFixed(2);

				ui.draggable.data("amount",newAmountOldItem);

				clone1.data("amount",amount);

				$(this).replaceWith(clone1);
				$(clone1).data("slot",slot2);

				ui.draggable.children(".top").children(".itemAmount").html(formatarNumero(ui.draggable.data("amount")) + "x");
				ui.draggable.children(".top").children(".itemWeight").html(newWeightOldItem);
				
				$(clone1).children(".top").children(".itemAmount").html(formatarNumero(clone1.data("amount")) + "x");
				$(clone1).children(".top").children(".itemWeight").html(newWeightClone1);
			}

			updateDrag();

			if (origin === "invLeft" && tInv === "invLeft"){
				$.post("http://vrp_inventory/populateSlot",JSON.stringify({
					item: itemData.key,
					slot: itemData.slot,
					target: target,
					amount: parseInt(amount)
				}));
			} else if (origin === "invRight" && tInv === "invLeft"){
				const id = ui.draggable.data("id");
				$.post("http://vrp_inventory/pickupItem",JSON.stringify({
					id: id,
					target: target,
					amount: parseInt(amount)
				}));
			} else if (origin === "invLeft" && tInv === "invRight"){
				$.post("http://vrp_inventory/dropItem",JSON.stringify({
					item: itemData.key,
					slot: itemData.slot,
					amount: parseInt(amount)
				}));
			}

			$(".amount").val("");
		}
	});

	$('.populated').droppable({
		hoverClass: 'hoverControl',
		drop: function (event, ui) {
			if (ui.draggable.parent()[0] == undefined) return;

			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;

			if (origin === "invRight" && tInv === "invRight") return;

			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = 0;
			let itemAmount = parseInt(ui.draggable.data('amount'));

			if ($(".amount").val() == "" | parseInt($(".amount").val()) == 0)
				amount = itemAmount;
			else
				amount = parseInt($(".amount").val());

			if (amount > itemAmount)
				amount = itemAmount;

			$('.populated, .empty, .use').off("draggable droppable");

			let futureWeightLeft = weightLeft;

			if (ui.draggable.data('item-key') == $(this).data('item-key')) {
				let newSlotAmount = amount + parseInt($(this).data('amount'));
				let newSlotWeight = parseFloat(ui.draggable.children(".top").children(".itemWeight").html()) + parseFloat($(this).children(".top").children(".itemWeight").html());

				$(this).data('amount', newSlotAmount);
				$(this).children(".top").children(".itemAmount").html(newSlotAmount + "x");
				$(this).children(".top").children(".itemWeight").html(newSlotWeight.toFixed(2));

				if (amount == itemAmount) {
					ui.draggable.replaceWith(`<div class="item empty" data-slot="${ui.draggable.data('slot')}"></div>`);
				} else {
					let newMovedAmount = itemAmount - amount;
					let newMovedWeight = newMovedAmount * parseFloat(ui.draggable.data("peso"));

					ui.draggable.data('amount', newMovedAmount);
					ui.draggable.children(".top").children(".itemAmount").html(newMovedAmount + "x");
					ui.draggable.children(".top").children(".itemWeight").html(newMovedWeight.toFixed(2));
				}

				if (origin === "invLeft" && tInv === "invRight") {
					futureWeightLeft = futureWeightLeft - (parseFloat(ui.draggable.data('peso')) * amount);
				} else if (origin === "invRight" && tInv === "invLeft") {
					futureWeightLeft = futureWeightLeft + (parseFloat(ui.draggable.data('peso')) * amount);
				}
			} else {
				if (origin === "invRight" && tInv === "invLeft") return;

				let clone1 = ui.draggable.clone();
				let clone2 = $(this).clone();

				let slot1 = ui.draggable.data("slot");
				let slot2 = $(this).data("slot");

				if (origin === "invLeft" && tInv === "invRight") {
					futureWeightLeft = futureWeightLeft - parseFloat(ui.draggable.data('amount')) + parseFloat($(this).data('amount'));
				}

				ui.draggable.replaceWith(clone2);
				$(this).replaceWith(clone1);

				$(clone1).data("slot", slot2);
				$(clone2).data("slot", slot1);
			}

			updateDrag();

			if (origin === "invLeft" && tInv === "invLeft") {
				$.post("http://vrp_inventory/updateSlot", JSON.stringify({
					item: itemData.key,
					slot: itemData.slot,
					target: target,
					amount: parseInt(amount)
				}));
			} else if (origin === "invRight" && tInv === "invLeft") {
				const id = ui.draggable.data("id");
				const grid = ui.draggable.data("grid");
				$.post("http://vrp_inventory/pickupItem", JSON.stringify({
					item: itemData.key,
					slot: target,
					amount: parseInt(amount)
				}));
			} else if (origin === "invLeft" && tInv === "invRight") {
				$.post("http://vrp_inventory/dropItem", JSON.stringify({
					item: itemData.key,
					slot: itemData.slot,
					amount: parseInt(amount)
				}));
			}

			$('.amount').val("");
		}
	});

	$('.use').droppable({
		hoverClass: 'hoverControl',
		drop: function (event, ui) {
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined || origin === "invRight") return;
			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };

			if (itemData.key === undefined) return;

			$.post("http://vrp_inventory/useItem", JSON.stringify({
				item: itemData.key,
				slot: itemData.slot,
				amount: parseInt(parseInt($(".amount").val()))
			}));

			$('.amount').val("");
		}
	});
	
	$('.send').droppable({
		hoverClass: 'hoverControl',
		drop: function (event, ui) {
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined || origin === "invRight") return;
			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };

			if (itemData.key === undefined) return;

			$.post("http://vrp_inventory/sendItem", JSON.stringify({
				item: itemData.key,
				slot: itemData.slot,
				amount: parseInt(parseInt($(".amount").val()))
			}));

			$('.amount').val("");
		}
	});

	$(".populated").on("auxclick", e => {
		e.preventDefault();
		if (e.which === 3) {
			const item = e.target;
			const origin = $(item).parent()[0].className;
			if (origin === undefined || origin === "invRight") return;

			itemData = { key: $(item).data('item-key'), slot: $(item).data('slot') };

			if (itemData.key === undefined) return;

			let amount = 1

			$.post("http://vrp_inventory/useItem", JSON.stringify({
				item: itemData.key,
				slot: itemData.slot,
				amount: amount
			}));
		}
	});
}

const updateMochila = () => {
	$.post("http://vrp_inventory/requestMochila", JSON.stringify({}), (data) => {
		$("#weightTextLeft").html(`${(data["peso"]).toFixed(2)}   /   ${(data["maxpeso"]).toFixed(2)}`);
		$("#weightBarLeft").html(`<div id="weightContent" style="width: ${data["peso"] / data["maxpeso"] * 100}%"></div>`);

		weightLeft = data.peso;
		maxWeightLeft = data.maxpeso;


		$(".invLeft").html("");
		$(".invRight").html("");

		const nameList2 = data.drop.sort((a, b) => (a.name > b.name) ? 1 : -1);

		for (let x = 1; x <= 100; x++) {
			const slot = x.toString();

			if (data.inventario[slot] !== undefined) {
				const v = data.inventario[slot];
				const item = `<div class="item populated" style="background-image: url('imagens/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-amount="${v.amount}" data-peso="${v.peso}" data-item-key="${v.key}" data-name-key="${v.name}" data-slot="${slot}">
					<div class="top">
					<div class="itemWeight"></div>
					<div class="itemAmount">${formatarNumero(v.amount)}x   |   ${(v.peso * v.amount).toFixed(2)}</div>
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

			if (nameList2[x - 1] !== undefined) {
				const v = nameList2[x - 1];
				const item = `<div class="item populated" style="background-image: url('imagens/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-item-key="${v.key}" data-name-key="${v.name}" data-id="${v.id}" data-grid="${v.grid}" data-amount="${v.amount}" data-peso="${v.peso}" data-slot="${slot}">
					<div class="top">
						<div class="itemWeight"></div>
						<div class="itemAmount">${formatarNumero(v.amount)}x   |   ${(v.peso * v.amount).toFixed(2)}</div>
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