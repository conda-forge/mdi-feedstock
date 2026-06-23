#/usr/bin/env bash

set -ex

if [ "${mpi}" == "nompi" ]; then
  MDI_MPI=OFF
else
  MDI_MPI=ON
fi

# Configure step
cmake -Bbuild -GNinja \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DPython_EXECUTABLE=${PYTHON} \
    -DBUILD_SHARED_LIBS=ON \
    -DMDI_Fortran=ON \
    -DMDI_Python=ON \
    -DMDI_CXX=ON \
    -DMDI_USE_MPI=${MDI_MPI} \
    -DMDI_Python_PACKAGE=ON

# Build step
cmake --build build -j${CPU_COUNT}
cmake --install build
