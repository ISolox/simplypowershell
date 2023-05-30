# This is a very basic, unprofessional way to unmount EXT4 drives using WSL. This was created as a companion to the mount script located at: https://github.com/ISolox/simplypowershell/edit/main/WSL/MountEXT4.ps1

#Change \\.\PHYSICALDRIVE1 to the EXT4 drive listed by entering "GET-CimInstance -query "SELECT * from Win32_DiskDrive" in PowerShell if needed:

$EXT4Drive = "\\.\PHYSICALDRIVE1"


#The following below prompts UAC to run as Administrator
Function Check-RunAsAdministrator()
{

  $CurrentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  

  if($CurrentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
  {
       Write-host "Script is running with Administrator privileges!"
  }
  else
    {

       $ElevatedProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";

       $ElevatedProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"

       $ElevatedProcess.Verb = "runas"

       [System.Diagnostics.Process]::Start($ElevatedProcess)

       Exit
 
    }
}

Check-RunAsAdministrator
 
#The actual command:
wsl --unmount \\.\PHYSICALDRIVE1
pause
