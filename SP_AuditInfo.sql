USE [master]
GO

/******   StoredProcedure [dbo].[sp_AuditInfo]  by  Eric Peterson ******/

CREATE OR ALTER     Procedure [dbo].[sp_AuditInfo]
(@LoginIn		sysname = NULL,
 @GenerateRoles	Varchar(256) = Null )
As

Set NoCount On
--dbo.sp_MachineInfo

--sp_diskinfo

--  SELECT * FROM sys.sysdatabases

-- DROP TABLE #SecurityAccess
-- drop table #DBPermList

--- variables for testing 
--  declare @LoginIn		sysname
--  declare @GenerateRoles	Varchar(256)

CREATE TABLE #SecurityAccess
    ( SQLServerName sysname,
      LoginName     sysname,
	  LastModified  varchar(32),
	  PWLastChanged	varchar(32),
	  LastAccess	Varchar(32) Null,
      DefaultDB     sysname null,
      Active        CHAR(3),
	  Disabled      Char(3),
      LoginType     CHAR(3),
      SysAdm        CHAR(3),
      SecurAdm      CHAR(3),
      SrvrAdm       CHAR(3),
      ProcsAdm      CHAR(3),
      DiskAdm       CHAR(3),
      DB1			VARCHAR(50),
	  DB2			VARCHAR(50),
      DB3			VARCHAR(50),
      DB4			VARCHAR(50),
      DB5           VARCHAR(50),
      DB6           VARCHAR(50),
      DB7           VARCHAR(50),
      DB8           VARCHAR(50),
      DB9           VARCHAR(50),
      DB10          VARCHAR(50),
      DB11          VARCHAR(50),
      DB12          VARCHAR(50),
      DB13          VARCHAR(50),
      DB14          VARCHAR(50),
      DB15          VARCHAR(50),
      DB16          VARCHAR(50),
      DB17          VARCHAR(50),
      DB18          VARCHAR(50),
      DB19          VARCHAR(50),
      DB20          VARCHAR(50),
      DB21          VARCHAR(50),
      DB22          VARCHAR(50),
      DB23          VARCHAR(50),
      DB24          VARCHAR(50),
      DB25          VARCHAR(50),
      DB26          VARCHAR(50),
      DB27          VARCHAR(50),
      DB28          VARCHAR(50),
      DB29          VARCHAR(50),
      DB30          VARCHAR(50),
      DB31          VARCHAR(50),
      DB32          VARCHAR(50),
      DB33          VARCHAR(50),
      DB34          VARCHAR(50),
      DB35          VARCHAR(50),
      DB36          VARCHAR(50),
      DB37          VARCHAR(50),
      DB38          VARCHAR(50),
      DB39          VARCHAR(50),
      DB40          VARCHAR(50),
      DB41          VARCHAR(50),
      DB42          VARCHAR(50),
      DB43          VARCHAR(50),
      DB44          VARCHAR(50),
      DB45          VARCHAR(50),
      DB46          VARCHAR(50),
      DB47          VARCHAR(50),
      DB48          VARCHAR(50),
      DB49          VARCHAR(50),
      DB50          VARCHAR(50),
      DB51          VARCHAR(50),
      DB52          VARCHAR(50),
      DB53          VARCHAR(50),
      DB54          VARCHAR(50),
      DB55          VARCHAR(50),
      DB56          VARCHAR(50),
      DB57          VARCHAR(50),
      DB58          VARCHAR(50),
      DB59          VARCHAR(50),
      DB60          VARCHAR(50),
      DB61          VARCHAR(50),
      DB62          VARCHAR(50),
      DB63          VARCHAR(50),
      DB64          VARCHAR(50),
      DB65          VARCHAR(50),
      DB66          VARCHAR(50),
      DB67          VARCHAR(50),
      DB68          VARCHAR(50),
      DB69          VARCHAR(50),
	  DB70			VARCHAR(50)  );

-- drop table #DBPermList

CREATE TABLE #DBPermList
    ( DBName   VARCHAR(200),
      DBID     VARCHAR(5),
      RoleName VARCHAR(100),
      UserName VARCHAR(200));



INSERT INTO #SecurityAccess ( SQLServerName,
                              LoginName,
							  LastModified,
							  PWLastChanged,
							  LastAccess,
                              DefaultDB,
                              Active,
							  [Disabled],
                              LoginType,
                              SysAdm,
                              SecurAdm,
                              SrvrAdm,
                              ProcsAdm,
                              DiskAdm,
                              DB1,
                              DB2,
                              DB3,
                              DB4,
                              DB5,
                              DB6,
                              DB7,
                              DB8,
                              DB9,
                              DB10,
                              DB11,
                              DB12,
                              DB13,
                              DB14,
                              DB15,
                              DB16,
                              DB17,
                              DB18,
                              DB19,
                              DB20,
                              DB21,
                              DB22,
                              DB23,
                              DB24,
                              DB25,
                              DB26,
                              DB27,
                              DB28,
                              DB29,
                              DB30,
                              DB31,
                              DB32,
                              DB33,
                              DB34,
                              DB35,
                              DB36,
                              DB37,
                              DB38,
                              DB39,
                              DB40,
                              DB41,
                              DB42,
                              DB43,
                              DB44,
                              DB45,
                              DB46,
                              DB47,
                              DB48,
                              DB49,
                              DB50,
                              DB51,
                              DB52,
                              DB53,
                              DB54,
                              DB55,
                              DB56,
                              DB57,
                              DB58,
                              DB59,
                              DB60,
                              DB61,
                              DB62,
                              DB63,
                              DB64,
                              DB65,
                              DB66,
                              DB67,
                              DB68,
                              DB69,
                              DB70 )
SELECT  @@servername   AS 'SQLServerName',
        L.name         AS 'Login',
		updatedate     AS 'LastModified', 
		convert(varchar(32), LOGINPROPERTY(l.name, 'PasswordLastSetTime') ) as PWLastChanged,
		accdate        As 'LastAccess',  --  Column is not accurate and Not supported by MS.  
        dbname        AS 'DefaultDB',
        CASE L.hasaccess
            WHEN 1 THEN 'Yes'
            ELSE 'No'
        END          AS 'Active',
		Case P.Is_Disabled
            WHEN 1 THEN 'Yes'
            ELSE 'No'
        END          AS 'Disabled',

        CASE isntuser
            WHEN 1 THEN 'AD '
            ELSE 'SQL'
        END          AS 'LoginType',
        CASE sysadmin
            WHEN 1 THEN 'Yes'
            ELSE 'No'
        END          AS 'SysAdm',
        CASE securityadmin
            WHEN 1 THEN 'Yes'
            ELSE 'No'
        END          AS 'SecurAdm',
        CASE serveradmin
            WHEN 1 THEN 'Yes'
            ELSE 'No'
        END          AS 'SrvrAdm',
        CASE processadmin
            WHEN 1 THEN 'Yes'
            ELSE 'No'
        END          AS 'ProcsAdm',
        CASE diskadmin
            WHEN 1 THEN 'Yes'
            ELSE 'No'
        END          AS 'DiskAdm',
        ' '          AS 'DB1',
        ' '          AS 'DB2',
        ' '          AS 'DB3',
        ' '          AS 'DB4',
        ' '          AS 'DB5',
        ' '          AS 'DB6',
        ' '          AS 'DB7',
        ' '          AS 'DB8',
        ' '          AS 'DB9',
        ' '          AS 'DB10',
        ' '          AS 'DB11',
        ' '          AS 'DB12',
        ' '          AS 'DB13',
        ' '          AS 'DB14',
        ' '          AS 'DB15',
        ' '          AS 'DB16',
        ' '          AS 'DB17',
        ' '          AS 'DB18',
        ' '          AS 'DB19',
        ' '          AS 'DB20',
        ' '          AS 'DB21',
        ' '          AS 'DB22',
        ' '          AS 'DB23',
        ' '          AS 'DB24',
        ' '          AS 'DB25',
        ' '          AS 'DB26',
        ' '          AS 'DB27',
        ' '          AS 'DB28',
        ' '          AS 'DB29',
        ' '          AS 'DB30',
        ' '          AS 'DB31',
        ' '          AS 'DB32',
        ' '          AS 'DB33',
        ' '          AS 'DB34',
        ' '          AS 'DB35',
        ' '          AS 'DB36',
        ' '          AS 'DB37',
        ' '          AS 'DB38',
        ' '          AS 'DB39',
        ' '          AS 'DB40',
        ' '          AS 'DB41',
        ' '          AS 'DB42',
        ' '          AS 'DB43',
        ' '          AS 'DB44',
        ' '          AS 'DB45',
        ' '          AS 'DB46',
        ' '          AS 'DB47',
        ' '          AS 'DB48',
        ' '          AS 'DB49',
        ' '          AS 'DB50',
        ' '          AS 'DB51',
        ' '          AS 'DB52',
        ' '          AS 'DB53',
        ' '          AS 'DB54',
        ' '          AS 'DB55',
        ' '          AS 'DB56',
        ' '          AS 'DB57',
        ' '          AS 'DB58',
        ' '          AS 'DB59',
        ' '          AS 'DB60',
        ' '          AS 'DB61',
        ' '          AS 'DB62',
        ' '          AS 'DB63',
        ' '          AS 'DB64',
        ' '          AS 'DB65',
        ' '          AS 'DB66',
        ' '          AS 'DB67',
        ' '          AS 'DB68',
        ' '          AS 'DB69',
        ' '          AS 'DB70'
  FROM  sys.syslogins L
  Join sys.server_principals P
    On L.name = P.name
 WHERE  SUBSTRING(L.name, 1, 2) != '##'
 ORDER By     L.name;
 
 --****************************-- When auditing only one login --***************************

 If @LoginIn is not null
   Begin
	 delete from  #SecurityAccess
	 where LoginName != @LoginIn
	   and LoginName != '>>>>>>>DatabaseListing>>>>>>>> '

	Print @LoginIn

	End

--*****************************************************************************************

Update #SecurityAccess 
Set LastAccess = Convert(Char(32), DMS.MaxDT )
From #SecurityAccess  SA 
	Cross APPLY (Select max(login_time) MaxDT
				From sys.dm_exec_sessions DMS
				Where SA.LoginName = DMS.Login_name
				Group BY login_name ) DMS

INSERT INTO #SecurityAccess --(SQLServerName, [LoginName], [LastAccess],'[Master], MSDB , Model) 
VALUES ( @@SERVERNAME, '>>>>>>>DatabaseListing>>>>>>>> ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',' ',' ',' ',' ',' ', ' ', ' ', ' ', ' ', ' ', ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ') 
 
 
 -- select count(*) from sysdatabases
 
 --  DELETE FROM #SecurityAccess WHERE LoginName = '>>>>>>>DatabaseListing>>>>>>>> '
 --*****************************************************************************************************************************************************************
 --  SELECT * FROM #SecurityAccess  ORDER BY LoginName 

DECLARE @SQL VARCHAR(1000);
DECLARE @DBName VARCHAR(100);
DECLARE @DBID VARCHAR(10);
DECLARE @UserName VARCHAR(200);
DECLARE @Perm VARCHAR(4);
DECLARE @DBCount INT;

SET @DBCount = 0

declare DBCursor CURSOR
 FOR
 SELECT name, database_id 
 FROM sys.databases
 WHERE name != 'tempdb'
   and state_desc = 'ONLINE'

 OPEN DBCursor

 FETCH DBCursor 
 INTO @DBName, @DBID

 WHILE @@FETCH_STATUS = 0
   AND @DBCount < 70
   Begin 

  Set @DBName = '[' + @DBName + ']'
   SET @DBCount = @DBCount + 1

	SET @SQL = 'update #SecurityAccess set DB' + CONVERT(VARCHAR(3), @DBCount ) + ' = ''' + @DBName + '''  WHERE LoginName = ''>>>>>>>DatabaseListing>>>>>>>>''  ;'

--	PRINT @DBName

	EXECUTE (@SQL)

	SET @SQL = 'INSERT INTO #DBPermList ' 
			 + 'SELECT ''' + @DBName + ''' AS DBName, '
			 + ' ''DB' + CONVERT(VARCHAR(3), @DBCount ) + ''' AS DBID,'
			 + '		R.name AS RoleName, ' 
			 + '	    U.name AS UserName  '
			 + '  FROM ' + @DBName + '.sys.database_role_members AS M '
			 + '  JOIN ' + @DBName + '.sys.database_principals   AS R '
			 + '       ON M.role_principal_id   = R.principal_id '
			 + '  JOIN ' + @DBName + '.sys.database_principals   AS U '
			 + '       ON M.member_principal_id = U.principal_id '
			 + ' WHERE R.type = ''R'' '
			 + ' ORDER BY R.name;'

--	PRINT @SQL
	EXECUTE (@SQL) 




	 Fetch DBCursor 
	Into @DBName, @DBID

 End
 
 CLOSE DBcursor
 DEALLOCATE DBcursor

 
	 -----------------------------------------------------------------
--  select * from #SecurityAccess order by 2
-- delete from #DBPermList
-- drop table #DBPermList 
-- select * from #DBPermList 

	 -----------------------------------------------------------------
		--DECLARE @SQL VARCHAR(1000)
		--DECLARE @DBName VARCHAR(100)
		--DECLARE @DBID VARCHAR(10)
		--DECLARE @UserName VARCHAR(200)
  --      DECLARE @Perm varCHAR(4)

		Declare DBPermCursor Cursor For
			Select  DBName,
					DBID,
--					RoleName,
					Case RoleName
						When 'db_accessadmin' Then 'A'
						When 'db_backupoperator' Then 'B'
						When 'db_datareader' Then 'R'
						When 'db_datawriter' Then 'W'
						When 'db_ddladmin' Then 'DDL'
						When 'db_denydatareader' Then 'XD'
						When 'db_denydatawriter' Then 'XW'
						When 'db_executor' Then 'E'
						When 'db_owner' Then 'DBO'
						When 'db_securityadmin' Then 'S'
						When 'public' Then 'P'
						When 'RSExecRole' Then 'RSX'
						When 'TFSEXECROLE' Then 'TFE'
						When 'TFSADMINROLE' Then 'TFA'
						When 'TfsWarehouseDataReader' Then 'TFR'
						When 'SQLAgentUserRole' Then 'SAU'
						When 'SQLAgentReaderRole' Then 'SAR'
						When 'SQLAgentOperatorRole' Then 'SAO'
						When 'PolicyAdministratorRole' Then 'POL'
						When 'ssis_admin' Then 'SSA'
						When 'dc_operator' Then 'DCO'
						When 'db_ssisltduser' Then 'SSU'
						When 'db_ssisoperator' Then 'SSO'
						When 'dc_admin' Then 'DCA'
						When 'ServerGroupReaderRole' Then 'SGR'
						When 'UtilityIMRReader' Then 'UR'
						Else '?'
					End     As 'Role',
					UserName
			  From  #DBPermList
			  Where Convert(Int, Replace(DBID, 'DB', ''))  < 71
			 Order By
					UserName

	Open DBPermCursor

	Fetch DBPermCursor
	 Into @DBName, @DBID,@Perm, @UserName
	 
	 While @@Fetch_Status = 0
		   Begin

--		   Print @UserName + ' ' + @Perm

	   			Set @SQL = 'update #SecurityAccess set ' + @DBID  + ' = ' + @DBID +  ' + ''' + @Perm + ' ''  Where LoginName = ''' + @UserName + ''';'

				--PRINT @UserName
				--PRINT @SQL
				Execute(@SQL)


			   Fetch DBPermCursor
				Into @DBName, @DBID,@Perm, @UserName

		   End
       
	   Close DBPermCursor
	   Deallocate DBPermCursor 





 -- drop table #DBPermList
 -- select * from #DBPermList
Select * From #SecurityAccess Order By 2


  --  drop table #SecurityAccess

  --******************Generate roles for server Migration**************************************************************************
If @GenerateRoles = 'Yes'
  Begin
	Declare @LoginName	sysname
	Declare @Sysadm		Varchar(3)
	Declare @SrvrAdm		Varchar(3)
	Declare @ProcsAdm	Varchar(3)
	Declare @DiskAdm		Varchar(3)
	Declare @SecurAdm	Varchar(3)


	declare SecurityRoleCursor Cursor
	For
	Select	LoginName,  
			Sysadm,	
			SrvrAdm,
			ProcsAdm,
			DiskAdm,
			SecurAdm
	From #SecurityAccess  ORDER BY LoginName 

	Open SecurityRoleCursor

	Fetch SecurityRoleCursor
	Into @LoginName,
		 @Sysadm,	
		 @SrvrAdm,
		 @ProcsAdm,
		 @DiskAdm,
		 @SecurAdm

	While @@Fetch_Status = 0
	  Begin
		If @Sysadm = 'Yes'
			Print 'ALTER SERVER ROLE sysadmin ADD MEMBER [' + @loginname + '] ;'

		If @SecurAdm = 'Yes'
			Print 'ALTER SERVER ROLE securityadmin ADD MEMBER [' + @loginname + '] ;'

		If @SrvrAdm = 'Yes'
			Print 'ALTER SERVER ROLE serveradmin ADD MEMBER [' + @loginname + '] ;'

		If @ProcsAdm = 'Yes'
			Print 'ALTER SERVER ROLE processadmin ADD MEMBER [' + @loginname + '] ;'

		If @DiskAdm = 'Yes'
			Print 'ALTER SERVER ROLE diskadmin ADD MEMBER [' + @loginname + '] ;'

		--If @Sysadm = 'Yes'
		--	Print 'ALTER SERVER ROLE dbcreator ADD MEMBER [' + @loginname + '] ;'

		--If @Sysadm = 'Yes'
		--	Print 'ALTER SERVER ROLE bulkadmin ADD MEMBER [' + @loginname + '] ;'

		If @LoginName = 'spkchx\DevOpsTeam'
			Print 'ALTER SERVER ROLE DevOps_Role ADD MEMBER [spkchx\DevOpsTeam] ;'


	--Select name From sysobjects Where name Like '%role%'



			Fetch SecurityRoleCursor
			Into @LoginName,
				 @Sysadm,	
				 @SrvrAdm,
				 @ProcsAdm,
				 @DiskAdm,
				 @SecurAdm
	  End 

	Close SecurityRoleCursor
	Deallocate SecurityRoleCursor
  End
--**************************************************************************************
--select * into TempSecurityAccess from #SecurityAccess 
--select * into TempDBPermList from #DBPermList 

If @GenerateRoles = 'Yes'
  If @LoginIn is Null
	Select  'Use ' + DBName + ';'												As UseDatabase,
			'CREATE USER ' + UserName + ' FOR LOGIN ' + UserName + ';'			As AddUser,
			'EXEC sp_addrolemember ''' + RoleName +''', ''' + UserName + ''';'	As AddRole
	  from TempDBPermList 
  Else
  	Select  'Use ' + DBName + ';'												As UseDatabase,
			'CREATE USER ' + UserName + ' FOR LOGIN ' + UserName + ';'			As AddUser,
			'EXEC sp_addrolemember ''' + RoleName +''', ''' + UserName + ''';'	As AddRole
	  from #DBPermList 
     where UserName = @LoginIn

--**************************************************************************************
 Drop Table #SecurityAccess;

 Drop Table #DBPermList;

GO






