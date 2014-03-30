Files to build Psi+ plugins using cmake utility.
Works only on Linux wiht Qt4.

HOWTO USE:

Instead PSI_SOURCES_PATH must be your real psi_sources path

> $ cp -rf * PSI_SOURCES_PATH/

> $ cd PSI_SOURCES_PATH && mkdir build && cd build

> $ cmake -DCMAKE_INSTALL_PREFIX=/usr ..

> $ make && make install


USEFUL CMAKE FLAGS:

- set list of plugins to build

  -DBUILD_PLUGINS=${plugins}
  
  to build all plugins:  -DBUILD_PLUGINS="ALL" or do not set this flag

  - possible values for ${plugins}:

    historykeeperplugin	stopspamplugin juickplugin translateplugin gomokugameplugin attentionplugin
    cleanerplugin autoreplyplugin contentdownloaderplugin	qipxstatusesplugin skinsplugin icqdieplugin
    clientswitcherplugin captchaformsplugin watcherplugin videostatusplugin screenshotplugin
    jabberdiskplugin storagenotesplugin	extendedoptionsplugin imageplugin	extendedmenuplugin
    birthdayreminderplugin gmailserviceplugin gnupgplugin pepchangenotifyplugin otrplugin
    chessplugin conferenceloggerplugin gnome3supportplugin
  
  Example:
  
  > $ cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_PLUGINS="chessplugin;otrplugin;gnome3supportplugin" ..

- set install suffix

  -DPLUGINS_PATH=${path}
  
  For example to install plugins into ~/.local/share/psi+/plugins:
  
  > $ cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local --DPLUGINS_PATH=share/psi+/plugins ..
  
  For example to install plugins into /usr/share/psi-plus/plugins:
  
  > $ cmake -DCMAKE_INSTALL_PREFIX=/usr --DPLUGINS_PATH=share/psi-plus/plugins ..


TODO LIST:
- Add Qt5 support
- Add MacOSX support
- Add Windows support
- Add psi-plus binary build
