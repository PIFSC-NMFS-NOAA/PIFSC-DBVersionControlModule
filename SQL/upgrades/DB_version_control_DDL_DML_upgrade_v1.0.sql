--------------------------------------------------------
--------------------------------------------------------
--Database Name: Database Version Control 
--Database Description: This database was originally designed track database upgrades over time to different database instances to ensure that the upgrade history for a given database instance is documented and tracked.  
--------------------------------------------------------
--------------------------------------------------------


-------------------------------------------------------------------
--Database Version Control - version 1.0 updates:
-------------------------------------------------------------------


--updated DB_UPGRADE_LOGS to change the 
ALTER TABLE DB_UPGRADE_LOGS 
ADD (UPGRADE_DESC_TEMP CLOB );

--transfer the description data to a temporary column
UPDATE DB_UPGRADE_LOGS SET UPGRADE_DESC_TEMP = UPGRADE_DESC;


ALTER TABLE DB_UPGRADE_LOGS 
DROP COLUMN UPGRADE_DESC;



ALTER TABLE DB_UPGRADE_LOGS RENAME COLUMN UPGRADE_DESC_TEMP TO UPGRADE_DESC;


COMMENT ON COLUMN DB_UPGRADE_LOGS.UPGRADE_DESC IS 'Description of the given database upgrade';

ALTER VIEW DB_UPGRADE_LOGS_V COMPILE;


--define the upgrade version in the database:
INSERT INTO DB_UPGRADE_LOGS (UPGRADE_APP_NAME, UPGRADE_VERSION, UPGRADE_DATE, UPGRADE_DESC) VALUES ('Database Version Control', '1.0', TO_DATE('27-NOV-23', 'DD-MON-YY'), 'Upgraded the UPGRADE_DESC column to a CLOB to expand the size of upgrade descriptions');

--commit the DB_UPGRADE_LOGS record insertion
COMMIT;