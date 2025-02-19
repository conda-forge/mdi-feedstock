#/usr/bin/env bash

set -ex

export PATH=$BUILD_PREFIX/bin:$PATH  # Ensure conda python is used

echo "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
echo "Python: ${PYTHON}"
echo "Version: "
python --version
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
