CREATE EVENT SESSION [TrapExecPlans] ON SERVER 
ADD EVENT sqlserver.query_post_execution_showplan(SET collect_database_name=(1)
    ACTION(package0.callstack,sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.plan_handle
	,sqlserver.query_hash,sqlserver.request_id,sqlserver.session_id,sqlserver.sql_text,sqlserver.tsql_stack
	,sqlserver.username)
    WHERE ([package0].[greater_than_uint64]([duration],(60000000))))
ADD TARGET package0.event_file(SET filename=N'TrapExecPlans.xel',max_file_size=(10),max_rollover_files=(5))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS
,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO


