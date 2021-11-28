New-LocalUser "ansible" -Password (ConvertTo-SecureString -AsPlainText -Force '') -AccountNeverExpires:$true -PasswordNeverExpires:$true -FullName "ansible" | Add-LocalGroupMember -Group administrators



[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file

Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools
