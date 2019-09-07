WITH statement_ntile_cte AS (
    SELECT  DISTINCT
            event_interval, 
			LEFT(STATEMENT,24) AS GroupedStatement,
            PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY duration_ms) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS  duration_50th,
            PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY duration_ms) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS duration_75th,
            PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY duration_ms) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS duration_90th,
            PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY duration_ms) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS duration_95th,
            PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY duration_ms) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS duration_99th,
 
            PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY cpu_time_ms) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS cpu_time_50th,
            PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cpu_time_ms) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS cpu_time_75th,
            PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY cpu_time_ms) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS cpu_time_90th,
            PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY cpu_time_ms) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS cpu_time_95th,
            PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY cpu_time_ms) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS cpu_time_99th,
 
            PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY physical_reads) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS  physical_reads_50th,
            PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY physical_reads) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS  physical_reads_75th,
            PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY physical_reads) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS  physical_reads_90th,
            PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY physical_reads) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS  physical_reads_95th,
            PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY physical_reads) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS  physical_reads_99th,
 
            PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY logical_reads) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS logical_reads_50th,
            PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY logical_reads) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS logical_reads_75th,
            PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY logical_reads) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS logical_reads_90th,
            PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY logical_reads) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS logical_reads_95th,
            PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY logical_reads) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS logical_reads_99th,
 
            PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY writes) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS writes_50th,
            PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY writes) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS writes_75th,
            PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY writes) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS writes_90th,
            PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY writes) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS writes_95th,
            PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY writes) OVER (PARTITION BY LEFT(STATEMENT,24), DATEADD(MINUTE, DATEDIFF(MINUTE, 0, event_time), 0)) AS writes_99th
    FROM    query_stats
),
statement_analyzed_cte AS (
    SELECT  event_interval,
            LEFT(STATEMENT,24) AS GroupedStatement,
            SUM(duration_ms) AS total_duration_ms,
            AVG(duration_ms) AS average_duration_ms,
            COALESCE(STDEV(duration_ms), 0) AS stdev_duration_ms,
            MIN(duration_ms) AS min_duration_ms,
            MAX(duration_ms) AS max_duration_ms,
            SUM(cpu_time_ms) AS total_cpu_time_ms,
            AVG(cpu_time_ms) AS average_cpu_time_ms,
            COALESCE(STDEV(cpu_time_ms), 0) AS stdev_cpu_time_ms,
            MIN(cpu_time_ms) AS min_cpu_time_ms,
            MAX(cpu_time_ms) AS max_cpu_time_ms,
            SUM(physical_reads) AS total_physical_reads,
            AVG(physical_reads) AS average_physical_reads,
            COALESCE(STDEV(physical_reads), 0) AS stdev_physical_reads,
            MIN(physical_reads) AS min_physical_reads,
            MAX(physical_reads) AS max_physical_reads,
            SUM(logical_reads) AS total_logical_reads,
            AVG(logical_reads) AS average_logical_reads,
            COALESCE(STDEV(logical_reads), 0) AS stdev_logical_reads,
            MIN(logical_reads) AS min_logical_reads,
            MAX(logical_reads) AS max_logical_reads,
            SUM(writes) AS total_writes,
            AVG(writes) AS average_writes,
            COALESCE(STDEV(writes), 0) AS stdev_writes,
            MIN(writes) AS min_writes,
            MAX(writes) AS max_writes
    FROM    query_stats sc
    GROUP BY LEFT(statement,24), event_interval
),
query_stats AS (
SELECT  
        sac.GroupedStatement,

        sac.event_interval,
    
        sac.total_duration_ms,
        sac.average_duration_ms,
        sac.stdev_duration_ms,
        sac.min_duration_ms,
        sac.max_duration_ms,
        snc.duration_50th,
        snc.duration_75th,
        snc.duration_90th,
        snc.duration_95th,
        snc.duration_99th,
 
        sac.total_cpu_time_ms,
        sac.average_cpu_time_ms,
        sac.stdev_cpu_time_ms,
        sac.min_cpu_time_ms,
        sac.max_cpu_time_ms,
        snc.cpu_time_50th,
        snc.cpu_time_75th,
        snc.cpu_time_90th,
        snc.cpu_time_95th,
        snc.cpu_time_99th,
        
        sac.total_physical_reads,
        sac.average_physical_reads,
        sac.stdev_physical_reads,
        sac.min_physical_reads,
        sac.max_physical_reads,
        snc.physical_reads_50th,
        snc.physical_reads_75th,
        snc.physical_reads_90th,
        snc.physical_reads_95th,
        snc.physical_reads_99th,        
 
        sac.total_logical_reads,
        sac.average_logical_reads,
        sac.stdev_logical_reads,
        sac.min_logical_reads,
        sac.max_logical_reads,
        snc.logical_reads_50th,
        snc.logical_reads_75th,
        snc.logical_reads_90th,
        snc.logical_reads_95th,
        snc.logical_reads_99th,
 
        sac.total_writes,
        sac.average_writes,
        sac.stdev_writes,
        sac.min_writes,
        sac.max_writes,
        snc.writes_50th,
        snc.writes_75th,
        snc.writes_90th,
        snc.writes_95th,
        snc.writes_99th
FROM    statement_analyzed_cte sac
        JOIN statement_ntile_cte AS snc ON sac.GroupedStatement = snc.GroupedStatement
                                           AND sac.event_interval = snc.event_interval
)
SELECT  REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(qs.GroupedStatement)), NCHAR(13), ' '), NCHAR(10), ' '), NCHAR(9), ' '), ' ','<>'),'><',''),'<>',' ') AS QueryText,
        qs.event_interval,
 
        qs.total_duration_ms,
        qs.average_duration_ms,
        qs.stdev_duration_ms,
        qs.min_duration_ms,
        qs.max_duration_ms,
        qs.duration_50th,
        qs.duration_75th,
        qs.duration_90th,
        qs.duration_95th,
        qs.duration_99th,
 
        qs.total_cpu_time_ms,
        qs.average_cpu_time_ms,
        qs.stdev_cpu_time_ms,
        qs.min_cpu_time_ms,
        qs.max_cpu_time_ms,
        qs.cpu_time_50th,
        qs.cpu_time_75th,
        qs.cpu_time_90th,
        qs.cpu_time_95th,
        qs.cpu_time_99th,
        
        qs.total_physical_reads,
        qs.average_physical_reads,
        qs.stdev_physical_reads,
        qs.min_physical_reads,
        qs.max_physical_reads,
        qs.physical_reads_50th,
        qs.physical_reads_75th,
        qs.physical_reads_90th,
        qs.physical_reads_95th,
        qs.physical_reads_99th,        
 
        qs.total_logical_reads,
        qs.average_logical_reads,
        qs.stdev_logical_reads,
        qs.min_logical_reads,
        qs.max_logical_reads,
        qs.logical_reads_50th,
        qs.logical_reads_75th,
        qs.logical_reads_90th,
        qs.logical_reads_95th,
        qs.logical_reads_99th,
 
        qs.total_writes,
        qs.average_writes,
        qs.stdev_writes,
        qs.min_writes,
        qs.max_writes,
        qs.writes_50th,
        qs.writes_75th,
        qs.writes_90th,
        qs.writes_95th,
        qs.writes_99th
FROM    query_stats AS qs
ORDER BY QueryText ASC, qs.event_interval ASC, qs.total_duration_ms DESC
OPTION (RECOMPILE) ;
 
 
 
 
 
 
 
 