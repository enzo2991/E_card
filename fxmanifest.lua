fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
author 'Enzo'
version '1.0.0'

server_script 'server.lua'

shared_script {'@ox_lib/init.lua','config.lua'}

client_script 'client.lua'

ui_page 'web/build/index.html'

files {'client.lua', 'server.lua', 'web/build/index.html', 'web/build/assets/*.js', 'web/build/assets/*.css'}
