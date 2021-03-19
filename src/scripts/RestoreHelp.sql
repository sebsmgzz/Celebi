-- =================================================
-- Restore help
-- Returns the location of the restore files.
-- =================================================
-- @BakPath The absolute path to the restore (.bak) file.

DECLARE @BakPath NVARCHAR(150) = 'C:\MSSQL\Backup\MyDatabase_LogBackup_2021-03-08_12-58-52.bak';
RESTORE FILELISTONLY FROM DISK = @BakPath;
GO
