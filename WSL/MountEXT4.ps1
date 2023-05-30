#This script is a very basic way to mount EXT4 drives in Windows via WSL. This is a very jank scipt and not professional at all.
#I created this to use on external drive between a Windows 11 system and a Steam Deck, but it should work with other EXT4 drives.

#The drive will be accessed like a network share with the following path (unless modified previously by user):
# \\wsl.localhost\LINUXDISTROHERE\mnt\wsl\YOURDRIVEHERE

#Change \\.\PHYSICALDRIVE1 to the EXT4 drive listed by entering "GET-CimInstance -query "SELECT * from Win32_DiskDrive" in PowerShell if needed:

$EXT4Drive = "\\.\PHYSICALDRIVE1"

#Link to the Unmount script: https://github.com/ISolox/simplypowershell/edit/main/WSL/UnmountEXT4.ps1

#This gives a UAC prompt to run as an Administrator:
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

#The actual mount command:
wsl --mount $EXT4Drive --partition 1
pause
