This directory contains all DDL and DML commands to define the database structure and data (relevant reference data or application data but not any actual data that is being managed in the database) for the application(s) contained in the code repository.  The [DATABASE NAME]_combined_DDL_DML.sql file contains all of the DDL and DML commands necessary to create the database and populate any reference/application data from a blank Oracle schema where [DATABASE NAME] is the name of the database with underscores instead of spaces.  The files contained in the "upgrades" folder contain the SQL statements that were executed to make the database changes for a given code commit.  The naming convention is [DATABASE NAME]_DDL_DML_upgrade_v[MAJOR].[MINOR].sql where [MAJOR] is the major version of the database (integers starting from zero that are incremented by one without a leading zero) and [MINOR] is the minor version of the database (integers starting from zero that are incremented by one without a leading zero).  For example [DATABASE NAME]_DDL_DML_upgrade_v0.1.sql is the first minor version of a given database.  

The major and minor versions are up to the discretion of the developers, the only requirements are that each upgrade must be able to be executed on a blank schema in their order (major/minor version) to define the database to a given version.  The other requirement is that executing a given [DATABASE NAME]_DDL_DML_upgrade_v[MAJOR].[MINOR].sql version on a database of the previous version will upgrade the database version to the given [MAJOR].[MINOR] version (e.g. executing [DATABASE NAME]_DDL_DML_upgrade_v1.14.sql will upgrade an instance of the v1.13 database to v1.14).    

Not every application update will necessitate a corresponding database update but each code commit should have its comments reference the version of the database it uses so that the database and application code versions on any master branch commit are in sync.


Database version control structure for multiple applications/modules in one repository that use the same database (e.g. PIFSC Data Set Database):

root folder (directory)
|
|
|
-----shared_SQL (directory)
     |
     |
     |
     -----[DATABASE NAME]_combined_DDL_DML.sql
     |
     |
     |
     -----README.txt (this file)
     |
     |
     |
     -----upgrades (directory)
          |
          |
          |
          -----[DATABASE NAME]_DDL_DML_upgrade_v[MAJOR].[MINOR].sql (multiple files)

     
Database version control structure for repositories that have an exclusive database model that is not shared between multiple applications/modules (e.g. Database Version Control Module):

Module folder (directory)
|
|
|
-----SQL (directory)
     |
     |
     |
     -----[DATABASE NAME]_combined_DDL_DML.sql
     |
     |
     |
     -----README.txt (this file)
     |
     |
     |
     -----upgrades (directory)
          |
          |
          |
          -----[DATABASE NAME]_DDL_DML_upgrade_v[MAJOR].[MINOR].sql (multiple files)