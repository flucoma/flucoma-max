mkdir -p build
rm -r build/CMakeFiles
rm -r build/source
rm build/CMakeCache.txt
rm build/Makefile
rm build/cmake_install.cmake
rm build/install_manifest.txt
cd build

rm -r ../externals
rm -r ../release-packaging/Fluid\ Corpus\ Manipulation/*

cmake -GNinja -DMAX_SDK_PATH=../sdk -DFLUID_PATH=../../core -DFLUID_ARCH=-mcpu=native -DCMAKE_OSX_ARCHITECTURES="x86_64;arm64" ..
ninja clean && ninja

cd ..
cd externals
fd -e mxo -x codesign --remove-signature "{}"
