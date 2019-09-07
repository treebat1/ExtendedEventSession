CREATE EVENT SESSION [StoredProcedureDurationHomeDepotCA] ON SERVER 
ADD EVENT sqlserver.rpc_completed(SET collect_statement=(1)
    ACTION(package0.collect_system_time,sqlserver.database_name)
    WHERE ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'HomeDepotCA') 
	AND [sqlserver].[like_i_sql_unicode_string]([object_name],N'%Get_Subject_Profile_by_Scheme%') 
	AND [package0].[greater_than_equal_uint64]([duration],(100000)))),
ADD EVENT sqlserver.sql_batch_completed(SET collect_batch_text=(1)
    ACTION(package0.collect_system_time,sqlserver.database_name)
    WHERE ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'HomeDepotCA') 
	AND [sqlserver].[like_i_sql_unicode_string]([batch_text],N'%Get_Subject_Profile_by_Scheme%') 
	AND [package0].[greater_than_equal_uint64]([duration],(100000))))
ADD TARGET package0.event_file(SET filename=N'StoredProcedureDurationHomeDepotCA.xel',max_rollover_files=(5))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO


