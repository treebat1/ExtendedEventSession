use master 
go

ALTER EVENT SESSION [DDL_Changes] ON SERVER
STATE = stop;

drop event session [DDL_Changes] on server;

CREATE EVENT SESSION [DDL_Changes] ON SERVER 
ADD EVENT sqlserver.object_altered(SET collect_database_name=(1)
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.nt_username,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[not_equal_i_sql_unicode_string]([database_name],N'tempdb') 
	AND [sqlserver].[not_equal_i_sql_unicode_string]([sqlserver].[username],N'COLO\SQLAgentAccount') 
	AND [sqlserver].[not_equal_i_sql_unicode_string]([sqlserver].[client_app_name],N'Spotlight Diagnostic Server (Monitoring)')
	AND [sqlserver].[not_equal_i_sql_unicode_string]([sqlserver].[client_app_name],N'SQLServerCEIP')
	)),
ADD EVENT sqlserver.object_created(SET collect_database_name=(1)
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.nt_username,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[not_equal_i_sql_unicode_string]([database_name],N'tempdb') 
	AND [sqlserver].[not_equal_i_sql_unicode_string]([sqlserver].[username],N'COLO\SQLAgentAccount') 
	AND [sqlserver].[not_equal_i_sql_unicode_string]([sqlserver].[client_app_name],N'Spotlight Diagnostic Server (Monitoring)')
	AND [sqlserver].[not_equal_i_sql_unicode_string]([sqlserver].[client_app_name],N'SQLServerCEIP')
	)),
ADD EVENT sqlserver.object_deleted(SET collect_database_name=(1)
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.nt_username,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[not_equal_i_sql_unicode_string]([database_name],N'tempdb') 
	AND [sqlserver].[not_equal_i_sql_unicode_string]([sqlserver].[username],N'COLO\SQLAgentAccount') 
	AND [sqlserver].[not_equal_i_sql_unicode_string]([sqlserver].[client_app_name],N'Spotlight Diagnostic Server (Monitoring)')
	AND [sqlserver].[not_equal_i_sql_unicode_string]([sqlserver].[client_app_name],N'SQLServerCEIP')
	))
ADD TARGET package0.event_file(SET filename=N'DDL_Changes_Audit.xel',max_rollover_files=(5))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF
,STARTUP_STATE=ON)
GO


ALTER EVENT SESSION [DDL_Changes] ON SERVER
STATE = start;
