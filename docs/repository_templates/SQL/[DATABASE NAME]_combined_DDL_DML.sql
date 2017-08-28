--------------------------------------------------------
--------------------------------------------------------
--Database Name: [DATABASE NAME]
--Database Description: [DATABASE DESCRIPTION]
--------------------------------------------------------
--------------------------------------------------------


--------------------------------------------------------
--Combined DDL/DML file:
--------------------------------------------------------


--------------------------------------------------------
--version [MAJOR].[MINOR] updates:
--------------------------------------------------------


--define the upgrade version in the database upgrade log table:
INSERT INTO DB_UPGRADE_LOGS (UPGRADE_APP_NAME, UPGRADE_VERSION, UPGRADE_DATE, UPGRADE_DESC) VALUES ('[DATABASE NAME]', '[MAJOR].[MINOR]', TO_DATE('[UPGRADE_DATE]', 'DD-MON-YY'), '[UPGRADE DESCRIPTION]');