--
-- Database 
-- creation script should only be run if you deploying this application for the first time or refreshing the entire db.

-- Usage
-- start postgres
-- psql --username=postgres --file=_location_of_this_script_

-- Variable Definition
\set  role 				"smsadmin";
\set  role_password 	'\'' '$ch00ld@+@b@$3' '\'';
\set  database          "school-management-database";

-- Clean up database
-- Drop Roles and Database
DROP DATABASE IF EXISTS :database;
DROP ROLE IF EXISTS :role;


CREATE ROLE "smsadmin" WITH CREATEDB CREATEUSER LOGIN ENCRYPTED PASSWORD :role_password;

CREATE DATABASE "school-management-database" WITH ENCODING='UTF8' OWNER="smsadmin" CONNECTION LIMIT=-1;
	COMMENT ON DATABASE "school-management-database" IS 'school management database';

-- Connect to school management database before proceeding with the next commands

\connect "school-management-database" "smsadmin";


-- Entity
DROP SEQUENCE IF EXISTS entity_id_seq CASCADE;
CREATE SEQUENCE entity_id_seq START WITH 1;

DROP TABLE IF EXISTS entity CASCADE;
CREATE TABLE entity(
	id integer primary key  default nextval('entity_id_seq'),
	status varchar( 255 ),
	created_date timestamp  NOT NULL DEFAULT CURRENT_DATE,
	modified_date timestamp  NOT NULL DEFAULT CURRENT_DATE
);

DROP SEQUENCE IF EXISTS entity_attributes_id_seq CASCADE;
CREATE SEQUENCE entity_attributes_id_seq START WITH 1;

DROP TABLE IF EXISTS entity_attributes CASCADE;
CREATE TABLE entity_attributes(
	id integer primary key  default nextval( 'entity_attributes_id_seq' ),
	entity_id integer references entity( id )  NOT NULL,
	attribute varchar( 255 ) NOT NULL,
	attribute_value text NOT NULL
);
