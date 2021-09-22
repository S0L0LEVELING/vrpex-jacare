function getYoutubeUrlId(url)
{
    var videoId = "";
    if( url.indexOf("youtube") !== -1 ){
        var urlParts = url.split("?v=");
        videoId = urlParts[1].substring(0,11);
    }

    if( url.indexOf("youtu.be") !== -1 ){
        var urlParts = url.replace("//", "").split("/");
        videoId = urlParts[1].substring(0,11);
    }
    return videoId;
}

function isReady(divId, howler){
    if(howler){
        for (var soundName in soundList)
        {
            var sound = soundList[soundName];
            if(sound.loaded() == false){
                sound.setLoaded(true);
                $.post('http://tota_core/events', JSON.stringify(
                {
                    type: "onPlay",
                    id: sound.getName(),
                }));

                var time = 3;
                if(sound.getAudioPlayer() != null){time = sound.getAudioPlayer()._duration;}

                $.post('http://tota_core/data_status', JSON.stringify(
                {
                    time: time,
                    type: "maxDuration",
                    id: sound.getName(),
                }));
                sound._duration
                break;
            }
        }
        return;
    }
	for (var soundName in soundList)
	{
		var sound = soundList[soundName];
        if(sound.getDivId() === divId){
            $.post('http://tota_core/events', JSON.stringify(
            {
                type: "onPlay",
                id: sound.getName(),
            }));

            $.post('http://tota_core/data_status', JSON.stringify(
            {
                time: sound.getYoutubePlayer().getDuration(),
                type: "maxDuration",
                id: sound.getName(),
            }));

            sound.isYoutubeReady(true);
            if(!sound.isDynamic()) sound.setVolume(sound.getVolume())
            if(sound.isDynamic()){
                updateVolumeSounds();
            }
            break;
        }
	}
}

function isLooped(divId){
	for (var soundName in soundList)
	{
		var sound = soundList[soundName];
        if(sound.getDivId() === divId && sound.isLoop() == true){
            sound.destroyYoutubeApi();
            sound.delete();
            sound.create();
            sound.play();
            break;
        }
    }
}

function ended(divId){
    if(divId == null)
    {
    	for (var soundName in soundList)
    	{
            var sound = soundList[soundName];
            if(!sound.isPlaying() && sound.isLoop() == false)
            {
                $.post('http://tota_core/data_status', JSON.stringify({ type: "finished",id: soundName }));
                $.post('http://tota_core/events', JSON.stringify(
                {
                    type: "onEnd",
                    id: sound.getName(),
                }));
                break;
            }
    	}
    }
    else
    {
    	for (var soundName in soundList)
    	{
            var sound = soundList[soundName];
            if(sound.getDivId() === divId && sound.isLoop() == false){
                sound.destroyYoutubeApi();
                $.post('http://tota_core/data_status', JSON.stringify({ type: "finished",id: soundName }));
                $.post('http://tota_core/events', JSON.stringify(
                {
                    type: "onEnd",
                    id: sound.getName(),
                }));
                break;
            }
        }
    }
}