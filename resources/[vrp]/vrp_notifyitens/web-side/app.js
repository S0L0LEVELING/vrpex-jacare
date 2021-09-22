$(document).ready(function(){
    window.addEventListener("message",function(event){
        var html = `<div class="item" style="background-image: url('nui://vrp_inventory/web-side/imagens/${event.data.item}.png');">
            <div class="top">
                <div class="itemWeight">${event.data.mode}</div>
                <div class="itemAmount">x${event.data.amount}</div>
            </div>
            <div class="itemname">${event.data.name}</div>
        </div>`;

        $(html).fadeIn(500).appendTo("#notifyitens").delay(3000).fadeOut(500);
    })
});
