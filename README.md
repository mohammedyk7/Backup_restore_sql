# SQL Server Backup, Restore & Security Tasks

This project includes a set of scripts and documentation I worked on to practice and demonstrate key SQL Server skills — specifically around backing up and restoring databases, as well as managing access control at the schema level.

## What's Inside

- `backup_restore_trainingDB.sql`  
  A complete script for backing up the TrainingDB (both full and differential) and restoring it using the correct options.

- `TrainingDB_Final_ErrorLog.txt`  
  A log file that captures the actual errors and issues encountered during the backup/restore process.

- `security_level_task_companyDB.sql`  
  SQL code to set up users and control access by schema — making sure HR and Sales users can only access their own data.

- `companyDB_report.pdf`  
  A final report that includes screenshots of each step, SQL output, and a brief explanation of what was done and why.

## What This Covers

### Backup & Restore
- Full and differential backup commands
- Using `MOVE` and `REPLACE` during restore
- Common mistakes and how to fix them

### Security
- Creating SQL logins and mapping them to users
- Setting up permissions per schema
- Verifying access restrictions through real queries

## How to Use It

1. Open the `.sql` files in SQL Server Management Studio (SSMS).
2. Run the backup/restore script on a test database (like TrainingDB).
3. Use the security script on a sample CompanyDB to simulate user access.
4. If you're curious about what to expect, open the PDF report for full walkthroughs and screenshots.

## About This Task

This work was part of a training task focused on real-world database administration skills. It shows how to:
- Perform controlled backups and restores
- Handle errors effectively
- Set up secure, organized access based on departments

## Author

Mohammed alkhusaibi 
GitHub: [github.com/mohammedyk7](https://github.com/mohammedyk7)
