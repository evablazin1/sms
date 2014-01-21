
\connect "school-management-database" "smsadmin";

-- Class Tables
DROP SEQUENCE IF EXISTS class_id_seq CASCADE;
CREATE SEQUENCE class_id_seq START WITH 1;

DROP TABLE IF EXISTS class CASCADE;
CREATE TABLE class(
	id 					integer primary key  default nextval('class_id_seq'),
	school_id 			integer references schools( id )  NOT NULL,
	class_teacher_id    integer references teachers(id) NOT NULL,
	class_name			varchar(255) NOT NULL,
    status 				varchar(255) NOT NULL,
    created_by		    varchar(255) NOT NULL,
    modified_by		    varchar(255) NOT NULL,
	created_date 		timestamp  NOT NULL DEFAULT CURRENT_DATE,
	modified_date 		timestamp  NOT NULL DEFAULT CURRENT_DATE
);



