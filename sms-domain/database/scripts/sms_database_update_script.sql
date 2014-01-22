
\connect "school-management-database" "smsadmin";

-- Subject Tables
DROP SEQUENCE IF EXISTS subject_id_seq CASCADE;
CREATE SEQUENCE subject_id_seq START WITH 1;

DROP TABLE IF EXISTS subject CASCADE;
CREATE TABLE subject (
	id 						integer primary key  default nextval('subject_id_seq'),
	school_id 				integer references schools( id )  NOT NULL,
	subject_teacher_id    	integer references teachers(id) NOT NULL,
	class_id    			integer references class(id) NOT NULL,
	subject_teacher_name	varchar(255) NOT NULL,
	class_name				varchar(255) NOT NULL,
	subject_name			varchar(255) NOT NULL,
    status 					varchar(255) NOT NULL,
    created_by		    	varchar(255) NOT NULL,
    modified_by		    	varchar(255) NOT NULL,
	created_date 			timestamp  NOT NULL DEFAULT CURRENT_DATE,
	modified_date 			timestamp  NOT NULL DEFAULT CURRENT_DATE
);



