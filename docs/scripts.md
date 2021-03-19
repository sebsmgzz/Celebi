# Celebi

Scripts
-------

### Soft restore
Soft restore performs a database restore given the provided restore file and explicit metadata. Internally, it takes the provided backup and metadata files to perform the restore. It changes the used target database to `master` by default, in order to perform the restore properly.

#### How to use:
1. Load the `SoftRestore.sql` script.
2. Replace the *[MyDatabase]* parameter.
   + Line 22: ALTER DATABASE *[MyDatabase]*
   + Line 26: RESTORE DATABASE *[MyDatabase]*
3. Replace the variables declarations.
   + *@BakPath* The absolute path to the restore (.bak) file
   + *@MetaLogicalName* The logical name of the meta (.mdf) file
   + *@MetaPath* The absolute path to the meta (.mdf) file
   + *@LogLogicalName* The logical name of the log (.ldf) file
   + *@LogPath* The absolute path to the log (.ldg) file
4. Execute

### Hard restore
Hard restore performs a database restore given the backup file path and implicit metadata. Internally, it looks up and stores on a temporaly table the additional metadata locations from the given backup file path. With that data it goes on and perform the restore. It changes the used target database to `master` by default, in order to perform the restore properly.

#### How to use:
1. Load the `HardRestore.sql` script.
2. Replace the *[MyDatabase]* parameter.
   + Line 12: ALTER DATABASE *[MyDatabase]*
   + Line 54: RESTORE DATABASE *[MyDatabase]*
3. Replace the variables declarations.
   + *@BakPath* The absolute path to the restore (.bak) file.
4. Execute

Schedule a job
--------------
If you are using SQL Server Manager Studio you can schedule a job with the `HardRestore.sql` script to automate the restore of your database.

#### How to:
1. Create a new Job in SSMS.<br>
![NewJob](/docs/images/NewJob.png)
1. Navigate to *Select a page* > *Steps* > *New...*
2. Add your `HardRestore.sql` script with the proper parameters replacements.<br>
![AddHardRestore](/docs/images/AddHardRestore.png)
3. Navigate to *Select a page* > *Schedules* > *New...* and configure as desired.
4. Click *Ok* and test by right clicking your job and then *Start Job at Step...*<br>
![TestJob](/docs/images/TestJob.png)

Help
----
To retrieve the metadata files to be used with soft restore, you can use the `RestoreHelp.sql` script. This scripts returns a result set providing all the information for the corresponding files.

#### How to use:
1. Load the `RestoreHelp.sql` script.
2. Replace the variables declarations.
   + *@BakPath* The absolute path to the restore (.bak) file.
3. Execute
