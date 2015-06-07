Files to build Psi+ using cmake utility.

HOWTO USE:

Instead of PSI_SOURCES_PATH must be your real psi_sources path

> $ cp -rf * PSI_SOURCES_PATH/

> $ cd PSI_SOURCES_PATH && mkdir build && cd build

> $ cmake -DCMAKE_INSTALL_PREFIX=/usr ..

> $ make && make install

USEFULL CMAKE FLAGS:

- set build plugins

  -DPLUGINS=ON

  to build psi-plus plugins (default ON)

- set build plugins only

  -DONLY_PLUGINS=ON

  to build only psi-plus plugins (default OFF)

- set build shared libs (iris, qjdns)

  -DBUILD_SHARED_LIBS=ON

  to build and install shared libraries (default ON)
  if there are bundled libs

- set build iris library bundled

  -DBUNDLED_IRIS=ON

  to build iris library bundled (default ON)

- set path to Qca library root dir

  -DQCA_DIR=DIRECTORY

- set path to IDN library root dir 

  -DIDN_ROOT=DIRECTORY

- set path to zlib root dir 

  -DZLIB_ROOT=DIRECTORY

- set build qjdns library bundled

  -DBUNDLED_QJDNS=ON

  to build qjdns bundled with iris library (default ON)

- set list of plugins to build:

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

- set install suffix:

  -DPLUGINS_PATH=${path} 

  to install plugins into default suffix:

  -DPLUGINS_PATH=lib/psi-plus/plugins or do not set this flag

  For example to install plugins into ~/.local/share/psi+/plugins:

  > $ cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local -DPLUGINS_PATH=share/psi+/plugins ..

  For example to install plugins into /usr/share/psi-plus/plugins:

  > $ cmake -DCMAKE_INSTALL_PREFIX=/usr -DPLUGINS_PATH=share/psi-plus/plugins ..

- set build type:
 
  -DCMAKE_BUILD_TYPE=Release or -DCMAKE_BUILD_TYPE=Debug

  For example:

   > $ cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release ..


To build OTRPLUGIN in OS WINDOWS you need to set additional variables

- path to LIBGCRYPT:

  -DLIBGCRYPT_ROOT=%LIBGCRYPT_ROOT%

- path to LIBGPG-ERROR

  -DLIBGPGERROR_ROOT=%LIBGPGERROR_ROOT%

- path to LIBOTR

  -DLIBOTR_ROOT=%LIBOTR_ROOT%

- path to LIBTIDY

  -DLIBTIDY_ROOT=%LIBTIDY_ROOT%

  For example:

  > $ cmake -DLIBGCRYPT_ROOT=C:\libgcrypt -DLIBGPGERROR_ROOT=C:\libgpg-error -DLIBOTR_ROOT=C:\libotr -DLIBTIDY_ROOT=C:\libtidy ..

- build psi-plus using Qt4

  -DQT4_BUILD=ON

  to build psi-plus with Qt4 (default ON)


TODO LIST:
- Add MacOSX support
- Add psi-plus binary build
