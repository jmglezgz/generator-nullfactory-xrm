
[CmdletBinding(DefaultParameterSetName = "Internal")]
param(
    [Parameter(Mandatory = $true, Position = 1)]
    [ValidateSet('https://admin.services.crm.dynamics.com', 
        'https://admin.services.crm9.dynamics.com',
        'https://admin.services.crm4.dynamics.com',
        'https://admin.services.crm5.dynamics.com',
        'https://admin.services.crm6.dynamics.com',
        'https://admin.services.crm7.dynamics.com',
        'https://admin.services.crm2.dynamics.com',
        'https://admin.services.crm8.dynamics.com',
        'https://admin.services.crm3.dynamics.com',
        'https://admin.services.crm11.dynamics.com')]
    [string]$apiUrl,
    [Parameter(Mandatory = $true, Position = 2)]
    [string]$username,
    [Parameter(Mandatory = $true, Position = 3)]
    [string]$password,
    [guid]$instanceId,
    [string]$friendlyName,
    [string]$uniqueName,
    [string]$backupLabel,
    [string]$backupNotes
)

# Importing common functions
. .\CrmInstance.Common.ps1
Init-OmapiModule $username $password

# if a backup label is not provided, generate one
if (-Not $backupLabel) {
    $backupLabel = Get-Date -Format "G"
    Write-Verbose -Message "Backup label not provided, defaulting it to $backupLabel"
}

# if an instance id is not provided then attempt to use the aliases
if(-Not $instanceId)
{
    $instanceId = Get-CrmInstanceByName $apiUrl $creds $friendlyName $uniqueName
}

Write-Verbose "InstanceId $instanceId"

$backupInfoRequest = New-CrmBackupInfo -InstanceId $instanceId -Label $backupLabel -Notes $backupNotes
$backupJob = Backup-CrmInstance -ApiUrl $apiUrl -Credential $creds -BackupInfo $backupInfoRequest

$backupOperationId = $backupJob.OperationId 
$backupOperationStatus = $backupJob.Status

Write-Host "OperationId: $backupOperationId Status: $backupOperationStatus"

Wait-CrmOperation $apiUrl $creds $backupOperationId
 
Write-Host "Create backup operation timed out."
exit 1