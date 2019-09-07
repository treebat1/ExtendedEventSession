CREATE EVENT SESSION [SQL Performance Analysis] ON SERVER 
ADD EVENT sqlserver.begin_tran_completed(
    ACTION(sqlos.task_time,sqlserver.database_name,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[database_name]=N'Ws_DATAMART')),
ADD EVENT sqlserver.begin_tran_starting(
    ACTION(sqlos.task_time,sqlserver.database_name,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[database_name]=N'Ws_DATAMART')),
ADD EVENT sqlserver.blocked_process_report(
    ACTION(sqlos.task_time,sqlserver.database_name,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[database_name]=N'Ws_DATAMART')),
ADD EVENT sqlserver.commit_tran_completed(
    ACTION(sqlos.task_time,sqlserver.database_name,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[database_name]=N'Ws_DATAMART')),
ADD EVENT sqlserver.commit_tran_starting(
    ACTION(sqlos.task_time,sqlserver.database_name,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[database_name]=N'Ws_DATAMART')),
ADD EVENT sqlserver.execution_warning(
    ACTION(sqlos.task_time,sqlserver.database_name,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[database_name]=N'Ws_DATAMART')),
ADD EVENT sqlserver.lock_acquired(
    ACTION(sqlos.task_time,sqlserver.database_name,sqlserver.query_hash,sqlserver.sql_text,sqlserver.username)
    WHERE ([package0].[greater_than_uint64]([database_id],(4)) AND [package0].[equal_boolean]([sqlserver].[is_system],(0)) AND [sqlserver].[database_name]=N'Ws_DATAMART')),
ADD EVENT sqlserver.lock_deadlock(
    ACTION(sqlos.task_time,sqlserver.database_name,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[database_name]=N'Ws_DATAMART')),
ADD EVENT sqlserver.lock_deadlock_chain(
    ACTION(sqlos.task_time,sqlserver.database_name,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[database_name]=N'Ws_DATAMART')),
ADD EVENT sqlserver.lock_escalation(
    ACTION(sqlos.task_time,sqlserver.database_name,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[database_name]=N'Ws_DATAMART')),
ADD EVENT sqlserver.rpc_completed(
    ACTION(sqlos.task_time,sqlserver.database_name,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[database_name]=N'Ws_DATAMART')),
ADD EVENT sqlserver.rpc_starting(
    ACTION(sqlos.task_time,sqlserver.database_name,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[database_name]=N'Ws_DATAMART'))
ADD TARGET package0.event_file(SET filename=N'D:\test\sql_perf_analysis.xel',max_file_size=(100)),
ADD TARGET package0.histogram(SET filtering_event_name=N'sqlserver.lock_acquired',source=N'sqlserver.query_hash')
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=ON,STARTUP_STATE=OFF)
GO


