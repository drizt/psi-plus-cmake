Files to build Psi+ plugins using cmake utility.
Works only on Linux wiht Qt4.

HOWTO USE:

> $ cp -f plugins psi/build/src/

> $ cd psi/build/src/plugins

> $ mkdir build && cd build

> $ cmake -DPLUGINS_INSTALL_PATH=lib64/psi-plus/plugins -DCMAKE_INSTALL_PREFIX=/usr ..

> $ make && make install


OR:

> $ cmake -DPLUGINS_INSTALL_PATH=share/psi+/plugins -DCMAKE_INSTALL_PREFIX=~/.local ..

> $ make && make install


TODO LIST:
- Add Qt5 support
- Add Apple support
- Add Windows support
