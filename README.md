Files to build Psi+ plugins using cmake utility.
Works only on Linux wiht Qt4.

HOWTO USE:

At PSI_SOURCES_PATH must be your real psi_sources path

> $ cp -rf * PSI_SOURCES_PATH/

> $ cd PSI_SOURCES_PATH && mkdir build && cd build

> $ cmake -DPLUGINS_INSTALL_PATH=lib64/psi-plus/plugins -DCMAKE_INSTALL_PREFIX=/usr ..

> $ make && make install


OR:

> $ cmake -DPLUGINS_INSTALL_PATH=share/psi+/plugins -DCMAKE_INSTALL_PREFIX=~/.local ..

> $ make && make install


TODO LIST:
- Add Qt5 support
- Add Apple support
- Add Windows support
