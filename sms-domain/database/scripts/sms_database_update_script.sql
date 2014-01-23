\connect "school-management-database" "smsadmin";

-- Subject Tables
DROP SEQUENCE IF EXISTS subject_id_seq CASCADE;
CREATE SEQUENCE subject_id_seq START WITH 1;

DROP TABLE IF EXISTS subject CASCADE;
CREATE TABLE subject (
	id 						integer primary key  default nextval('subject_id_seq'),
	school_id 				integer references school(id)  NOT NULL,
	subject_name			varchar(255) NOT NULL,
    status 					varchar(255) NOT NULL,
    created_by		    	varchar(255) NOT NULL,
    modified_by		    	varchar(255) NOT NULL,
	created_date 			timestamp  NOT NULL DEFAULT CURRENT_DATE,
	modified_date 			timestamp  NOT NULL DEFAULT CURRENT_DATE
);


-- SubjectTeacher Tables
DROP SEQUENCE IF EXISTS subject_teacher_id_seq CASCADE;
CREATE SEQUENCE subject_teacher_id_seq START WITH 1;

DROP TABLE IF EXISTS subject_teacher CASCADE;
CREATE TABLE subject_teacher (
	id 						integer primary key  default nextval('subject_teacher_id_seq'),
	school_id 				integer references school(id)  NOT NULL,
	class_id    			integer references class(id),
	subject_teacher_id    	integer references teacher(id),
	subject_id    			integer references subject(id) NOT NULL,
	subject_teacher_name	varchar(255),
	class_name				varchar(255),
	subject_name			varchar(255) NOT NULL,
    status 					varchar(255) NOT NULL,
    created_by		    	varchar(255) NOT NULL,
    modified_by		    	varchar(255) NOT NULL,
	created_date 			timestamp  NOT NULL DEFAULT CURRENT_DATE,
	modified_date 			timestamp  NOT NULL DEFAULT CURRENT_DATE
);