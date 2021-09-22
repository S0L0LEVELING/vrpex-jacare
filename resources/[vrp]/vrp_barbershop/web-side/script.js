$(document).ready(function () {
	$(".popup").hide();

	var documentWidth = document.documentElement.clientWidth;
	var documentHeight = document.documentElement.clientHeight;
	var cursor = $('#cursorPointer');
	var cursorX = documentWidth / 2;
	var cursorY = documentHeight / 2;

	function triggerClick(x, y) {
		var element = $(document.elementFromPoint(x, y));
		element.focus().click();
		return true;
	}

	window.addEventListener('message', function (event) {

		var opt = event.data.myclothes

		if (opt) {
			$(".skinColor").val(opt.skinColor);
			$(".eyesColor").val(opt.eyesColor);
			$(".complexionModel").val(opt.complexionModel);
			$(".blemishesModel").val(opt.blemishesModel);
			$(".frecklesModel").val(opt.frecklesModel);
			$(".ageingModel").val(opt.ageingModel);
			$(".hairModel").val(opt.hairModel);
			$(".firstHairColor").val(opt.firstHairColor);
			$(".secondHairColor").val(opt.secondHairColor);
			$(".makeupModel").val(opt.makeupModel);
			$(".blushModel").val(opt.blushModel);
			$(".blushColor").val(opt.blushColor);
			$(".lipstickModel").val(opt.lipstickModel);
			$(".lipstickColor").val(opt.lipstickColor);
			$(".eyebrowsModel").val(opt.eyebrowsModel);
			$(".eyebrowsColor").val(opt.eyebrowsColor);
			$(".beardModel").val(opt.beardModel);
			$(".beardColor").val(opt.beardColor);
		}


		if (event.data.openBarbershop == true) {
			$(".openBarbershop").show();

			$('.input .label-value').each(function () {
				var max = $(this).attr('data-legend'), val = $(this).next().find('input').val();
				$(this).parent().find('.label-value').text(val + '/' + max);
			});
		}

		if (event.data.openBarbershop == false) {
			$(".openBarbershop").hide();
		}

		if (event.data.type == "click") {
			triggerClick(cursorX - 1, cursorY - 1);
		}
	});


	$('input').change(function () {
		$.post('http://vrp_barbershop/updateSkin', JSON.stringify({
			value: false,
			// fatherid: $('.fatherID').val(),
			// kinship: $('.kinship').val(),
			// eyecolor: $('.eyecolor').val(),
			// skincolor: $('.skincolor').val(),
			// acne: $('.acne').val(),
			// stains: $('.stains').val(),
			// freckles: $('.freckles').val(),
			// aging: $('.aging').val(),
			// hair: $('.hair').val(),
			// haircolor: $('.haircolor').val(),
			// haircolor2: $('.haircolor2').val(),
			// makeup: $('.makeup').val(),
			// makeupintensity: $('.makeupintensity').val(),
			// makeupcolor: $('.makeupcolor').val(),
			// lipstick: $('.lipstick').val(),
			// lipstickintensity: $('.lipstickintensity').val(),
			// lipstickcolor: $('.lipstickcolor').val(),
			// eyebrow: $('.eyebrow').val(),
			// eyebrowintensity: $('.eyebrowintensity').val(),
			// eyebrowcolor: $('.eyebrowcolor').val(),
			// beard: $('.beard').val(),
			// beardintentisy: $('.beardintentisy').val(),
			// beardcolor: $('.beardcolor').val(),
			// blush: $('.blush').val(),
			// blushintentisy: $('.blushintentisy').val(),
			// blushcolor: $('.blushcolor').val(),
			// motherid: $('.motherID').val()

			skinColor: $('.skinColor').val(),
			eyesColor: $('.eyesColor').val(),
			complexionModel: $('.complexionModel').val(),
			blemishesModel: $('.blemishesModel').val(),
			frecklesModel: $('.frecklesModel').val(),
			ageingModel: $('.ageingModel').val(),
			hairModel: $('.hairModel').val(),
			firstHairColor: $('.firstHairColor').val(),
			secondHairColor: $('.secondHairColor').val(),
			makeupModel: $('.makeupModel').val(),
			blushModel: $('.blushModel').val(),
			blushColor: $('.blushColor').val(),
			lipstickModel: $('.lipstickModel').val(),
			lipstickColor: $('.lipstickColor').val(),
			eyebrowsModel: $('.eyebrowsModel').val(),
			eyebrowsColor: $('.eyebrowsColor').val(),
			beardModel: $('.beardModel').val(),
			beardColor: $('.beardColor').val(),

		}));
	});

	$('.arrow').on('click', function (e) {
		e.preventDefault();
		$.post('http://vrp_barbershop/updateSkin', JSON.stringify({
			value: false,
			// fatherid: $('.fatherID').val(),
			// kinship: $('.kinship').val(),
			// eyecolor: $('.eyecolor').val(),
			// skincolor: $('.skincolor').val(),
			// acne: $('.acne').val(),
			// stains: $('.stains').val(),
			// freckles: $('.freckles').val(),
			// aging: $('.aging').val(),
			// hair: $('.hair').val(),
			// haircolor: $('.haircolor').val(),
			// haircolor2: $('.haircolor2').val(),
			// makeup: $('.makeup').val(),
			// makeupintensity: $('.makeupintensity').val(),
			// makeupcolor: $('.makeupcolor').val(),
			// lipstick: $('.lipstick').val(),
			// lipstickintensity: $('.lipstickintensity').val(),
			// lipstickcolor: $('.lipstickcolor').val(),
			// eyebrow: $('.eyebrow').val(),
			// eyebrowintensity: $('.eyebrowintensity').val(),
			// eyebrowcolor: $('.eyebrowcolor').val(),
			// beard: $('.beard').val(),
			// beardintentisy: $('.beardintentisy').val(),
			// beardcolor: $('.beardcolor').val(),
			// blush: $('.blush').val(),
			// blushintentisy: $('.blushintentisy').val(),
			// blushcolor: $('.blushcolor').val(),
			// motherid: $('.motherID').val()

			skinColor: $('.skinColor').val(),
			eyesColor: $('.eyesColor').val(),
			complexionModel: $('.complexionModel').val(),
			blemishesModel: $('.blemishesModel').val(),
			frecklesModel: $('.frecklesModel').val(),
			ageingModel: $('.ageingModel').val(),
			hairModel: $('.hairModel').val(),
			firstHairColor: $('.firstHairColor').val(),
			secondHairColor: $('.secondHairColor').val(),
			makeupModel: $('.makeupModel').val(),
			blushModel: $('.blushModel').val(),
			blushColor: $('.blushColor').val(),
			lipstickModel: $('.lipstickModel').val(),
			lipstickColor: $('.lipstickColor').val(),
			eyebrowsModel: $('.eyebrowsModel').val(),
			eyebrowsColor: $('.eyebrowsColor').val(),
			beardModel: $('.beardModel').val(),
			beardColor: $('.beardColor').val(),
		}));
	});

	$('.yes').on('click', function (e) {
		e.preventDefault();
		$.post('http://vrp_barbershop/updateSkin', JSON.stringify({
			value: true,
			skinColor: $('.skinColor').val(),
			eyesColor: $('.eyesColor').val(),
			complexionModel: $('.complexionModel').val(),
			blemishesModel: $('.blemishesModel').val(),
			frecklesModel: $('.frecklesModel').val(),
			ageingModel: $('.ageingModel').val(),
			hairModel: $('.hairModel').val(),
			firstHairColor: $('.firstHairColor').val(),
			secondHairColor: $('.secondHairColor').val(),
			makeupModel: $('.makeupModel').val(),
			blushModel: $('.blushModel').val(),
			blushColor: $('.blushColor').val(),
			lipstickModel: $('.lipstickModel').val(),
			lipstickColor: $('.lipstickColor').val(),
			eyebrowsModel: $('.eyebrowsModel').val(),
			eyebrowsColor: $('.eyebrowsColor').val(),
			beardModel: $('.beardModel').val(),
			beardColor: $('.beardColor').val(),


		}));
	});

	document.onkeydown = function (data) {
		if (data.which == 65) {
			$.post('http://vrp_barbershop/rotate', JSON.stringify("right"));
		}
		if (data.which == 68) {
			$.post('http://vrp_barbershop/rotate', JSON.stringify("left"));
		}
	}
});