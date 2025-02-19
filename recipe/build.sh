#/usr/bin/env bash

set -ex

export PATH=$BUILD_PREFIX/bin:$PATH  # Ensure conda python is used

echo "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
echo "uname -m"
uname -m
echo "Doing file command: "
file $PREFIX/bin/python
echo "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"

echo "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
echo "PREFIX: ${PREFIX}"
echo "Python: ${PYTHON}"
echo "Which Python: "
which python
echo "Version: "
python --version
echo "Which Python3"
which python3
echo "Python3 Version: "
python3 --version
echo "Python ls: "
ls $PREFIX/bin/python
echo "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"

# Configure step
cmake -Bbuild -GNinja \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DPython_EXECUTABLE=${PYTHON} \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DPython_EXECUTABLE=$PREFIX/bin/python3 \
    -DBUILD_SHARED_LIBS=ON \
    -DMDI_Fortran=ON \
    -DMDI_Python=ON \
    -DMDI_CXX=ON \
    -DMDI_Python_PACKAGE=ON

# Build step
cmake --build build -j${CPU_COUNT}
cmake --install build
