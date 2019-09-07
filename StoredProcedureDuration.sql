CREATE EVENT SESSION [StoredProcedureDuration] ON SERVER 
ADD EVENT sqlserver.rpc_completed(SET collect_statement=(1)
    ACTION(package0.collect_system_time)
    WHERE ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'WS_DataMart') 
	--AND [package0].[greater_than_uint64]([duration],(60000000))))  -- 1 minute
	AND [package0].[greater_than_uint64]([duration],(1000000))))  -- 1 second
ADD TARGET package0.event_file(SET filename=N'StoredProcedureDuration.xel',max_file_size=(10))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS
,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF
,STARTUP_STATE=OFF)
GO


/*
SELECT p.name package_name,
       o.name event_name,
       c.name event_field,
       DurationUnit= CASE
                         WHEN c.description LIKE '%milli%' 
                         THEN SUBSTRING(c.description, CHARINDEX('milli', c.description),12)
                         WHEN c.description LIKE '%micro%' 
                         THEN SUBSTRING(c.description, CHARINDEX('micro', c.description),12)
                         ELSE NULL
                     END,
       c.type_name field_type,
       c.column_type column_type
FROM sys.dm_xe_objects o
JOIN sys.dm_xe_packages p ON o.package_guid = p.guid
JOIN sys.dm_xe_object_columns c ON o.name = c.object_name
WHERE o.object_type = 'event'
AND c.name ='duration'
*/


