CREATE EVENT SESSION [QueryWaitStatisticsPier1] ON SERVER 
ADD EVENT sqlserver.sp_statement_completed(SET collect_object_name=(1),collect_statement=(1)
    ACTION(package0.collect_system_time,sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.session_id)
    WHERE ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'Pier1')))
ADD TARGET package0.event_file(SET filename=N'QueryWaitStatisticsPier1.xel',max_file_size=(64),max_rollover_files=(8))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO


