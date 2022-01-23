USE msdb;  
GO  
--  Adds a new job, executed by the SQL Server Agent service, called "HistoryCleanupTask_1".  
EXEC dbo.sp_add_job  
   @job_name = N'HistoryCleanupTask_1',   
   @enabled = 1,   
   @description = N'Clean up old task history' ;   
GO  
-- Adds a job step for reorganizing all of the indexes in the HumanResources.Employee table to the HistoryCleanupTask_1 job.   
EXEC dbo.sp_add_jobstep  
    @job_name = N'HistoryCleanupTask_1',   
    @step_name = N'Reorganize all indexes on HumanResources.Employee table',   
    @subsystem = N'TSQL',   
    @command = N'USE AdventureWorks2012  
GO  
ALTER INDEX AK_Employee_LoginID ON HumanResources.Employee REORGANIZE WITH ( LOB_COMPACTION = ON )   
GO  
USE AdventureWorks2012  
GO  
ALTER INDEX AK_Employee_NationalIDNumber ON HumanResources.Employee REORGANIZE WITH ( LOB_COMPACTION = ON )   
GO  
USE AdventureWorks2012  
GO  
ALTER INDEX AK_Employee_rowguid ON HumanResources.Employee REORGANIZE WITH ( LOB_COMPACTION = ON )   
GO  
USE AdventureWorks2012  
GO  
ALTER INDEX IX_Employee_OrganizationLevel_OrganizationNode ON HumanResources.Employee REORGANIZE WITH ( LOB_COMPACTION = ON )   
GO  
USE AdventureWorks2012  
GO  
ALTER INDEX IX_Employee_OrganizationNode ON HumanResources.Employee REORGANIZE WITH ( LOB_COMPACTION = ON )   
GO  
USE AdventureWorks2012  
GO  
ALTER INDEX PK_Employee_BusinessEntityID ON HumanResources.Employee REORGANIZE WITH ( LOB_COMPACTION = ON )   
GO  
',   
    @retry_attempts = 5,   
    @retry_interval = 5 ;   
GO  
-- Creates a schedule named RunOnce that executes every day when the time on the server is 23:00.   
EXEC dbo.sp_add_schedule  
    @schedule_name = N'RunOnce',   
    @freq_type = 4,   
    @freq_interval = 1,   
    @active_start_time = 233000 ;   
GO  
-- Attaches the RunOnce schedule to the job HistoryCleanupTask_1.   
EXEC sp_attach_schedule  
   @job_name = N'HistoryCleanupTask_1',  
   @schedule_name = N'RunOnce' ;   
GO