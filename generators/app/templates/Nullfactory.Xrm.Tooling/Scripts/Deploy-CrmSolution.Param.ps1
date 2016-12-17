function GetUsername($solutionName)
{
  $variableName = "nfac_" + $solutionName + "_username"
  $username = [environment]::GetEnvironmentVariable($variableName, "User")

  if($username -eq $null)
  {
    $username = Read-Host "Set username for $solutionName"
    [environment]::SetEnvironmentVariable($variableName, $username,  "User")
  }
  return $username;
}

function GetPassword($solutionName)
{
  $variableName = "nfac_" + $solutionName + "_password"
  $plainTextPassword = [environment]::GetEnvironmentVariable($variableName, "User")

  if($plainTextPassword -eq $null)
  {
    $securePassword = Read-Host "Set password for $solutionName" -AsSecureString
    $plainTextPassword = (New-Object PSCredential "user", $SecurePassword).GetNetworkCredential().Password
    [environment]::SetEnvironmentVariable($variableName, $plainTextPassword,  "User")
  }
  return $plainTextPassword;
}

.\Deploy-CrmSolution.ps1 `
  -serverUrl "<%= crmServerUrl %>" `
  -username (GetUsername "<%= crmSolutionName %>") `
  -password (GetPassword "<%= crmSolutionName %>") `
  -solutionName "<%= crmSolutionName %>" `
  -publishChanges `
  -activatePlugins

# Include new entry for each CRM solution to be released manually

# .\Deploy-CrmSolution.ps1 `
#   -serverUrl "http://servername/secondary" `
#   -username (GetUsername "env_secondary_username_key") `
#   -password (GetPassword "env_secondary_password_key") `
#   -solutionName "secondary" `
#   -publishChanges `
#   -activatePlugins
