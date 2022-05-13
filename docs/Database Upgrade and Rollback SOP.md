# Database Upgrade and Rollback SOP

## Overview
This document defines a standard procedure for developing an upgrade and rollback plan for a given in-place database upgrade.  This is intended for performing production database upgrades to reduce downtime and provide a method to revert the database to the pre-upgrade state in the event that the upgrade fails.

## Resources
-   Version Control Information:
    -   URL: git@github.com:PIFSC-NMFS-NOAA/PIFSC-DBVersionControlModule.git
    -   Version: 1.1 (Git tag: db_vers_upgrade_rollback_v1.1)
-   [Database Version Control Module (VCM) SOP](./DB%20Version%20Control%20Module%20SOP.MD)
-   [Automated App Deployments (AAD)](https://picgitlab.nmfs.local/centralized-data-tools/automated-app-deployments)
    -   [Automated APEX Deployment SOP](https://picgitlab.nmfs.local/centralized-data-tools/automated-app-deployments/-/blob/master/apex/automated_APEX_deployment_SOP.md)
-   [Centralized Utilities Database (CUD)](https://picgitlab.nmfs.local/centralized-data-tools/centralized-utilities)
-   [PIFSC Personnel Tracking System (PTS)](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-facilities-tracking)
    -   Example: [PTS Version 2.1 Deployment Scripts](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-facilities-tracking/-/blob/master/docs/release_documentation/version%202.1/Deployment%20Scripts/README.md)

## Procedure
-   Determine the version of the database that will be upgraded in place (pre-upgrade version) and the version of the database it will upgraded to (post-upgrade version)
-   ### Database Upgrade/Rollback Development
    -   Deploy the pre-upgrade version of the database
        -   Develop an automated SQL*Plus deployment script that logs and executes the database upgrade files necessary to deploy the pre-upgrade version of the database to a blank schema and loads any required data and grants any required permissions (for dependent schemas).  Create a version for each of the database instances you will be deploying the database to
            -   Example: [PTS deploy_dev_v0.11.sql](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-facilities-tracking/-/blob/master/docs/release_documentation/version%202.1/Deployment%20Scripts/automated%20deployments/deploy_dev_v0.11.sql)
    -   Upgrade the pre-upgrade version of the database to the post-upgrade version
        -   Develop an automated SQL*Plus upgrade script that logs and executes the database upgrade files necessary to upgrade the database from the pre-upgrade version to the post-upgrade version and loads any required data and grants any required permissions (for dependent schemas).  Create a version for each of the database instances you will be deploying the database to
            -   Example: [PTS upgrade_dev_v0.11_to_1.6.sql](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-facilities-tracking/-/blob/master/docs/release_documentation/version%202.1/Deployment%20Scripts/automated%20deployments/upgrade_dev_v0.11_to_1.6.sql)
    -   Rollback the post-upgrade version of the database to the pre-upgrade version
        -   Develop a SQL script that contains the DDL/DML statements necessary to revert the objects in the database from the post-upgrade to the pre-upgrade state.  This can be done by examining the DDL/DML changes made during the database upgrade process.
            -   Example: [PTS db_downgrade_v1.6_to_v0.11.sql](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-facilities-tracking/-/blob/master/docs/release_documentation/version%202.1/Deployment%20Scripts/rollback/db_downgrade_v1.6_to_v0.11.sql)
        -   Develop an automated SQL*Plus rollback script that logs and executes the database upgrade files necessary to revert the post-upgrade version of the database to the pre-upgrade version and loads any required data and grants any required permissions (for dependent schemas).  Create a version for each of the database instances you will be deploying the database to
            -   Example: [PTS deploy_dev_rollback_to_0.11.sql](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-facilities-tracking/-/blob/master/docs/release_documentation/version%202.1/Deployment%20Scripts/automated%20deployments/deploy_dev_rollback_to_0.11.sql)
-   ### Testing Database Upgrade/Rollback Process
    -   Use case information:
        -   An existing production version of the database is deployed (pre-upgrade version)
        -   An existing test version of the database is deployed for user/security testing (post-upgrade version)
    -   #### Testing the development scripts
        -   Drop all objects in the development schema
        -   Execute the automated development version of the SQL*Plus deployment script on a blank development schema
            -   Compare the development and production database schemas using the Oracle SQL Developer Database Diff tool to confirm they are identical
        -   Execute the automated development version of the SQL*Plus upgrade script on the development schema to upgrade it to the post-upgrade version of the database
            -   Compare the development and test database schemas using the Oracle SQL Developer Database Diff tool to confirm they are identical
        -   Execute the automated development version of the SQL*Plus rollback script on the development database schema
            -   Compare the development and production database schemas using the Oracle SQL Developer Database Diff tool to confirm they are identical
    -   #### Testing the test scripts
        -   Drop all objects in the development schema and deploy the post-upgrade version of the database to the development schema using the standard development database deployment script (example: [PTS deploy_dev.sql](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-facilities-tracking/-/blob/master/SQL/deploy_dev.sql)).  
        -   Perform the same process as the [development scripts](#testing-the-development-scripts) with the test version of the scripts on the test schema and compare it to the development schema for the post-upgrade version.  
-   ### Production Database Upgrade/Rollback Process
    -   #### Automated rollback procedure
        -   Note: this is the most desirable option because it uses an automated approach that does not risk data loss due to issues with the data export/import processes
        -   Perform a complete backup of the data in the given database instance and save the exported data (e.g. sql insert statements in .sql format)
        -   Execute the production version of the SQL*Plus upgrade script
        -   Perform the corresponding application upgrades (when applicable)
            -   verify the application(s) are working properly
        -   Verify the database was upgraded successfully (no errors and all dependent schemas are working properly)
            -   If so, the database upgrade was successful
            -   If not, rollback the database upgrade
                -   Execute the production version of the SQL*Plus rollback script
                -   Rollback corresponding application upgrades (when applicable)
                    -   verify the application(s) are working properly
                -   Verify the database was rolled back successfully (no errors and all dependent schemas are working properly)
                    -   If so, the database rollback was successful and the upgrade must be redeveloped before it is attempted again based on the issues
                    -   If not, the [database must be restored](#database-backup-rollback) from the backup taken before the database upgrade was attempted
    -   #### Database Backup Rollback
        -   Note: this option should be used in the event that [Automated rollback procedure](#automated-rollback-procedure) does not work and the given database schema is in a corrupted, intermediate state.  This is not the preferred method for restoring a production database but it can be used as a last resort when both the database upgrade and rollback failed.
        -   Drop all database objects
        -   Restore the database objects for the desired version from source code
            -   Execute the automated production version of the SQL*Plus deployment script on the blank schema
        -   Import the exported data back into the restored database schema
            -   Disable all foreign keys/triggers (example: [CUD Disable Foreign Keys/Triggers procedure](https://picgitlab.nmfs.local/centralized-data-tools/centralized-utilities/-/blob/master/docs/packages/UDP_UDLP/UDP%20UDLP%20Documentation.md#udp-and-udlp-stored-procedure-information))
            -   load the exported data by executing the SQL export file
            -   Reset the sequences based on the restored data (example: [CUD Reset Sequences procedure](https://picgitlab.nmfs.local/centralized-data-tools/centralized-utilities/-/blob/master/docs/packages/UDP_UDLP/UDP%20UDLP%20Documentation.md#udp-and-udlp-stored-procedure-information))
            -   Recompile and enable all invalid triggers (example: [CUD Enable Foreign Keys/Triggers procedure](https://picgitlab.nmfs.local/centralized-data-tools/centralized-utilities/-/blob/master/docs/packages/UDP_UDLP/UDP%20UDLP%20Documentation.md#udp-and-udlp-stored-procedure-information))
        -   Verify the database was restored successfully (no errors and all dependent schemas are working properly)
