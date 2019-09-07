CREATE EVENT SESSION [StoredProcedureStatistics] ON SERVER 
ADD EVENT sqlserver.rpc_completed(SET collect_statement=(1)
    ACTION(package0.collect_system_time,sqlos.task_time,sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.session_id)
    WHERE ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'Staples') AND [sqlserver].[equal_i_sql_unicode_string]([object_name],N'get_subject_profile') 
	AND [duration]>(200000)))
ADD TARGET package0.event_file(SET filename=N'c:\temp\StoredProcedureStatistics.xel',max_file_size=(5))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO


--I am trying to show long durations calls to the SP and long IO waits.
CREATE EVENT SESSION [StoredProcedureStatistics] ON SERVER 
ADD EVENT sqlos.wait_info(
    ACTION(package0.collect_system_time,sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.session_id)
    WHERE ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'staples') 
	AND [package0].[equal_binary_data]([sqlserver].[plan_handle],0x05000500A455397EC05C85634000000001000000000000000000000000000000000000000000000000000000) 
	AND [package0].[greater_than_uint64]([duration],(50)))),
ADD EVENT sqlos.wait_info_external(
    ACTION(package0.collect_system_time,sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.session_id)
    WHERE ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'staples') 
	AND [package0].[equal_binary_data]([sqlserver].[plan_handle],0x05000500A455397EC05C85634000000001000000000000000000000000000000000000000000000000000000) 
	AND [package0].[greater_than_uint64]([duration],(50)))),
ADD EVENT sqlserver.rpc_completed(SET collect_statement=(1)
    ACTION(package0.collect_system_time,sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.session_id)
    WHERE ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'Staples') AND [sqlserver].[equal_i_sql_unicode_string]([object_name],N'get_subject_profile') 
	AND [package0].[greater_than_uint64]([duration],(300000))))
ADD TARGET package0.event_file(SET filename=N'c:\temp\StoredProcedureStatistics.xel',max_file_size=(10))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF
,STARTUP_STATE=OFF)
GO



