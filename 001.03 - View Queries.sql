;WITH ring_buffer_xml
AS (
    SELECT CAST(xst.target_data AS xml) performance_xml
    FROM sys.dm_xe_session_targets xst
        INNER JOIN sys.dm_xe_sessions xs ON xst.event_session_address = xs.address
    WHERE xst.target_name = 'ring_buffer' and xs.name = 'ex_stratesql_duration_cpu_io'
)
,action_results AS (
SELECT 
	c1.value('(data/value)[1]','int') AS source_database_id
	,c1.value('(data/value)[2]','int') AS object_id
	,c1.value('(data/value)[3]','varchar(255)') AS object_type
	,c1.value('(data/value)[4]','int') AS cpu
	,c1.value('(data/value)[5]','int') AS duration
	,c1.value('(data/value)[6]','int') AS reads
	,c1.value('(data/value)[7]','int') AS writes
	,CAST(c1.value('(action/value)[1]','nvarchar(max)') AS xml) AS plan_handle_xml
	,CAST(c1.value('(action/value)[2]','nvarchar(max)') AS xml) AS frame_xml
FROM ring_buffer_xml rbx
    CROSS APPLY performance_xml.nodes('//RingBufferTarget/event') as t1(c1)
    )
,handled_data AS (
SELECT source_database_id
, object_id
, object_type
, cpu
, duration
, reads
, writes
, plan_handle_xml.value('xs:hexBinary(substring((plan/@handle)[1],3))', 'varbinary(255)') AS plan_handle
, frame_xml.value('(frame/@level)[1]','int') AS frame
, CONVERT(VARBINARY(255), frame_xml.value('(frame/@handle)[1]','nvarchar(255)'), 0) AS [sql_handle]
, frame_xml.value('(frame/@line)[1]','int') AS line
, frame_xml.value('(frame/@offsetStart)[1]','int') AS offsetStart
, frame_xml.value('(frame/@offsetEnd)[1]','int') AS offsetEnd
FROM action_results
)
SELECT DB_NAME(hd.source_database_id) AS database_name
, OBJECT_NAME(hd.OBJECT_ID, hd.source_database_id)
, hd.cpu
, hd.duration
, hd.reads
, hd.writes
,qp.query_plan
,CAST('<?query --'+CHAR(13)+SUBSTRING(st.text, (hd.offsetStart/2)+1, 
    ((CASE hd.offsetEnd
    WHEN -1 THEN DATALENGTH(st.text)
    ELSE hd.offsetStart
    END - hd.offsetStart)/2) + 1)+CHAR(13)+'--?>' AS xml) as sql_statement
FROM handled_data hd
	CROSS APPLY sys.dm_exec_query_plan(plan_handle) qp
	CROSS APPLY sys.dm_exec_sql_text(plan_handle) st
	
        


