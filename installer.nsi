; Laplace Windows Installer Script
; NSIS Modern User Interface

!include "MUI2.nsh"

; General
Name "Laplace"
OutFile "laplace-setup.exe"
InstallDir "$PROGRAMFILES\Laplace"
InstallDirRegKey HKLM "Software\Laplace" "InstallDir"
RequestExecutionLevel admin

; Interface Settings
!define MUI_ABORTWARNING

; Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; Languages
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Russian"

; Installer Section
Section "Install"
    SetOutPath "$INSTDIR"

    ; Copy main executable
    File "laplace.exe"

    ; Copy additional files
    SetOutPath "$INSTDIR\files"
    File /r "files\*.*"

    ; Write registry keys
    WriteRegStr HKLM "Software\Laplace" "InstallDir" "$INSTDIR"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Laplace" "DisplayName" "Laplace"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Laplace" "UninstallString" '"$INSTDIR\uninstall.exe"'
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Laplace" "InstallLocation" "$INSTDIR"
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Laplace" "NoModify" 1
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Laplace" "NoRepair" 1

    ; Create uninstaller
    WriteUninstaller "$INSTDIR\uninstall.exe"

    ; Create Start Menu shortcuts
    CreateDirectory "$SMPROGRAMS\Laplace"
    CreateShortcut "$SMPROGRAMS\Laplace\Laplace.lnk" "$INSTDIR\laplace.exe"
    CreateShortcut "$SMPROGRAMS\Laplace\Uninstall.lnk" "$INSTDIR\uninstall.exe"
SectionEnd

; Uninstaller Section
Section "Uninstall"
    ; Remove files
    Delete "$INSTDIR\laplace.exe"
    Delete "$INSTDIR\uninstall.exe"
    RMDir /r "$INSTDIR\files"
    RMDir "$INSTDIR"

    ; Remove Start Menu shortcuts
    Delete "$SMPROGRAMS\Laplace\Laplace.lnk"
    Delete "$SMPROGRAMS\Laplace\Uninstall.lnk"
    RMDir "$SMPROGRAMS\Laplace"

    ; Remove registry keys
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Laplace"
    DeleteRegKey HKLM "Software\Laplace"
SectionEnd
