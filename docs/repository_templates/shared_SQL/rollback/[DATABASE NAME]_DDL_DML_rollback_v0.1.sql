--------------------------------------------------------
--------------------------------------------------------
--Database Name: [DATABASE NAME]
--Database Description: [DATABASE DESCRIPTION]
--------------------------------------------------------
--------------------------------------------------------


--------------------------------------------------------
--[DATABASE NAME] - version [MAJOR].[MINOR] rollback:
--------------------------------------------------------


--define the upgrade version in the database upgrade log table:
DELETE FROM DB_UPGRADE_LOGS WHERE UPGRADE_APP_NAME = '[DATABASE NAME]' AND UPGRADE_VERSION = '[MAJOR].[MINOR]';

--commit the DB_UPGRADE_LOGS record removal
COMMIT;