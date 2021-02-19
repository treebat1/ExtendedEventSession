set nocount on
SELECT top 20 *
--SELECT *
FROM sys.fn_xe_file_target_read_file('C:\Temp\*.xel', null , null, null)
--where event_data like ('%view%')
--and event_data like '%strategy%'
set nocount off
