Write-Host
Write-Host "Checking admin permissions..."

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}


Write-Host
Write-Host "Disabling Chrome passwords..."

#paths for Edge policy keys used in the scripts
$chromepolicyexists = Test-Path "HKLM:\SOFTWARE\Policies\Google\Chrome"
$chromeRegKeysetup = "HKLM:\SOFTWARE\Policies\Google\Chrome"

#setup policy dirs in registry if needed and set pwd manager
#else sets them to the correct values if they exist
if ($chromepolicyexists -eq $false){
New-Item -path "HKLM:\SOFTWARE\Policies\Google"
New-Item -path $chromeRegKeysetup
New-ItemProperty -path $chromeRegKeysetup -Name PasswordManagerEnabled -PropertyType DWord -Value 0
Write-Host "Key not exists, creating..."
Write-Host "Success!"
} Else {
Set-ItemProperty -Path $chromeRegKeysetup -Name PasswordManagerEnabled -Value 0
Write-Host "Key exists, updating..."
Write-Host "Success!"
}

Write-Host
Write-Host "Disabling Firefox passwords..."

#paths for Firefox policy keys used in the scripts
$firefoxpolicyexists = Test-Path "HKLM:\SOFTWARE\Policies\Mozilla\Firefox"
$firefoxRegKeysetup = "HKLM:\SOFTWARE\Policies\Mozilla\Firefox"

#setup policy dirs in registry if needed and set pwd manager
#else sets them to the correct values if they exist
if ($firefoxpolicyexists -eq $false){
New-Item -path "HKLM:\SOFTWARE\Policies\Mozilla"
New-Item -path $firefoxRegKeysetup
New-ItemProperty -path $firefoxRegKeysetup -Name PasswordManagerEnabled -PropertyType DWord -Value 0
Write-Host "Key not exists, creating..."
Write-Host "Success!"
} Else {
Set-ItemProperty -Path $firefoxRegKeysetup -Name PasswordManagerEnabled -Value 0
Write-Host "Key exists, updating..."
Write-Host "Success!"
}

Write-Host
Write-Host "Disabling Edge passwords..."

#paths for Edge policy keys used in the scripts
$edgepolicyexists = Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
$edgeRegKeysetup = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"

#setup policy dirs in registry if needed and set pwd manager
#else sets them to the correct values if they exist
if ($edgepolicyexists -eq $false){
New-Item -path "HKLM:\SOFTWARE\Policies\Microsoft"
New-Item -path $edgeRegKeysetup
New-ItemProperty -path $edgeRegKeysetup -Name PasswordManagerEnabled -PropertyType DWord -Value 0
Write-Host "Key not exists, creating..."
Write-Host "Success!"
} Else {
Set-ItemProperty -Path $edgeRegKeysetup -Name PasswordManagerEnabled -Value 0
Write-Host "Key exists, updating..."
Write-Host "Success!"
}

Write-Host
Write-Host "Disabling Internet Explorer passwords..."

#paths for InternetExplorer policy keys used in the scripts
$iepolicyexists = Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer"
$ieRegKeysetup = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer"

#setup policy dirs in registry if needed and set pwd manager
#else sets them to the correct values if they exist
if ($iepolicyexists -eq $false){
New-Item -path $ieRegKeysetup
New-ItemProperty -path $ieRegKeysetup -Name NotifyDisableIEOptions -PropertyType DWord -Value 1
Write-Host "Key not exists, creating..."
Write-Host "Success!"
} Else {
Set-ItemProperty -Path $ieRegKeysetup -Name NotifyDisableIEOptions -Value 1
Write-Host "Key exists, updating..."
Write-Host "Success!"
}

# Wait for any interaction
Write-Host
CMD /c PAUSE