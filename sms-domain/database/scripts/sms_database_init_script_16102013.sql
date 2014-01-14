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






--Users Table
DROP SEQUENCE IF EXISTS users_id_seq CASCADE;
CREATE SEQUENCE users_id_seq START WITH 1000;

DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users(
	id integer primary key  default nextval('users_id_seq'),
	username varchar(255) unique NOT NULL,
	password varchar(255) NOT NULL,
	group_name varchar(255) NOT NULL,
	status varchar( 255 ) NOT NULL,
	created_by varchar(255) NOT NULL,
	created_date timestamp  NOT NULL DEFAULT CURRENT_DATE,
	modified_date timestamp  NOT NULL DEFAULT CURRENT_DATE
);







-- System Admin Tables
DROP SEQUENCE IF EXISTS system_admin_entity_id_seq CASCADE;
CREATE SEQUENCE system_admin_entity_id_seq START WITH 1;

DROP TABLE IF EXISTS system_admin_entity CASCADE;
CREATE TABLE system_admin_entity(
	id integer primary key  default nextval('system_admin_entity_id_seq'),
	user_id integer references users( id )  NOT NULL
);

DROP SEQUENCE IF EXISTS system_admin_entity_attributes_id_seq CASCADE;
CREATE SEQUENCE system_admin_entity_attributes_id_seq START WITH 1;

DROP TABLE IF EXISTS system_admin_entity_attributes CASCADE;
CREATE TABLE system_admin_entity_attributes(
	id integer primary key  default nextval( 'system_admin_entity_attributes_id_seq' ),
	admin_entity_id integer references system_admin_entity(id)  NOT NULL,
	attribute varchar( 255 ) NOT NULL,
	attribute_value text NOT NULL
);





-- Agents Table
DROP SEQUENCE IF EXISTS agent_entity_id_seq CASCADE;
CREATE SEQUENCE agent_entity_id_seq START WITH 1;

DROP TABLE IF EXISTS agent_entity CASCADE;
CREATE TABLE agent_entity(
	id integer primary key  default nextval('agent_entity_id_seq'),
	user_id integer references users( id )  NOT NULL
);

DROP SEQUENCE IF EXISTS agent_entity_attributes_id_seq CASCADE;
CREATE SEQUENCE agent_entity_attributes_id_seq START WITH 1;

DROP TABLE IF EXISTS agent_entity_attributes CASCADE;
CREATE TABLE agent_entity_attributes(
	id integer primary key  default nextval( 'agent_entity_attributes_id_seq' ),
	agent_entity_id integer references agent_entity( id )  NOT NULL,
	attribute varchar( 255 ) NOT NULL,
	attribute_value text NOT NULL
);

