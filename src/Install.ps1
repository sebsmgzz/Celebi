# Imports
using module .\Config.psm1
Import-Module .\NeoHost.psm1

# Get config
$config = [InstallConfig]::new()
if(!$config.IsValid()) {
    NeoError 'Invalid install configuration, review config.json'
    NeoError 'Aborting'
    return
}

$currentPath = Split-Path $MyInvocation.MyCommand.Path -Parent
$action = New-ScheduledTaskAction `
    -Execute 'powershell.exe' `
    -Argument '.\Restore.ps1' `
    -WorkingDirectory $currentPath
$trigger = New-ScheduledTaskTrigger `
    -Weekly `
    -At $config.triggerTime `
    -DaysOfWeek $config.triggerDays
$executionLimit = New-TimeSpan -Hours 1 -Minutes 30
$settings = New-ScheduledTaskSettingsSet -WakeToRun -ExecutionTimeLimit $executionLimit
Register-ScheduledTask `
    -Action $action `
    -Trigger $trigger `
    -TaskName $config.taskName `
    -Description $config.taskDescription `
    -Settings $settings
