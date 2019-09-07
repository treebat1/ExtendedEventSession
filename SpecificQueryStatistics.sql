
CREATE EVENT SESSION [QueryStatistics] ON SERVER 
ADD EVENT sqlserver.sp_statement_completed(SET collect_statement=(1)
    ACTION(package0.collect_system_time,sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.session_id)
    WHERE (([package0].[equal_uint64]([sqlserver].[query_hash],(1875645902597692167.)) 
	OR [package0].[equal_uint64]([sqlserver].[query_hash],(500861244829850427.)) 
	OR [package0].[equal_uint64]([sqlserver].[query_hash],(7840168764677669914.)) 
	OR [package0].[equal_uint64]([sqlserver].[query_hash],(5535245133561538.))) 
	AND [sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'Staples')))
ADD TARGET package0.event_file(SET filename=N'C:\temp\Query_Statistics.xel',max_rollover_files=(10))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO

