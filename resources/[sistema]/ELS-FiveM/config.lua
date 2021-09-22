outputLoading = false
playButtonPressSounds = true
printDebugInformation = false

vehicleSyncDistance = 155
environmentLightBrightness = 0.112
lightDelay = 10 -- Time in MS
flashDelay = 15

panelEnabled = false
panelType = "original"
panelOffsetX = 0.0
panelOffsetY = 0.0

allowedPanelTypes = {
    "original",
    "old"
}

-- https://docs.fivem.net/game-references/controls

shared = {
    horn = 86,
}

keyboard = {
    modifyKey = 132,
    stageChange = 85, -- E
    guiKey = 199, -- P
    takedown = 83, -- =
    siren = {
        tone_one = 159, -- NUM4
        tone_two = 161, -- NUM5
        tone_three = 162, -- NUM6
    },
    pattern = {
        primary = 118, -- NUM9
        secondary = 111, -- NUM8
        advisor = 117, -- NUM7
    },
    warning = 246, -- Y
    secondary = 303, -- U
    primary = 7, -- ?? 
}

controller = {
    modifyKey = 73,
    stageChange = 80,
    takedown = 74,
    siren = {
        tone_one = 173,
        tone_two = 85,
        tone_three = 172,
    },
}