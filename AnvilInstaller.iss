; Setup Metadata
[Setup]
AppName=Anvil App Server
AppVersion=1.0
DefaultDirName=C:\AnvilAppServer
DefaultGroupName=Anvil App Server
OutputDir=.
OutputBaseFilename=AnvilAppServerInstaller
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin

; Include Necessary Files
[Files]
Source: "python-3.13.1-amd64.exe"; DestDir: "{tmp}"; Flags: ignoreversion
Source: "Git-2.47.1-64-bit.exe"; DestDir: "{tmp}"; Flags: ignoreversion
Source: "amazon-corretto-21.0.5.11.1-windows-x64.msi"; DestDir: "{tmp}"; Flags: ignoreversion
Source: "vcredist_x64.exe"; DestDir: "{tmp}"; Flags: ignoreversion
Source: "nssm.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "install.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "uninstall.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "run.bat"; DestDir: "{app}"; Flags: ignoreversion

; Installation Steps
[Run]
; Install Python silently
Filename: "{tmp}\python-3.13.1-amd64.exe"; Parameters: "/quiet InstallAllUsers=1 PrependPath=1"; Flags: waituntilterminated

; Install Git silently
Filename: "{tmp}\Git-2.47.1-64-bit.exe"; Parameters: "/SILENT"; Flags: waituntilterminated

; Install Amazon Corretto silently
Filename: "msiexec.exe"; Parameters: "/i {tmp}\amazon-corretto-21.0.5.11.1-windows-x64.msi /quiet"; Flags: waituntilterminated

; Install Visual C++ Redistributable silently
Filename: "{tmp}\vcredist_x64.exe"; Parameters: "/quiet /norestart"; Flags: waituntilterminated

; Shortcuts
[Icons]
Name: "{group}\Run Anvil App Server"; Filename: "{app}\run.bat"
Name: "{group}\Install Service"; Filename: "{app}\install.bat"
Name: "{group}\Uninstall Service"; Filename: "{app}\uninstall.bat"
Name: "{group}\Uninstall Anvil App Server"; Filename: "{uninstallexe}"

; Clean Up During Uninstallation
[UninstallDelete]
Type: filesandordirs; Name: "{app}"

; Custom Wizard Pages for Password and Project Name
[Code]
var
  UserInputPage: TInputQueryWizardPage;

procedure ReplaceTextInFile(const FilePath, SearchText, ReplaceText: string);
var
  FileLines: TArrayOfString;
  I: Integer;
begin
  if FileExists(FilePath) then
  begin
    if LoadStringsFromFile(FilePath, FileLines) then
    begin
      for I := 0 to GetArrayLength(FileLines) - 1 do
        StringChangeEx(FileLines[I], SearchText, ReplaceText, True);
      SaveStringsToFile(FilePath, FileLines, False);
    end;
  end;
end;

procedure InitializeWizard;
begin
  { Create the input page for password and project name }
  UserInputPage := CreateInputQueryPage(wpWelcome, 'Anvil App Server Setup',
    'Windows User and Project Configuration',
    'Provide the following details to complete the setup:' + #13#10 +
    '1. Enter the password for the "anvil-user" Windows account.' + #13#10 +
    '2. Enter the name of your Anvil project.' + #13#10 +
    'Note: If "anvil-user" does not exist, you must create it after installation.' + #13#10 +
    'These settings can also be modified later by editing the "install.bat" and "run.bat" files.');

  { Add input fields }
  UserInputPage.Add('Password for "anvil-user" Windows account:', True); // Mask the password
  UserInputPage.Add('Anvil Project Name:', False); // Project name
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  Password, ProjectName: string;
begin
  if CurStep = ssPostInstall then
  begin
    { Retrieve inputs }
    Password := UserInputPage.Values[0];
    ProjectName := UserInputPage.Values[1];

    { Update install.bat with the entered password }
    ReplaceTextInFile(ExpandConstant('{app}\install.bat'), 'PLACEHOLDER_PASSWORD', Password);

    { Update run.bat with the entered project name }
    ReplaceTextInFile(ExpandConstant('{app}\run.bat'), 'PLACEHOLDER_PROJECT_NAME', ProjectName);

    MsgBox('Setup complete! Please ensure the "anvil-user" Windows account exists. ' +
      'If not, create it manually. You can modify settings by editing the "install.bat" and "run.bat" files.',
      mbInformation, MB_OK);
  end;
end;
