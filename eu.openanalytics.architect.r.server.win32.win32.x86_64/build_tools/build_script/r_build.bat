set rToolsDir=%CD%\build_tools\rtools40
set buildSriptDir=%CD%\build_tools\build_script
set projectBaseDir=%CD%

rem %rToolsDir%\msys2.exe %buildSriptDir%\quick-build.sh

%rToolsDir%\msys2_shell.cmd -no-start -defterm "%buildSriptDir%/quick-build.sh"