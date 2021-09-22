fx_version 'cerulean'
games { 'gta5' }

author 'Danny255' -- http://discord.gg/t24h5ku3su
description 'MusicEverywhere' -- https://danny255-scripts.tebex.io/package/4289906
version '1.2.0'

ui_page 'html/index.html'

client_scripts {
	'@vrp/lib/utils.lua',
  'config.lua',
  'client/main.lua',
}

files {
	'html/index.html',
	'html/script.js',
	'html/*.svg',
	'html/radio.png',
	'html/main.css',
}

server_scripts {
	'@vrp/lib/utils.lua',
  'config.lua',
  'server/main.lua',
}