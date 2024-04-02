--------------------------------------------------------
--------------------------------------------------------
--Database Name: Database Version Control 
--Database Description: This database was originally designed track database upgrades over time to different database instances to ensure that the upgrade history for a given database instance is documented and tracked.  
--------------------------------------------------------
--------------------------------------------------------


-------------------------------------------------------------------
--Database Version Control - version 0.2 rollback:
-------------------------------------------------------------------


ALTER TABLE DB_UPGRADE_LOGS
DROP CONSTRAINT DB_UPGRADE_LOGS_U1; 

ALTER VIEW DB_UPGRADE_LOGS_V COMPILE;

--remove the DB upgrade log record
DELETE FROM DB_UPGRADE_LOGS WHERE UPGRADE_APP_NAME = 'Database Version Control' AND UPGRADE_VERSION = '0.2';

--commit the DB_UPGRADE_LOGS record insertion
COMMIT;