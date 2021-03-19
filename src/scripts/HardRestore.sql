-- =================================================
-- Hard restore
-- Performs a database restore given the backup file path and implicit metadata.
-- =================================================
-- [MyDatabase] The name of the database.
-- @BakPath The absolute path to the restore (.bak) file.

-- Change to master
USE master
GO
-- Setup
ALTER DATABASE [MyDatabase]
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
-- Initial declarations
DECLARE @BakPath NVARCHAR(500) = 'C:\MSSQL\Backup\Disposable_LogBackup_2021-03-08_12-58-52.bak'
DECLARE @LogicalName_L NVARCHAR(500);
DECLARE @PhysicalName_L NVARCHAR(500);
DECLARE @LogicalName_D NVARCHAR(500);
DECLARE @PhysicalName_D NVARCHAR(500);
DECLARE @RestoreStatement NVARCHAR(500) = CONCAT(N'RESTORE FILELISTONLY FROM DISK = ''', @BakPath, '''');
DECLARE @FileListTable TABLE (
	[LogicalName]           NVARCHAR(200),
	[PhysicalName]          NVARCHAR(200),
	[Type]                  CHAR(1),
	[FileGroupName]         NVARCHAR(128),
	[Size]                  NUMERIC(20,0),
	[MaxSize]               NUMERIC(20,0),
	[File]                  BIGINT,
	[CreateLSN]             NUMERIC(25,0),
	[DropLSN]               NUMERIC(25,0),
	[UniqueId]              UNIQUEIDENTIFIER,
	[ReadOnlyLSN]           NUMERIC(25,0),
	[ReadWriteLSN]          NUMERIC(25,0),
	[BackupSizeInBytes]     BIGINT,
	[SourceBlockSize]       INT,
	[FileGroupId]           INT,
	[LogGroupGUID]          UNIQUEIDENTIFIER,
	[DifferentialBaseLSN]   NUMERIC(25,0),
	[DifferentialBaseGUID]  UNIQUEIDENTIFIER,
	[IsReadOnly]            BIT,
	[IsPresent]             BIT,
	[TDEThumbprint]         VARBINARY(32), -- remove this column if using SQL 2005
	[SnapshotUrl]           NVARCHAR(500)
);
-- Get parameters
INSERT INTO @FileListTable EXEC(@RestoreStatement);
SELECT @LogicalName_L = [LogicalName] FROM @fileListTable WHERE [Type] = 'L';
SELECT @PhysicalName_L = [PhysicalName] FROM @fileListTable WHERE [Type] = 'L';
SELECT @LogicalName_D = [LogicalName] FROM @fileListTable WHERE [Type] = 'D';
SELECT @PhysicalName_D = [PhysicalName] FROM @fileListTable WHERE [Type] = 'D';

-- Make Restore
RESTORE DATABASE [MyDatabase] 
FROM DISK = @BakPath WITH REPLACE,
MOVE @LogicalName_L TO @PhysicalName_L,
MOVE @LogicalName_D TO @PhysicalName_D;
GO
