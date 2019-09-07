CREATE EVENT SESSION [query_performance] ON SERVER 
ADD EVENT sqlos.wait_info(
    ACTION(sqlserver.client_hostname,sqlserver.database_name,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([package0].[equal_boolean]([sqlserver].[is_system],(0)) AND [sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'JCPenney'))),
ADD EVENT sqlserver.sp_statement_completed(SET collect_object_name=(1),collect_statement=(1)
    ACTION(sqlserver.client_hostname,sqlserver.database_name,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.session_id)
    WHERE ([package0].[equal_boolean]([sqlserver].[is_system],(0)) AND [sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'JCPenney') 
	AND [sqlserver].[like_i_sql_unicode_string]([object_name],N'get_subject')))
ADD TARGET package0.event_file(SET filename=N'query_performance.xel',max_file_size=(64),max_rollover_files=(5),metadatafile=N'query_performance.xem')
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=5 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,
STARTUP_STATE=OFF)
GO


