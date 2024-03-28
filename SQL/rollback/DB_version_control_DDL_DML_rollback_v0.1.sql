--------------------------------------------------------
--------------------------------------------------------
--Database Name: Database Version Control 
--Database Description: This database was originally designed track database upgrades over time to different database instances to ensure that the upgrade history for a given database instance is documented and tracked.  
--------------------------------------------------------
--------------------------------------------------------


-------------------------------------------------------------------
--Database Version Control - version 0.1 updates:
-------------------------------------------------------------------


DROP VIEW DB_UPGRADE_LOGS_V;

DROP TRIGGER DB_UPGRADE_LOGS_AUTO_BRI;

DROP SEQUENCE DB_UPGRADE_LOGS_SEQ;

DROP TABLE DB_UPGRADE_LOGS;
