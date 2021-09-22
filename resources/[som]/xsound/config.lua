config = {}

-- How much ofter the player position is updated ?
config.RefreshTime = 100

-- default sound format for interact
config.interact_sound_file = "ogg"

-- is emulator enabled ?
config.interact_sound_enable = false

-- how much close player has to be to the sound before starting updating position ?
config.distanceBeforeUpdatingPos = 40

-- Message list
config.Messages = {
    ["streamer_on"]  = "O modo Streamer está ativado. A partir de agora você não ouvirá nenhuma música / som. externo",
    ["streamer_off"] = "O modo Streamer está desativado. A partir de agora, você poderá ouvir músicas que os jogadores podem tocar..",

    ["no_permission"] = "Você não pode usar este comando, você não tem permissão para isso!",
}

-- Addon list
-- True/False enabled/disabled
config.AddonList = {
    crewPhone = false,
}