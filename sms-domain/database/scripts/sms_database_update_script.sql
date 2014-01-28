\connect "school-management-database" "smsadmin";

-- Student Table
DROP SEQUENCE IF EXISTS student_id_seq CASCADE;
CREATE SEQUENCE student_id_seq START WITH 1;

DROP TABLE IF EXISTS student CASCADE;
CREATE TABLE student(
	id 						integer primary key  default nextval('student_id_seq'),
	user_id 				integer references users( id )  NOT NULL,
	school_id 				integer references school( id )  NOT NULL,
    class_id 				integer references class( id )  NOT NULL,
    class_name				varchar( 255 ) NOT NULL,
	status					varchar( 255 ) NOT NULL,
	first_name      		varchar( 255 ) NOT NULL,
	last_name				varchar( 255 ) NOT NULL,
	sex						varchar( 20 ) NOT NULL,
	date_of_birth   		timestamp  NOT NULL,
	age	    				varchar( 20 ) NOT NULL,
	mobile_number	    	varchar( 255 ),
	email_address			varchar( 255 ),
	country_of_origin   	varchar( 255 ) NOT NULL,
	id_number				varchar( 255 ) NOT NULL,
	country_of_residence    varchar( 255 ) NOT NULL,
	province 				varchar(255) NOT NULL,
	city 					varchar(255) NOT NULL,
	address					varchar( 255 ) NOT NULL,
	suburb					varchar( 255 ) NOT NULL,
	postal_code				varchar( 255 ) NOT NULL,
	created_by 				varchar(255) NOT NULL,
	modified_by 			varchar(255) NOT NULL,
	created_date 			timestamp  NOT NULL DEFAULT CURRENT_DATE,
	modified_date 			timestamp  NOT NULL DEFAULT CURRENT_DATE
);



