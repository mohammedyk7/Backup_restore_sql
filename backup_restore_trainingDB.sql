
CREATE TABLE Students ( 
    StudentID INT PRIMARY KEY, 
    FullName NVARCHAR(100), 
    EnrollmentDate DATE 
); 

INSERT INTO Students VALUES  
(1, 'Sara Ali', '2023-09-01'), 
(2, 'Mohammed Nasser', '2023-10-15');

--full backup--
BACKUP DATABASE TrainingDB 
TO DISK = 'C:\Users\Codeline\Downloads\TrainingDB.bak'

INSERT INTO Students VALUES (3, 'Fatma Said', '2024-01-10');

--Differential Backup 
BACKUP DATABASE TrainingDB TO DISK = 'C:\Users\Codeline\Downloads\TrainingDB1.bak' WITH DIFFERENTIAL;

-- First make sure Recovery Model is FULL 
ALTER DATABASE TrainingDB SET RECOVERY FULL; 
-- Now backup the log 
BACKUP LOG TrainingDB TO DISK = 'C:\Users\Codeline\Downloads\TrainingDB2.bak'; 
5. Copy-Only Backup 
BACKUP DATABASE TrainingDB TO DISK = 'C:\Users\Codeline\Downloads\TrainingDB3.bak' WITH 
COPY_ONLY; 
 
 
 --rstore--
 Step 1:
 --Drop the Current Database (Simulate System Failure) 
DROP DATABASE TrainingDB; 

-- Restore from Your Backups 
--Use the same file names and paths you used earlier. Replace them accordingly. 
-- 1. Restore FULL backup 

-- Set the database to single-user mode to force disconnect all users
ALTER DATABASE TrainingDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

-- Now restore the database
RESTORE DATABASE TrainingDB 
FROM DISK = 'C:\Users\Codeline\Downloads\TrainingDB.bak'
WITH REPLACE;

-- Disconnect all users first
ALTER DATABASE TrainingDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

-- Restore from the full backup
-- 2. Restore the FULL backup with RECOVERY
RESTORE DATABASE TrainingDB 
FROM DISK = 'C:\Users\Codeline\Downloads\TrainingDB1.bak'
WITH REPLACE, RECOVERY;
GO

-- Re-enable multi-user mode
ALTER DATABASE TrainingDB SET MULTI_USER;
--------------------------------------------------------------------------------------


-- Simulate disaster
DROP DATABASE TrainingDB;
GO

-- 1. Restore FULL backup first (leave it in restoring state)
RESTORE DATABASE TrainingDB 
FROM DISK = 'C:\Users\Codeline\Downloads\TrainingDB.bak' 
WITH NORECOVERY;
GO

-- 2. Restore DIFFERENTIAL backup
RESTORE DATABASE TrainingDB 
FROM DISK = 'C:\Users\Codeline\Downloads\TrainingDB1.bak' 
WITH NORECOVERY;
GO

-- 3. Optional: Restore TRANSACTION LOG backup
-- Only do this if you have a .trn or .bak log file
RESTORE LOG TrainingDB 
FROM DISK = 'C:\Users\Codeline\Downloads\TrainingDB2.bak' 
WITH NORECOVERY;
GO

-- 4. Final step: bring the DB online
RESTORE DATABASE TrainingDB WITH RECOVERY;
GO



SELECT name, state_desc
FROM sys.databases
WHERE name = 'TrainingDB';

USE TrainingDB;
SELECT * FROM Students;

(3, 'Fatma Said', '2024-01-10');
are not showing why ?



-- Step 1: Drop again and start from master
USE master;
GO

DROP DATABASE TrainingDB;
GO

-- Step 2: Restore full backup (NORECOVERY = stay in restoring mode)
RESTORE DATABASE TrainingDB 
FROM DISK = 'C:\Users\Codeline\Downloads\TrainingDB.bak' 
WITH NORECOVERY;
GO

-- Step 3: Restore differential backup (bring it online)
RESTORE DATABASE TrainingDB 
FROM DISK = 'C:\Users\Codeline\Downloads\TrainingDB1.bak' 
WITH RECOVERY;
GO


RESTORE DATABASE TrainingDB
FROM DISK = 'C:\Users\Codeline\Downloads\TrainingDB.bak'
WITH NORECOVERY;
GO

RESTORE DATABASE TrainingDB
FROM DISK = 'C:\Users\Codeline\Downloads\TrainingDB1.bak'
WITH RECOVERY;
GO

USE TrainingDB;
SELECT * FROM Students;
-- Check headers for full backup
RESTORE HEADERONLY 
FROM DISK = 'C:\Users\Codeline\Downloads\TrainingDB.bak';

-- Then check differential
RESTORE HEADERONLY 
FROM DISK = 'C:\Users\Codeline\Downloads\TrainingDB1.bak';
-----------------------------------------------------------------------------////////////////////////
USE master;
GO
DROP DATABASE IF EXISTS TrainingDB;
GO

CREATE DATABASE TrainingDB;
GO

USE TrainingDB;
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    EnrollmentDate DATE
);

INSERT INTO Students VALUES 
(1, 'Sara Ali', '2023-09-01'),
(2, 'Mohammed Nasser', '2023-10-15');



BACKUP DATABASE TrainingDB 
TO DISK = 'C:\Users\Codeline\Downloads\CleanFull.bak';

INSERT INTO Students VALUES (3, 'Fatma Said', '2024-01-10');

BACKUP DATABASE TrainingDB 
TO DISK = 'C:\Users\Codeline\Downloads\CleanDiff.bak' 
WITH DIFFERENTIAL;

-- Drop DB to simulate failure
USE master;
GO
DROP DATABASE TrainingDB;
GO

-- Restore the full backup first
RESTORE DATABASE TrainingDB
FROM DISK = 'C:\Users\Codeline\Downloads\CleanFull.bak'
WITH NORECOVERY;
GO

-- Restore the differential backup now
RESTORE DATABASE TrainingDB
FROM DISK = 'C:\Users\Codeline\Downloads\CleanDiff.bak'
WITH RECOVERY;
GO
USE TrainingDB;
SELECT * FROM Students;


