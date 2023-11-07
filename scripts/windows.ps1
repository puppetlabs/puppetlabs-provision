# This is a PowerShell script that will install the Puppet agent on a Windows node.
# It is intended to be used with the Puppet Enterprise Orchestrator.

if (Test-Path "C:\Program Files\Puppet Labs\Puppet\puppet\bin\puppet"){
  Write-Host "ERROR: Puppet agent is already installed. Re-install, re-configuration, or upgrade not supported. Please uninstall the agent before running this task."
  Exit 1
}

# Set the hostname of server to the name of the node
Rename-Computer -NewName ${hostname}

try {
  [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}; $webClient = New-Object System.Net.WebClient; $webClient.DownloadFile("https://${pe_server}:8140/packages/current/install.ps1", 'install.ps1'); powershell.exe  .\install.ps1 -verbose
}
catch {
  Write-Host "Installer failed with Exception: $_.Exception.Message"
  Exit 1
}
