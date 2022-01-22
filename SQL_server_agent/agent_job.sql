-- adding a new job category to the "NightlyBackups" job  
USE msdb ;  
GO  
EXEC dbo.sp_update_job  
    @job_name = N'NightlyBackups',  
    @category_name = N'[Uncategorized (Local)]';  
GO