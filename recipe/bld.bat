mkdir build
cd build

cmake ^
    -G "Ninja" ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP=True ^
    -DUSE_SYSTEM_BACKWARDCPP:BOOL=ON ^
    %SRC_DIR%
if errorlevel 1 exit 1

:: Build.
cmake --build . --config Release
if errorlevel 1 exit 1

:: Install.
cmake --build . --config Release --target install
if errorlevel 1 exit 1

:: Test.
:: UNIT_ign_TEST timeouts in CI, see https://github.com/conda-forge/libignition-tools-feedstock/pull/12#issuecomment-980648328
ctest -VV -C Release -E "UNIT_ign_TEST"
if errorlevel 1 exit 1
