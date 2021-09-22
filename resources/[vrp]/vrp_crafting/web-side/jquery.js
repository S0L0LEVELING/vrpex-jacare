var selectCraft = "selectCraft";
/* --------------------------------------------------- */
$(document).ready(function () {
	window.addEventListener("message", function (event) {
		switch (event.data.action) {
			case "showNUI":
				selectCraft = event.data.name;
				$(".inventory").css("display", "flex")
				requestCrafting();
				break;

			case "hideNUI":
				$(".inventory").css("display", "none")
				break;

			case "requestCrafting":
				requestCrafting();
				break;
		}
	});

	document.onkeyup = function (data) {
		if (data.which == 27) {
			$.post("http://vrp_crafting/close");
		}
	};
});
/* --------------------------------------------------- */
const updateDrag = () => {
	$('.populated').draggable({
		helper: 'clone'
	});

	$('.empty').droppable({
		hoverClass: 'hoverControl',	
		drop: function (event, ui) {
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;

			const tInv = $(this).parent()[0].className;
			if (tInv === "invLeft") {

				if (origin === "invLeft") {
					itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
					const target = $(this).data('slot');

					if (itemData.key === undefined || target === undefined) return;

					$.post("http://vrp_crafting/populateSlot", JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt($(".amount").val())
					}))

					$('.amount').val("")
				} else if (origin === "invRight") {
					itemData = { key: ui.draggable.data('item-key') };
					const target = $(this).data('slot');

					if (itemData.key === undefined || target === undefined) return;

					$.post("http://vrp_crafting/functionCraft", JSON.stringify({
						craft: selectCraft,
						index: itemData.key,
						slot: target,
						amount: parseInt($(".amount").val())
					}))

					$('.amount').val("")
				}
			} else if (tInv === "invRight") {
				if (origin === "invLeft") {
					itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') }

					if (itemData.key === undefined) return;

					$.post("http://vrp_crafting/functionDestroy", JSON.stringify({
						craft: selectCraft,
						index: itemData.key,
						slot: itemData.slot,
						amount: parseInt($(".amount").val())
					}))

					$('.amount').val("")
				}
			}
		}
	});

	$('.populated').droppable({
		hoverClass: 'hoverControl',
		drop: function (event, ui) {
			const origin = ui.draggable.parent()[0].id;
			if (origin === undefined) return;

			const tInv = $(this).parent()[0].id;

			if (tInv === "invLeft") {
				if (origin === "invLeft") {
					itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
					const target = $(this).data('slot');

					if (itemData.key === undefined || target === undefined) return;

					$.post("http://vrp_crafting/updateSlot", JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt($(".amount").val())
					}))

					$('.amount').val("")
				} else if (origin === "invRight") {
					itemData = { key: ui.draggable.data('item-key') };
					const target = $(this).data('slot');

					if (itemData.key === undefined || target === undefined || itemData.key !== $(this).data('item-key')) return;

					$.post("http://vrp_crafting/functionCraft", JSON.stringify({
						craft: selectCraft,
						index: itemData.key,
						slot: target,
						amount: parseInt($(".amount").val())
					}))

					$('.amount').val("")
				}
			} else if (tInv === "invRight") {
				if (origin === "invLeft") {
					itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') }

					if (itemData.key === undefined) return;

					$.post("http://vrp_crafting/functionDestroy", JSON.stringify({
						craft: selectCraft,
						index: itemData.key,
						slot: itemData.slot,
						amount: parseInt($(".amount").val())
					}))

					$('.amount').val("")
				}
			}
		}
	});

	$(".populated").hover(function () {
		const data = $(this).data("item-list");

		if (data === undefined) return;

		$(".recipe").hide().text(data).fadeIn();
	}, function () {
		$(".recipe").hide();
	});
}


const requestCrafting = () => {
	$.post("http://vrp_crafting/requestCrafting",JSON.stringify({ craft: selectCraft }),(data) => {

		$("#weightTextLeft").html(`${(data.weight).toFixed(2)}   /   ${(data.maxweight).toFixed(2)}`);
		$("#weightBarLeft").html(`<div id="weightContent" style="width: ${data.weight / data.maxweight * 100}%"></div>`);

		const nameList2 = data.inventoryCraft.sort((a, b) => (a.name > b.name) ? 1 : -1);

		$(".invLeft").html("");
		$(".invRight").html("");


		for (let x = 1; x <= 100; x++){
			const slot = x.toString();

			if (data.inventoryUser[slot] !== undefined) {
				const v = data.inventoryUser[slot];
				const item = `<div class="item populated" style="background-image: url('nui://vrp_inventory/web-side/imagens/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-item-key="${v.key}" data-name-key="${v.name}" data-amount="${v.amount}" data-slot="${slot}">
				<div class="top">
					<div class="itemWeight">${(v.peso * v.amount).toFixed(2)}</div>
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

		for (let x = 1; x <= 50; x++){
			const slot = x.toString();

			if (nameList2[x - 1] !== undefined) {
				const v = nameList2[x - 1];
				let list = "";

				for (let i in v.list) {
					list = `${list} ${v.list[i].amount}x ${v.list[i].name},`
				}

				list = list.substring(0, list.length - 1);

				const item = `<div class="item populated" style="background-image: url('nui://vrp_inventory/web-side/imagens/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-item-key="${v.key}" data-name-key="${v.name}" data-item-list="${list}" data-slot="${slot}">
				<div class="top">
					<div class="itemWeight">${v.weight.toFixed(2)}</div>
				</div>

				<div class="itemname">${v.name}</div>
				</div>`;

				$(".invRight").append(item);
			} else {
				const item = `<div class="item2 empty" data-slot="${slot}"></div>`;

				$(".invRight").append(item);
			}
		}
		updateDrag();
	});
}

/* --------------------------------------------------- */
const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}