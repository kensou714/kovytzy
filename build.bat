mkdir build
cd build
make clean
cmake .. -DCMAKE_TOOLCHAIN_FILE=../pgm.cmake -G"Unix Makefiles"
make -j8
cd ..
libkov
copy ytzy_v201cn_o.rom d:\groovymame\roms\kovytzy\ytzy_v201cn.rom
cd d:\groovymame
mame kovytzy -w
pause