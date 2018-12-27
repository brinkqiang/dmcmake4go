
rem - clone code
rem git clone https://github.com/brinkqiang/dmcmake4go.git
rem pushd dmcmake4go
rem git submodule update --init --recursive

rmdir /S /Q build
rmdir /S /Q bin
mkdir build
pushd build
cmake -G "Unix Makefiles" ..
cmake --build .
make install
popd

rem pause