# Database Version Control Module Documentation

## Overview:
The Database Version Control Module (VCM) was developed to provide a safe and easy way to install and upgrade database modules deployed on a given Oracle database instance.  The VCM provides information on which database module versions were installed and when they were installed on a database instance.  This module is used to apply the necessary database upgrades in the correct order to upgrade a given database module to a desired version.  Starting in Version 1.0 of the Application the VCM utilizes Oracle SQL*Plus to automate the deployment of the database.  

## Resources:
- Version Control Information:
  - URL: git@github.com:PIFSC-NMFS-NOAA/PIFSC-DBVersionControlModule.git
  - Database: 0.2 (git tag: [db_vers_ctrl_db_v0.2](https://github.com/PIFSC-NMFS-NOAA/PIFSC-DBVersionControlModule/releases/tag/db_vers_ctrl_db_v0.2))
  - Application: 1.0 (git tag: [db_vers_ctrl_v1.0](https://github.com/PIFSC-NMFS-NOAA/PIFSC-DBVersionControlModule/releases/tag/db_vers_ctrl_v1.0))
- [VCM SOP](./DB%20Version%20Control%20Module%20SOP.MD)
- [Database Naming Conventions](./DB%20Version%20Control%20Module%20DB%20Naming%20Conventions.MD)
- [Installing or Upgrading the DB Version Control Module](./Installing%20or%20Upgrading%20the%20DB%20Version%20Control%20Module.MD)
- Documentation Template:
  - This Database Installation/Upgrade template is provided so a given module that has had the Database Version Control Module installed can change the [placeholders](./placeholder_documentation.MD) (defined in enclosing brackets) and reference that document in the main technical document for the module.
    - [Installing or Upgrading the Database Documentation Template](./Template%20-%20Installing%20or%20Upgrading%20the%20Database.MD)
- Repository Templates:
  - The [repository_templates](./repository_templates) folder contains two folders for shared databases (shared_SQL) and dedicated databases (SQL).  The appropriate folder should be used for a given project.  
  - The deployment scripts (e.g. [deploy_dev.sql](./repository_templates/SQL/deploy_dev.sql)) are provided to streamline the process of automating the deployment of the database.

## Database Design:  
- Oracle Tables:
  - Each time a database upgrade is applied it will insert a record into the DB_UPGRADE_LOGS table that defines the numeric version and application/module name that was applied
- Oracle Views:
  - The DB_UPGRADE_LOGS_V view can be used to view the upgrade logs for a given database instance
- **Note: detailed object/column comments are defined on each table and view database objects
