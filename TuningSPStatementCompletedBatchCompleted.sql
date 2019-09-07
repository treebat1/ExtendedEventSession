CREATE EVENT SESSION [TuningSPStatementCompletedBatchCompleted] ON SERVER 
ADD EVENT sqlserver.additional_memory_grant(
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.server_principal_name,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([package0].[equal_boolean]([sqlserver].[is_system],(0)))),
ADD EVENT sqlserver.batch_hash_table_build_bailout(
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.server_principal_name,sqlserver.session_id,sqlserver.sql_text)
    ),
ADD EVENT sqlserver.degree_of_parallelism(
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.server_principal_name,sqlserver.session_id,sqlserver.sql_text)
    ),
ADD EVENT sqlserver.error_reported(
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.server_principal_name,sqlserver.session_id,sqlserver.sql_text)
    ),
ADD EVENT sqlserver.exchange_spill(
    ACTION(sqlserver.sql_text)
    ),
ADD EVENT sqlserver.execution_warning(SET collect_server_memory_grants=(1)
    ACTION(sqlserver.sql_text)
    ),
ADD EVENT sqlserver.full_update_instead_of_partial_update(
    ACTION(sqlserver.sql_text)
    ),
ADD EVENT sqlserver.hash_spill_details(
    ACTION(sqlserver.sql_text)
    ),
ADD EVENT sqlserver.hash_warning(
    ACTION(sqlserver.sql_text)
    ),
ADD EVENT sqlserver.missing_column_statistics(SET collect_column_list=(1)
    ACTION(sqlserver.sql_text)
    ),
ADD EVENT sqlserver.missing_join_predicate(
    ACTION(sqlserver.sql_text)
    ),
ADD EVENT sqlserver.optimizer_timeout(
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.server_principal_name,sqlserver.session_id,sqlserver.sql_text)
    ),
ADD EVENT sqlserver.plan_affecting_convert(
    ACTION(sqlserver.sql_text)
    ),
ADD EVENT sqlserver.server_memory_change(
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.server_principal_name,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([package0].[greater_than_uint64]([sqlserver].[database_id],(4)) AND [package0].[equal_boolean]([sqlserver].[is_system],(0)))),
ADD EVENT sqlserver.sort_warning(
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.server_principal_name,sqlserver.session_id,sqlserver.sql_text)
    ),
ADD EVENT sqlserver.sp_statement_completed(SET collect_object_name=(1),collect_statement=(1)
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.server_principal_name,sqlserver.session_id)
    WHERE ([package0].[equal_boolean]([sqlserver].[is_system],(0)) )),
ADD EVENT sqlserver.sql_batch_completed(SET collect_batch_text=(1)
    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_name,sqlserver.plan_handle,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.server_principal_name,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([package0].[equal_boolean]([sqlserver].[is_system],(0)) ))
ADD TARGET package0.event_file(SET FILENAME=N'TuningSPStatementCompletedBatchCompleted.xel',max_file_size=(50))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS
,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO


