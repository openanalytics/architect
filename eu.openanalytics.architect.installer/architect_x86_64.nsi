!define MULTIUSER_EXECUTIONLEVEL Standard
!define MULTIUSER_MUI
!define MULTIUSER_INSTALLMODE_INSTDIR Architect

!include MultiUser.nsh
!include MUI2.nsh
!include LogicLib.nsh
!include x64.nsh

Function .onInit
  !insertmacro MULTIUSER_INIT
FunctionEnd

Function un.onInit
  !insertmacro MULTIUSER_UNINIT
FunctionEnd

Function setDirX64
  ${If} $INSTDIR == "$PROGRAMFILES\${MULTIUSER_INSTALLMODE_INSTDIR}"
	StrCpy $INSTDIR "$PROGRAMFILES64\${MULTIUSER_INSTALLMODE_INSTDIR}"
  ${EndIf}
FunctionEnd

Function un.isEmptyDir
  # Stack ->                    # Stack: <directory>
  Exch $0                       # Stack: $0
  Push $1                       # Stack: $1, $0
  FindFirst $0 $1 "$0\*.*"
  strcmp $1 "." 0 _notempty
    FindNext $0 $1
    strcmp $1 ".." 0 _notempty
      ClearErrors
      FindNext $0 $1
      IfErrors 0 _notempty
        FindClose $0
        Pop $1                  # Stack: $0
        StrCpy $0 1
        Exch $0                 # Stack: 1 (true)
        goto _end
     _notempty:
       FindClose $0
       ClearErrors
       Pop $1                   # Stack: $0
       StrCpy $0 0
       Exch $0                  # Stack: 0 (false)
  _end:
FunctionEnd

;--------------------------------
Name "Architect"
OutFile "setup_x86_64.exe"
InstallDir "Architect"

;--------------------------------
!define MUI_ICON "architect_48.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "architect.bmp"
!define MUI_ABORTWARNING

;--------------------------------
;Pages

!insertmacro MUI_PAGE_WELCOME
!define MUI_PAGE_CUSTOMFUNCTION_PRE setDirX64
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Architect" SecInstall

  SetOutPath $INSTDIR
  
  ; Unzip program files
  File /r architect_x86_64\*.*

  ; Create Desktop & Start Menu shortcuts
  CreateShortCut "$DESKTOP\Architect.lnk" "$INSTDIR\architect.exe" ""
  CreateDirectory "$SMPROGRAMS\Architect"
  CreateShortCut "$SMPROGRAMS\Architect\Architect.lnk" "$INSTDIR\architect.exe"
  CreateShortCut "$SMPROGRAMS\Architect\Uninstall Architect.lnk" "$INSTDIR\uninstall.exe"

  ; Give full control to everyone. Required for updates and temp folder usage.
  ; AccessControl::GrantOnFile "$INSTDIR" "(BU)" "FullAccess"
  
  ; Write registry keys for uninstallation
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Architect" "DisplayName" "Architect (remove only)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Architect" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteUninstaller "$INSTDIR\uninstall.exe"

SectionEnd

;--------------------------------
;Descriptions

LangString DESC_SecInstall ${LANG_ENGLISH} "The Architect Application"

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SecInstall} $(DESC_SecInstall)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  RMDir /r "$INSTDIR\configuration"
  RMDir /r "$INSTDIR\features"
  RMDir /r "$INSTDIR\p2"
  RMDir /r "$INSTDIR\plugins"
  RMDir /r "$INSTDIR\readme"
  RMDir /r "$INSTDIR\workspace"
  delete "$INSTDIR\architect.exe"
  delete "$INSTDIR\architect.ini"
  delete "$INSTDIR\artifacts.xml"
  delete "$INSTDIR\epl-v10.html"
  delete "$INSTDIR\notice.html"
  delete "$INSTDIR\.eclipseproduct"
  delete "$INSTDIR\uninstall.exe"
      
  RMDir /r "$SMPROGRAMS\Architect"
  delete "$DESKTOP\Architect.lnk"

  Push "$INSTDIR"
	Call un.isEmptyDir
  Pop $0
  StrCmp $0 1 0 +2
    RMDir "$INSTDIR"
SectionEnd