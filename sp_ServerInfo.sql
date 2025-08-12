USE [master]
GO

/****** StoredProcedure [dbo].[sp_ServerInfo]    Eric Peterson 2025 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER   PROCEDURE [dbo].[sp_ServerInfo]
AS  -- 2019 version
SELECT	SERVERPROPERTY('MachineName')					AS [Machine Name], 
		SERVERPROPERTY('ServerName')					AS [ServerName],  
		SERVERPROPERTY('InstanceName')					AS [Instance], 
		SERVERPROPERTY('ComputerNamePhysicalNetBIOS')	AS [ComputerName PhysicalNetBIOS], 
		CONNECTIONPROPERTY('local_net_address')			AS [LocalNetAddress],
		CONNECTIONPROPERTY('local_tcp_port')			AS [Local tcp_port],
		DEFAULT_DOMAIN()								AS [DefaultDomain],
		CASE SERVERPROPERTY('IsClustered') 
			WHEN 1 THEN 'Yes'
			ELSE        'No '     END					AS [IsClustered], 
		cpu_count										AS [CPUs],
		hyperthread_ratio								AS [Cores],
		FORMAT((physical_memory_kb/1024),N'#,##')		AS [PhysMem(MB)],
		FORMAT(CONVERT(INT, CASE cfg.value_in_use
							WHEN 2147483647 
							THEN (physical_memory_kb/1024)
								ELSE cfg.value_in_use
							END	), N'#,##')				AS [CfgMemMax(MB)], 
		FORMAT(CONVERT(INT, 
			(physical_memory_in_use_kb/1024)),N'#,##')	AS [MemInUse(MB)]	,		
		CONVERT(CHAR(4), 
			SUBSTRING( @@version, 22,
				CHARINDEX('-', @@version)-22))          AS [VersionText],
		SERVERPROPERTY('ProductLevel')					AS [ProdLevel], 
		SERVERPROPERTY('ProductUpdateLevel')			AS [ProdUpdateLvl],
		SERVERPROPERTY('Edition')						AS [Edition], 
		windows_release                                 AS [OS Release], 
		windows_service_pack_level                      AS [OS Srvc Pack],
		sqlserver_start_time							AS [SQLStartDate],
		SERVERPROPERTY('ProductVersion')				AS [ProductVersion], 
		create_date										AS [SQL Server Install Date] ,
		SERVERPROPERTY('ProcessID')						AS [ProcessID],
		SERVERPROPERTY('Collation')						AS [Collation], 
 		CASE SERVERPROPERTY('IsFullTextInstalled')
			WHEN 1 THEN 'Yes'
			ELSE        'No '     END					AS [IsFullTextInstalled], 
		CONNECTIONPROPERTY('net_transport')				AS net_transport,
		CONNECTIONPROPERTY('protocol_type')				AS protocol_type,
		CONNECTIONPROPERTY('auth_scheme')				AS auth_scheme,
		CASE SERVERPROPERTY('IsIntegratedSecurityOnly') 
			WHEN 1 THEN 'Yes'
			ELSE        'No '     END					AS [IsIntegratedSecurityOnly],
		CASE SERVERPROPERTY('IsHadrEnabled')	
			WHEN 1 THEN 'Yes'
			ELSE        'No '     END					AS [IsHadrEnabled], 
		CASE SERVERPROPERTY('HadrManagerStatus')
			WHEN 0 THEN 'Down'
			WHEN 1 THEN 'Up  '
			WHEN 2 THEN 'N/A '
			ELSE        '??? '     END					 AS [HadrManagerStatus],
			virtual_machine_type_desc                    AS [virtualMachine TypeDesc]  
FROM sys.server_principals		Prn WITH (NOLOCK),
     sys.dm_os_sys_info			Inf WITH (NOLOCK),
	 sys.configurations			Cfg WITH (NOLOCK),
	 sys.dm_os_process_memory	Mem WITH (NOLOCK),  
	 sys.dm_os_windows_info     Win WITH (NOLOCK)
WHERE( Prn.name = N'NT AUTHORITY\SYSTEM'
	 OR Prn.name = N'NT AUTHORITY\NETWORK SERVICE' )
   AND Cfg.name = 'max server memory (MB)' 
OPTION (RECOMPILE)
GO


