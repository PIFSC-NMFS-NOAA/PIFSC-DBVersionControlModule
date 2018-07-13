--------------------------------------------------------
--------------------------------------------------------
--Database Name: Database Version Control 
--Database Description: This database was originally designed track database upgrades over time to different database instances to ensure that the upgrade history for a given database instance is documented and tracked.  
--------------------------------------------------------
--------------------------------------------------------

--------------------------------------------------------
--Database Version Control - Combined DDL/DML file:
--------------------------------------------------------


--add each database upgrade file in sequential order here:
@@"./upgrades/DB_version_control_DDL_DML_upgrade_v0.1.sql"
@@"./upgrades/DB_version_control_DDL_DML_upgrade_v0.2.sql"