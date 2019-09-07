CREATE EVENT SESSION [Tuning_TempDB_CatalogImport] ON SERVER 
ADD EVENT sqlserver.exchange_spill(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[client_hostname]=N'colo1-vm-cat01')),
ADD EVENT sqlserver.sp_statement_completed(SET collect_object_name=(1),collect_statement=(1)
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.server_principal_name,sqlserver.session_id)
    WHERE ([package0].[equal_boolean]([sqlserver].[is_system],(0)) AND [sqlserver].[equal_i_sql_unicode_string]([sqlserver].[client_hostname],N'colo1-vm-cat01'))),
ADD EVENT sqlserver.sql_batch_completed(SET collect_batch_text=(1)
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.server_principal_name,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([package0].[equal_boolean]([sqlserver].[is_system],(0)) AND [sqlserver].[equal_i_sql_unicode_string]([sqlserver].[client_hostname],N'colo1-vm-cat01')))
ADD TARGET package0.event_file(SET filename=N'Tuning_TempDB_CatalogImport.xel',max_file_size=(50))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=ON)
GO


