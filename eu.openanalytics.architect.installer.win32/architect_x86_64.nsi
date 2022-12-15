!include MUI2.nsh
!include LogicLib.nsh
!include x64.nsh

RequestExecutionLevel highest

Function .onInit
  UserInfo::GetAccountType
  Pop $1
  Call supportsShortPaths
  Pop $2
  IfSilent +6
    ${if} "$1" == "Admin"
    ${andif} "$2" == "1"
	  StrCpy $INSTDIR "$PROGRAMFILES64\Architect"
	${else}
	  StrCpy $INSTDIR "$LOCALAPPDATA\Architect"
	${endif}
  ${if} "$INSTDIR" == ""
    ${if} "$1" == "Admin"
    ${andif} "$2" == "1"
	  StrCpy $INSTDIR "$PROGRAMFILES64\Architect"
	${else}
	  StrCpy $INSTDIR "$LOCALAPPDATA\Architect"
	${endif}
  ${endif}
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

Function supportsShortPaths
 Push $0
 GetFullPathName /SHORT $0 $PROGRAMFILES64
 
 #MessageBox MB_OK "$0"
 Push $0
 Call checkForSpaces
 Pop $0

 ${if} "$0" == "0"
   StrCpy $0 1
 ${else}
   StrCpy $0 0
 ${endif}
 Exch $0
FunctionEnd

Function checkForSpaces
 Exch $0
 Push $1
 Push $2
 Push $3
 StrCpy $1 -1
 StrCpy $3 $0
 StrCpy $0 0
 loop:
   StrCpy $2 $3 1 $1
   IntOp $1 $1 - 1
   StrCmp $2 "" done
   StrCmp $2 " " 0 loop
   IntOp $0 $0 + 1
 Goto loop
 done:
 Pop $3
 Pop $2
 Pop $1
 Exch $0
FunctionEnd

Function onDirectoryLeave
 
  Call supportsShortPaths
  Pop $0
  StrCmp $0 1 NoSpaces
  
  Push $INSTDIR
  Call checkForSpaces
  Pop $0
  StrCmp $0 0 NoSpaces
 
  StrCmp $0 1 0 +3
    StrCpy $1 ""
  Goto +2
    StrCpy $1 "s"
 
  MessageBox MB_OK|MB_ICONEXCLAMATION "If you install Architect into a path with spaces on this system, R will not function properly."
  Abort
 
  NoSpaces:
 
FunctionEnd

;--------------------------------
Name "Architect"
OutFile "setup.exe"

;--------------------------------
!define MUI_ICON "architect_48.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "architect.bmp"
!define MUI_ABORTWARNING
;--------------------------------
;Pages

!insertmacro MUI_PAGE_WELCOME
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE "onDirectoryLeave"
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
  File /r f\*.*

  ; Create Desktop & Start Menu shortcuts
  CreateShortCut "$DESKTOP\Architect.lnk" "$INSTDIR\architect.exe" ""
  CreateDirectory "$SMPROGRAMS\Architect"
  CreateShortCut "$SMPROGRAMS\Architect\Architect.lnk" "$INSTDIR\architect.exe"
  CreateShortCut "$SMPROGRAMS\Architect\Uninstall Architect.lnk" "$INSTDIR\uninstall.exe"

  ; Give full control to everyone. Required for updates and temp folder usage.
  ; AccessControl::GrantOnFile "$INSTDIR" "(BU)" "FullAccess"
  
  ; Write registry keys for file association
  WriteRegStr HKCR ".r" "" "ArchitectFile"
  WriteRegStr HKCR ".rnw" "" "ArchitectFile"
  WriteRegStr HKCR ".rda" "" "ArchitectFile"
  WriteRegStr HKCR ".rdata" "" "ArchitectFile"
  WriteRegStr HKCR "ArchitectFile" "" "Architect File"
  WriteRegStr HKCR "ArchitectFile\DefaultIcon" "" "$INSTDIR\architect.exe"
  WriteRegStr HKCR "ArchitectFile\shell\Open\Command" "" '"$INSTDIR\architect.exe" "%1"'
    
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
  delete "$INSTDIR\epl-v20.html"
  delete "$INSTDIR\notice.html"
  delete "$INSTDIR\.eclipseproduct"
  delete "$INSTDIR\uninstall.exe"
  delete "$INSTDIR\eclipsec.exe"
      
  RMDir /r "$SMPROGRAMS\Architect"
  delete "$DESKTOP\Architect.lnk"

  Push "$INSTDIR"
	Call un.isEmptyDir
  Pop $0
  StrCmp $0 1 0 +2
    RMDir "$INSTDIR"
SectionEnd