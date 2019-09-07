CREATE EVENT SESSION [SQLJobChanges] ON SERVER 
ADD EVENT sqlserver.sql_batch_completed(SET collect_batch_text=(1)
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.nt_username,sqlserver.server_principal_name,sqlserver.session_id)
    WHERE ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'msdb') AND [sqlserver].[like_i_sql_unicode_string]([batch_text],N'%job%')))
ADD TARGET package0.event_file(SET filename=N'SQLJobChanges.xel',max_file_size=(50))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE
,TRACK_CAUSALITY=OFF,STARTUP_STATE=ON)
GO

