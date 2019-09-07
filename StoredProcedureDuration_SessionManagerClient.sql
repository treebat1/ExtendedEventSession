CREATE EVENT SESSION [StoredProcedureDurationNike] ON SERVER 
ADD EVENT sqlserver.rpc_completed(SET collect_statement=(1)
    ACTION(package0.collect_system_time,sqlserver.query_hash,sqlserver.query_plan_hash)
    WHERE ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'Nike') 
	AND [sqlserver].[like_i_sql_unicode_string]([object_name],N'%Get_Subject_Profile%') AND [package0].[greater_than_uint64]([duration],(100000)) 
	AND [package0].[greater_than_uint64]([row_count],(1))))
ADD TARGET package0.event_file(SET filename=N'StoredProcedureDurationNike.xel',max_rollover_files=(5))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE
,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO


