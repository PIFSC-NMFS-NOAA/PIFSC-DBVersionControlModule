--------------------------------------------------------
--------------------------------------------------------
--Database Name: Database Version Control 
--Database Description: This database was originally designed track database upgrades over time to different database instances to ensure that the upgrade history for a given database instance is documented and tracked.  
--------------------------------------------------------
--------------------------------------------------------


-------------------------------------------------------------------
--Database Version Control - version 1.0 rollback:
-------------------------------------------------------------------


--updated DB_UPGRADE_LOGS to change the 
ALTER TABLE DB_UPGRADE_LOGS 
ADD (UPGRADE_DESC_TEMP VARCHAR2 (2000));

--transfer the first 2000 characters of the existing description data to a temporary column
UPDATE DB_UPGRADE_LOGS SET UPGRADE_DESC_TEMP = SUBSTR(UPGRADE_DESC, 1, 2000);


ALTER TABLE DB_UPGRADE_LOGS 
DROP COLUMN UPGRADE_DESC;



ALTER TABLE DB_UPGRADE_LOGS RENAME COLUMN UPGRADE_DESC_TEMP TO UPGRADE_DESC;


COMMENT ON COLUMN DB_UPGRADE_LOGS.UPGRADE_DESC IS 'Description of the given database upgrade';

ALTER VIEW DB_UPGRADE_LOGS_V COMPILE;


--remove the DB upgrade log record
DELETE FROM DB_UPGRADE_LOGS WHERE UPGRADE_APP_NAME = 'Database Version Control' AND UPGRADE_VERSION = '1.0';

--commit the DB_UPGRADE_LOGS record insertion
COMMIT;