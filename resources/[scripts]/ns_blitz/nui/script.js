$(function () {
  window.addEventListener("message", function (event) {
    if (event.data.type === "abrirBlitz") {
      $(".menu-blitz").css("display", "flex");
      $(".menu-blitz").fadeIn();
    }

    if (event.data.type === "fecharBlitz") {
      $(".menu-blitz").fadeOut();
    }

    if (event.data.type === "abrirInfo") {
      $(".obj").text(event.data.obj);
      $(".info").fadeIn();
    }

    if (event.data.type === "fecharInfo") {
      $(".info").fadeOut();
    }
  });

  document.onkeyup = function (data) {
    if (data.which == 27) {
      sendData("ButtonClick", { action: "fecharBlitz" }, false);
    }
  };
});

$(".colocar").click(function () {
  var type = $(this).val();
  var name = $(this).attr('name');
  setObstaculo(type, name);
});

$(".retirar").click(function () {
  var type = $(this).val();
  setObstaculo(type, "d");
});

$("#clear-all").click(function () {
  sendData("ButtonClick", { action: "clearArea" });
});

function setObstaculo(obstaculo, nome) {
  sendData("ButtonClick", { action: "setObstaculo", obstaculo: obstaculo, nome: nome });
}

function sendData(name, data) {
  $.post(
    "http://ns_blitz/" + name,
    JSON.stringify(data),
    function (datab) {}
  );
}
