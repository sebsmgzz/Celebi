-- =================================================
-- Soft restore
-- Performs a database restore given the provided restore file and explicit metadata.
-- =================================================
-- [MyDatabase] The name of the database.
-- @BakPath The absolute path to the restore (.bak) file.
-- @MetaLogicalName The logical name of the meta (.mdf) file.
-- @MetaPath The absolute path to the meta (.mdf) file.
-- @LogLogicalName The logical name of the log (.ldf) file.
-- @LogPath The absolute path to the log (.ldg) file.

-- Change to master
USE master
GO
-- Parameters declarations
DECLARE @BakPath NVARCHAR(500) = 'C:\MSSQL\Backup\MyDatabase_LogBackup_2021-03-08_12-58-52.bak';
DECLARE @MetaLogicalName NVARCHAR(500) = 'MyDatabase';
DECLARE @MetaPath NVARCHAR(500) = 'C:\MSSQL\DATA\MyDatabase.mdf';
DECLARE @LogicalName_D NVARCHAR(500) = 'MyDatabase_log';
DECLARE @LogPath NVARCHAR(500) = 'C:\MSSQL\DATA\MyDatabase_log.ldf';
-- Setup
ALTER DATABASE [MyDatabase]
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE
-- Execute restore
RESTORE DATABASE [MyDatabase] 
FROM DISK = @BakPath WITH REPLACE,
MOVE @MetaLogicalName TO @MetaPath,
MOVE @LogicalName_D TO @LogPath;
GO
