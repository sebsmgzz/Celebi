﻿# Imports
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