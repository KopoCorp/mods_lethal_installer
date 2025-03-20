[Setup]
AppName=Kopo_mods_lethal_installer
AppVersion=1.2
DefaultDirName={commonpf}\Kopo
DefaultGroupName=Kopo_mods_lethal
OutputBaseFilename=Kopo_mods_lethal_installer
SetupIconFile=kopologo.ico
Compression=lzma
SolidCompression=yes

[Files]
Source: "kopo_mods_lethal.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "kopologo.ico"; DestDir: "{app}"; Flags: ignoreversion

; Installer le fichier LethalCompanyInstallLocation.txt dans AppData
Source: "LethalCompanyInstallLocation.txt"; DestDir: "{localappdata}\Kopo"; Flags: ignoreversion

[Run]
; Exécuter le fichier .exe compilé après l'installation
Filename: "{app}\kopo_mods_lethal.exe"; Flags: nowait postinstall

[Icons]
Name: "{group}\Kopo"; Filename: "{app}\kopo_mods_lethal.exe"; IconFilename: "{app}\kopologo.ico"
Name: "{group}\Uninstall Kopo"; Filename: "{uninstallexe}"

[UninstallDelete]
Type: files; Name: "{app}\kopo_mods_lethal.exe"
Type: files; Name: "{app}\kopologo.ico"
Type: files; Name: "{localappdata}\Kopo\LethalCompanyInstallLocation.txt"
