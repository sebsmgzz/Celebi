Import-Module .\Utilities.psm1

function GetConfig {
    [CmdletBinding()]
    param([Parameter(Mandatory=$true)][String] $type)
    $json = Get-Content .\config.json | ConvertFrom-Json
    switch($type) {
        'meta' { return $json.meta }
        'install' { return $json.install }
        'restore' { return $json.restore }
    }
    return $null
}

class MetaConfig {

    [String]$version
    [Boolean]$debug = $true

    MetaConfig() {
        $config = GetConfig('meta')
        $this.version = $config.version
        $this.debug = StrToBool $config.debug
    }

}

class InstallConfig {

    [String]$taskName = 'CelebiRestoreTask'
    [String]$taskDescription = 'Restore database'
    [DateTime]$triggerTime
    [System.Collections.ArrayList]$triggerDays

    InstallConfig() {
        $config = GetConfig('install')
        $this.taskName = $config.taskName
        $this.taskDescription = $config.taskDescription
        $this.triggerTime  = [DateTime] $config.triggerTime
        $this.triggerDays = [System.Collections.ArrayList]::new()
        foreach($day in $config.triggerDays) {
            $this.thiggerDays.Add($day)
        }
    }
        
    [Boolean] IsValid() {
        return !($this.triggerTime.Equals($null))
    }

}

class RestoreConfig {

    [String]$dateFormat = 'yyyy-MM-dd'
    [Boolean]$noWeekends = $false
    [String]$targetDirectory
    [String]$sourceDirectory
    [String]$fileName
    [switch]$overwrite = $false
    [String]$sqlServer = 'localhost'
    [String]$databaseName = 'db'

    RestoreConfig([Boolean]$asTest) {
        $json = GetConfig('restore')
        $config = $json.main
        if($asTest) {
            $config = $json.test
        }
        $this.dateFormat = $config.dateFormat
        $this.noWeekends = $config.noWeekends
        $this.targetDirectory = ReplaceDates $config.targetDirectory $this.dateFormat $this.noWeekends
        $this.sourceDirectory = ReplaceDates $config.sourceDirectory $this.dateFormat $this.noWeekends
        $this.fileName = ReplaceDates $config.fileName $this.dateFormat $this.noWeekends
        $this.overwrite = StrToBool $config.overwrite
        $this.sqlServer = $config.sqlServer
        $this.databaseName = $config.databaseName
    }

    [Boolean] IsValid() {
        return $this.targetDirectory -and $this.sourceDirectory -and $this.fileName
    }

}