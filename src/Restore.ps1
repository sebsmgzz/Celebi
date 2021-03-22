# Imports
using module .\Config.psm1
Import-Module .\NeoHost.psm1
Import-Module BitsTransfer

# Get config
$meta = [MetaConfig]::new()
$config = [RestoreConfig]::new($meta.debug)
if(!$config.IsValid()) {
    NeoError 'Invalid restore configuration, review config.json'
    NeoError 'Aborting'
    return
}

# Move file
$sourcePath = $config.sourceDirectory + $config.fileName
$targetPath = $config.targetDirectory + $config.fileName
NeoInform ('> Coping ' + $sourcePath + ' to ' + $targetPath)
if(!(Test-Path $sourcePath)) {
    NeoError 'File not found, aborting'
    return
}
if(Test-Path ($targetPath)) {
    NeoInform '>> Overwritting file'
    if(!$config.overwrite) {
        NeoError 'File exists, either delete it or make override ''True'' in environment.'
        NeoError 'Aborting'
        return
    }
}
Start-BitsTransfer `    -Source $sourcePath `    -Destination $targetPath `    -Description 'Coping backup' `    -DisplayName $sourcePath
NeoSuccess ">> Success"

# Restore
NeoInform '> Restoring'
    try {
        $query = 'Use [master]
            GO
            ALTER DATABASE ' + $config.databaseName + `
            ' SET OFFLINE WITH ROLLBACK IMMEDIATE;'
        Invoke-Sqlcmd -ServerInstance $config.sqlServer -Query $query
        Restore-SqlDatabase `            -ServerInstance $config.sqlServer `            -Database $config.databaseName `            -BackupFile $targetPath `
            -ReplaceDatabase
        } catch [System.SystemException] {
            NeoError 'Error restoring database'
            NeoError $_.ScriptStackTrace
            Return
        }
NeoSuccess '>> Success'

# Display message
NeoRead “Press ENTER to finish...”
