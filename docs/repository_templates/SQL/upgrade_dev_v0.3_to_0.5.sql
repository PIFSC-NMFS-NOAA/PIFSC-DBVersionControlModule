/************************************************************************************
 Filename   : upgrade_dev_v0.3_to_0.5.sql
 Author     : Jesse Abdul
 Purpose    : Upgrade the development [DB Name] DB from version 0.3 to 0.5
 Description: The release included: an upgrade of the existing database
 Usage: Using Windows X open a command line window and change the directory to the [SQL Directory] directory in the working copy of the repository and execute the script using the "@" syntax.  When prompted enter the server credentials in the format defined in the corresponding code comments
************************************************************************************/
SET FEEDBACK ON
SET TRIMSPOOL ON
SET VERIFY OFF
SET SQLBLANKLINES ON
SET AUTOCOMMIT OFF
SET EXITCOMMIT OFF
SET ECHO ON

WHENEVER SQLERROR EXIT 1
WHENEVER OSERROR  EXIT 1

SET DEFINE ON

-- Provide credentials in the form: USER@TNS/PASSWORD when using a TNS Name
-- Provide credentials in the form: USER/PASSWORD@HOSTNAME/SID when specifying hostname and SID values
DEFINE apps_credentials=&1
CONNECT &apps_credentials


COL spool_fname NEW_VALUE spoolname NOPRINT
SELECT '[DB Name]_upgrade_dev_v0.3_to_0.5_' || TO_CHAR( SYSDATE, 'yyyymmdd' ) spool_fname FROM DUAL;
SPOOL logs/&spoolname APPEND


SET DEFINE OFF
SHOW USER;

PROMPT running DDL scripts to upgrade the database from 0.3 to 0.5
@@[DB Name]_DDL_DML_upgrade_v0.4.sql
@@[DB Name]_DDL_DML_upgrade_v0.5.sql


DISCONNECT;

SET DEFINE ON

SPOOL OFF
EXIT
