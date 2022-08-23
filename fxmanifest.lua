fx_version 'bodacious'
game 'gta5'

author 'Dog#7087'
description 'esx_documents -> os-document | Full QBCore|'
version '1.0.0'

ui_page 'html/os_document.html'

files {
	'html/os_document.html',
	'html/img/seal.png',
	'html/img/document.jpg',
	'html/img/signature.png',
	'html/os_style.css',
	'html/language_os.js',
	'html/os_script.js',
	'html/jquery-3.4.1.min.js',
}

server_scripts {
	'config/os_config.lua',
	'server/os_server.lua',
}

client_scripts {
	'config/os_config.lua',
	'html/menu/os_gui.lua',
	'client/os_client.lua',
}


