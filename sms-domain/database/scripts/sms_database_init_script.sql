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
	id 				integer primary key  default nextval('users_id_seq'),
	fullname 		varchar(255) NOT NULL,
	username 		varchar(255) unique NOT NULL,
	password 		varchar(255) NOT NULL,
	status 			varchar( 255 ) NOT NULL,
	created_by 		varchar(255) NOT NULL,
	created_date 	timestamp  NOT NULL DEFAULT CURRENT_DATE,
	modified_date 	timestamp  NOT NULL DEFAULT CURRENT_DATE
);



--User Group Table
DROP SEQUENCE IF EXISTS user_groups_id_seq CASCADE;
CREATE SEQUENCE user_groups_id_seq START WITH 1000;

DROP TABLE IF EXISTS user_groups CASCADE;
CREATE TABLE user_groups(
	id 				integer primary key  default nextval('user_groups_id_seq'),
	user_id         integer references users(id)  NOT NULL,
    group_name		varchar(255) NOT NULL
);



-- System Admin Entity Tables
DROP SEQUENCE IF EXISTS system_admin_entity_id_seq CASCADE;
CREATE SEQUENCE system_admin_entity_id_seq START WITH 1;

DROP TABLE IF EXISTS system_admin_entity CASCADE;
CREATE TABLE system_admin_entity(
	id 				integer primary key  default nextval('system_admin_entity_id_seq'),
	user_id 		integer references users( id )  NOT NULL
);


-- System Admin Entity Attributes Tables
DROP SEQUENCE IF EXISTS system_admin_entity_attributes_id_seq CASCADE;
CREATE SEQUENCE system_admin_entity_attributes_id_seq START WITH 1;

DROP TABLE IF EXISTS system_admin_entity_attributes CASCADE;
CREATE TABLE system_admin_entity_attributes(
	id 					integer primary key  default nextval( 'system_admin_entity_attributes_id_seq' ),
	admin_entity_id 	integer references system_admin_entity(id)  NOT NULL,
	attribute 			varchar( 255 ) NOT NULL,
	attribute_value 	text NOT NULL
);



-- School Entity Tables
DROP SEQUENCE IF EXISTS school_entity_id_seq CASCADE;
CREATE SEQUENCE school_entity_id_seq START WITH 1;

DROP TABLE IF EXISTS school_entity CASCADE;
CREATE TABLE school_entity(
	id 					integer primary key  default nextval('school_entity_id_seq'),
    school_name 		varchar(255) not null,
    status 				varchar(255) not null,
    created_by		    varchar(255) not null,
	created_date 		timestamp  NOT NULL DEFAULT CURRENT_DATE,
	modified_date 		timestamp  NOT NULL DEFAULT CURRENT_DATE
);


-- School Entity Attributes Tables
DROP SEQUENCE IF EXISTS school_entity_attributes_id_seq CASCADE;
CREATE SEQUENCE school_entity_attributes_id_seq START WITH 1;

DROP TABLE IF EXISTS school_entity_attributes CASCADE;
CREATE TABLE school_entity_attributes(
	id 					integer primary key  default nextval('school_entity_attributes_id_seq'),
	school_entity_id 	integer references school_entity( id )  NOT NULL,
	attribute 			varchar(255) not null,
	attribute_value 	varchar(255)
);





























-- Countries Table
DROP SEQUENCE IF EXISTS country_id_seq CASCADE;
CREATE SEQUENCE country_id_seq START WITH 1;

DROP TABLE IF EXISTS country CASCADE;
CREATE TABLE country(
    id  			integer primary key  default nextval('country_id_seq'),
    country_code    varchar(20) UNIQUE  NOT NULL,
    country_name    text unique NOT NULL
);



--Province/Region/State Table
DROP SEQUENCE IF EXISTS province_id_seq CASCADE;
CREATE SEQUENCE province_id_seq START WITH 1;

DROP TABLE IF EXISTS province CASCADE;
CREATE TABLE province(
    id            	integer primary key  default nextval('province_id_seq'),
    country_code    text REFERENCES country(country_code) NOT NULL,
    province_code   varchar(20) UNIQUE NOT NULL,
    province_name   text UNIQUE NOT NULL
);



--City Table
DROP SEQUENCE IF EXISTS city_id_seq CASCADE;
CREATE SEQUENCE city_id_seq START WITH 1;

DROP TABLE IF EXISTS city CASCADE;
CREATE TABLE city(
    id             integer primary key  default nextval( 'city_id_seq' ),
    province_code  varchar(20) REFERENCES province(province_code) NOT NULL,
    city_name           TEXT NOT NULL
);






--Insert Statements
-- Countries
INSERT     INTO country (country_code,country_name) VALUES  ('AD','Andorra' );
INSERT     INTO country (country_code,country_name) VALUES  ('AE','United Arab Emirates');
INSERT     INTO country (country_code,country_name) VALUES  ('AF','Afghanistan');
INSERT     INTO country (country_code,country_name) VALUES  ('AG','Antigua and Barbuda');
INSERT     INTO country (country_code,country_name) VALUES  ('AI','Anguilla');
INSERT     INTO country (country_code,country_name) VALUES  ('AL','Albania');
INSERT     INTO country (country_code,country_name) VALUES  ('AM','Armenia');
INSERT     INTO country (country_code,country_name) VALUES  ('AN','Netherlands Antilles');
INSERT     INTO country (country_code,country_name) VALUES  ('AO','Angola');
INSERT     INTO country (country_code,country_name) VALUES  ('AP','Asia/Pacific Region');
INSERT     INTO country (country_code,country_name) VALUES  ('AQ','Antarctica');
INSERT     INTO country (country_code,country_name) VALUES  ('AR','Argentina');
INSERT     INTO country (country_code,country_name) VALUES  ('AS','American Samoa');
INSERT     INTO country (country_code,country_name) VALUES  ('AT','Austria');
INSERT     INTO country (country_code,country_name) VALUES  ('AU','Australia');
INSERT     INTO country (country_code,country_name) VALUES  ('AW','Aruba');
INSERT     INTO country (country_code,country_name) VALUES  ('AX','Aland Islands');
INSERT     INTO country (country_code,country_name) VALUES  ('AZ','Azerbaijan');
INSERT     INTO country (country_code,country_name) VALUES  ('BA','Bosnia and Herzegovina');
INSERT     INTO country (country_code,country_name) VALUES  ('BB','Barbados');
INSERT     INTO country (country_code,country_name) VALUES  ('BD','Bangladesh');
INSERT     INTO country (country_code,country_name) VALUES  ('BE','Belgium');
INSERT     INTO country (country_code,country_name) VALUES  ('BF','Burkina Faso');
INSERT     INTO country (country_code,country_name) VALUES  ('BG','Bulgaria');
INSERT     INTO country (country_code,country_name) VALUES  ('BH','Bahrain');
INSERT     INTO country (country_code,country_name) VALUES  ('BI','Burundi');
INSERT     INTO country (country_code,country_name) VALUES  ('BJ','Benin');
INSERT     INTO country (country_code,country_name) VALUES  ('BM','Bermuda');
INSERT     INTO country (country_code,country_name) VALUES  ('BN','Brunei Darussalam');
INSERT     INTO country (country_code,country_name) VALUES  ('BO','Bolivia');
INSERT     INTO country (country_code,country_name) VALUES  ('BR','Brazil');
INSERT     INTO country (country_code,country_name) VALUES  ('BS','Bahamas');
INSERT     INTO country (country_code,country_name) VALUES  ('BT','Bhutan');
INSERT     INTO country (country_code,country_name) VALUES  ('BV','Bouvet Island');
INSERT     INTO country (country_code,country_name) VALUES  ('BW','Botswana');
INSERT     INTO country (country_code,country_name) VALUES  ('BY','Belarus');
INSERT     INTO country (country_code,country_name) VALUES  ('BZ','Belize');
INSERT     INTO country (country_code,country_name) VALUES  ('CA','Canada');
INSERT     INTO country (country_code,country_name) VALUES  ('CD','Congo, The Democratic Republic of the');
INSERT     INTO country (country_code,country_name) VALUES  ('CF','Central African Republic');
INSERT     INTO country (country_code,country_name) VALUES  ('CG','Congo');
INSERT     INTO country (country_code,country_name) VALUES  ('CH','Switzerland');
INSERT     INTO country (country_code,country_name) VALUES  ('CI','Cote D''Ivoire');
INSERT     INTO country (country_code,country_name) VALUES  ('CK','Cook Islands');
INSERT     INTO country (country_code,country_name) VALUES  ('CL','Chile');
INSERT     INTO country (country_code,country_name) VALUES  ('CM','Cameroon');
INSERT     INTO country (country_code,country_name) VALUES  ('CN','China');
INSERT     INTO country (country_code,country_name) VALUES  ('CO','Colombia');
INSERT     INTO country (country_code,country_name) VALUES  ('CR','Costa Rica');
INSERT     INTO country (country_code,country_name) VALUES  ('CU','Cuba');
INSERT     INTO country (country_code,country_name) VALUES  ('CV','Cape Verde');
INSERT     INTO country (country_code,country_name) VALUES  ('CY','Cyprus');
INSERT     INTO country (country_code,country_name) VALUES  ('CZ','Czech Republic');
INSERT     INTO country (country_code,country_name) VALUES  ('DE','Germany');
INSERT     INTO country (country_code,country_name) VALUES  ('DJ','Djibouti');
INSERT     INTO country (country_code,country_name) VALUES  ('DK','Denmark');
INSERT     INTO country (country_code,country_name) VALUES  ('DM','Dominica');
INSERT     INTO country (country_code,country_name) VALUES  ('DO','Dominican Republic');
INSERT     INTO country (country_code,country_name) VALUES  ('DZ','Algeria');
INSERT     INTO country (country_code,country_name) VALUES  ('EC','Ecuador');
INSERT     INTO country (country_code,country_name) VALUES  ('EE','Estonia');
INSERT     INTO country (country_code,country_name) VALUES  ('EG','Egypt');
INSERT     INTO country (country_code,country_name) VALUES  ('ER','Eritrea');
INSERT     INTO country (country_code,country_name) VALUES  ('ES','Spain');
INSERT     INTO country (country_code,country_name) VALUES  ('ET','Ethiopia');
INSERT     INTO country (country_code,country_name) VALUES  ('EU','Europe');
INSERT     INTO country (country_code,country_name) VALUES  ('FI','Finland');
INSERT     INTO country (country_code,country_name) VALUES  ('FJ','Fiji');
INSERT     INTO country (country_code,country_name) VALUES  ('FK','Falkland Islands (Malvinas)');
INSERT     INTO country (country_code,country_name) VALUES  ('FM','Micronesia, Federated States of');
INSERT     INTO country (country_code,country_name) VALUES  ('FO','Faroe Islands');
INSERT     INTO country (country_code,country_name) VALUES  ('FR','France');
INSERT     INTO country (country_code,country_name) VALUES  ('GA','Gabon');
INSERT     INTO country (country_code,country_name) VALUES  ('GB','United Kingdom');
INSERT     INTO country (country_code,country_name) VALUES  ('GD','Grenada');
INSERT     INTO country (country_code,country_name) VALUES  ('GE','Georgia');
INSERT     INTO country (country_code,country_name) VALUES  ('GF','French Guiana');
INSERT     INTO country (country_code,country_name) VALUES  ('GG','Guernsey');
INSERT     INTO country (country_code,country_name) VALUES  ('GH','Ghana');
INSERT     INTO country (country_code,country_name) VALUES  ('GI','Gibraltar');
INSERT     INTO country (country_code,country_name) VALUES  ('GL','Greenland');
INSERT     INTO country (country_code,country_name) VALUES  ('GM','Gambia');
INSERT     INTO country (country_code,country_name) VALUES  ('GN','Guinea');
INSERT     INTO country (country_code,country_name) VALUES  ('GP','Guadeloupe');
INSERT     INTO country (country_code,country_name) VALUES  ('GQ','Equatorial Guinea');
INSERT     INTO country (country_code,country_name) VALUES  ('GR','Greece');
INSERT     INTO country (country_code,country_name) VALUES  ('GT','Guatemala');
INSERT     INTO country (country_code,country_name) VALUES  ('GU','Guam');
INSERT     INTO country (country_code,country_name) VALUES  ('GW','Guinea-Bissau');
INSERT     INTO country (country_code,country_name) VALUES  ('GY','Guyana');
INSERT     INTO country (country_code,country_name) VALUES  ('HK','Hong Kong');
INSERT     INTO country (country_code,country_name) VALUES  ('HM','Heard Island and McDonald Islands');
INSERT     INTO country (country_code,country_name) VALUES  ('HN','Honduras');
INSERT     INTO country (country_code,country_name) VALUES  ('HR','Croatia');
INSERT     INTO country (country_code,country_name) VALUES  ('HT','Haiti');
INSERT     INTO country (country_code,country_name) VALUES  ('HU','Hungary');
INSERT     INTO country (country_code,country_name) VALUES  ('ID','Indonesia');
INSERT     INTO country (country_code,country_name) VALUES  ('IE','Ireland');
INSERT     INTO country (country_code,country_name) VALUES  ('IL','Israel');
INSERT     INTO country (country_code,country_name) VALUES  ('IM','Isle of Man');
INSERT     INTO country (country_code,country_name) VALUES  ('IN','India');
INSERT     INTO country (country_code,country_name) VALUES  ('IO','British Indian Ocean Territory');
INSERT     INTO country (country_code,country_name) VALUES  ('IQ','Iraq');
INSERT     INTO country (country_code,country_name) VALUES  ('IR','Iran, Islamic Republic of');
INSERT     INTO country (country_code,country_name) VALUES  ('IS','Iceland');
INSERT     INTO country (country_code,country_name) VALUES  ('IT','Italy');
INSERT     INTO country (country_code,country_name) VALUES  ('JE','Jersey');
INSERT     INTO country (country_code,country_name) VALUES  ('JM','Jamaica');
INSERT     INTO country (country_code,country_name) VALUES  ('JO','Jordan');
INSERT     INTO country (country_code,country_name) VALUES  ('JP','Japan');
INSERT     INTO country (country_code,country_name) VALUES  ('KE','Kenya');
INSERT     INTO country (country_code,country_name) VALUES  ('KG','Kyrgyzstan');
INSERT     INTO country (country_code,country_name) VALUES  ('KH','Cambodia');
INSERT     INTO country (country_code,country_name) VALUES  ('KI','Kiribati');
INSERT     INTO country (country_code,country_name) VALUES  ('KM','Comoros');
INSERT     INTO country (country_code,country_name) VALUES  ('KN','Saint Kitts and Nevis');
INSERT     INTO country (country_code,country_name) VALUES  ('KP','Korea, Democratic People''s Republic of');
INSERT     INTO country (country_code,country_name) VALUES  ('KR','Korea, Republic of');
INSERT     INTO country (country_code,country_name) VALUES  ('KW','Kuwait');
INSERT     INTO country (country_code,country_name) VALUES  ('KY','Cayman Islands');
INSERT     INTO country (country_code,country_name) VALUES  ('KZ','Kazakstan');
INSERT     INTO country (country_code,country_name) VALUES  ('LA','Lao People''s Democratic Republic');
INSERT     INTO country (country_code,country_name) VALUES  ('LB','Lebanon');
INSERT     INTO country (country_code,country_name) VALUES  ('LC','Saint Lucia');
INSERT     INTO country (country_code,country_name) VALUES  ('LI','Liechtenstein');
INSERT     INTO country (country_code,country_name) VALUES  ('LK','Sri Lanka');
INSERT     INTO country (country_code,country_name) VALUES  ('LR','Liberia');
INSERT     INTO country (country_code,country_name) VALUES  ('LS','Lesotho');
INSERT     INTO country (country_code,country_name) VALUES  ('LT','Lithuania');
INSERT     INTO country (country_code,country_name) VALUES  ('LU','Luxembourg');
INSERT     INTO country (country_code,country_name) VALUES  ('LV','Latvia');
INSERT     INTO country (country_code,country_name) VALUES  ('LY','Libyan Arab Jamahiriya');
INSERT     INTO country (country_code,country_name) VALUES  ('MA','Morocco');
INSERT     INTO country (country_code,country_name) VALUES  ('MC','Monaco');
INSERT     INTO country (country_code,country_name) VALUES  ('MD','Moldova, Republic of');
INSERT     INTO country (country_code,country_name) VALUES  ('ME','Montenegro');
INSERT     INTO country (country_code,country_name) VALUES  ('MG','Madagascar');
INSERT     INTO country (country_code,country_name) VALUES  ('MH','Marshall Islands');
INSERT     INTO country (country_code,country_name) VALUES  ('MK','Macedonia');
INSERT     INTO country (country_code,country_name) VALUES  ('ML','Mali');
INSERT     INTO country (country_code,country_name) VALUES  ('MM','Myanmar');
INSERT     INTO country (country_code,country_name) VALUES  ('MN','Mongolia');
INSERT     INTO country (country_code,country_name) VALUES  ('MO','Macau');
INSERT     INTO country (country_code,country_name) VALUES  ('MP','Northern Mariana Islands');
INSERT     INTO country (country_code,country_name) VALUES  ('MQ','Martinique');
INSERT     INTO country (country_code,country_name) VALUES  ('MR','Mauritania');
INSERT     INTO country (country_code,country_name) VALUES  ('MS','Montserrat');
INSERT     INTO country (country_code,country_name) VALUES  ('MT','Malta');
INSERT     INTO country (country_code,country_name) VALUES  ('MU','Mauritius');
INSERT     INTO country (country_code,country_name) VALUES  ('MV','Maldives');
INSERT     INTO country (country_code,country_name) VALUES  ('MW','Malawi');
INSERT     INTO country (country_code,country_name) VALUES  ('MX','Mexico');
INSERT     INTO country (country_code,country_name) VALUES  ('MY','Malaysia');
INSERT     INTO country (country_code,country_name) VALUES  ('MZ','Mozambique');
INSERT     INTO country (country_code,country_name) VALUES  ('NA','Namibia');
INSERT     INTO country (country_code,country_name) VALUES  ('NC','New Caledonia');
INSERT     INTO country (country_code,country_name) VALUES  ('NE','Niger');
INSERT     INTO country (country_code,country_name) VALUES  ('NF','Norfolk Island');
INSERT     INTO country (country_code,country_name) VALUES  ('NG','Nigeria');
INSERT     INTO country (country_code,country_name) VALUES  ('NI','Nicaragua');
INSERT     INTO country (country_code,country_name) VALUES  ('NL','Netherlands');
INSERT     INTO country (country_code,country_name) VALUES  ('NO','Norway');
INSERT     INTO country (country_code,country_name) VALUES  ('NP','Nepal');
INSERT     INTO country (country_code,country_name) VALUES  ('NR','Nauru');
INSERT     INTO country (country_code,country_name) VALUES  ('NU','Niue');
INSERT     INTO country (country_code,country_name) VALUES  ('NZ','New Zealand');
INSERT     INTO country (country_code,country_name) VALUES  ('OM','Oman');
INSERT     INTO country (country_code,country_name) VALUES  ('PA','Panama');
INSERT     INTO country (country_code,country_name) VALUES  ('PE','Peru');
INSERT     INTO country (country_code,country_name) VALUES  ('PF','French Polynesia');
INSERT     INTO country (country_code,country_name) VALUES  ('PG','Papua New Guinea');
INSERT     INTO country (country_code,country_name) VALUES  ('PH','Philippines');
INSERT     INTO country (country_code,country_name) VALUES  ('PK','Pakistan');
INSERT     INTO country (country_code,country_name) VALUES  ('PL','Poland');
INSERT     INTO country (country_code,country_name) VALUES  ('PM','Saint Pierre and Miquelon');
INSERT     INTO country (country_code,country_name) VALUES  ('PR','Puerto Rico');
INSERT     INTO country (country_code,country_name) VALUES  ('PS','Palestinian Territory, Occupied');
INSERT     INTO country (country_code,country_name) VALUES  ('PT','Portugal');
INSERT     INTO country (country_code,country_name) VALUES  ('PW','Palau');
INSERT     INTO country (country_code,country_name) VALUES  ('PY','Paraguay');
INSERT     INTO country (country_code,country_name) VALUES  ('QA','Qatar');
INSERT     INTO country (country_code,country_name) VALUES  ('RE','Reunion');
INSERT     INTO country (country_code,country_name) VALUES  ('RO','Romania');
INSERT     INTO country (country_code,country_name) VALUES  ('RS','Serbia');
INSERT     INTO country (country_code,country_name) VALUES  ('RU','Russian Federation');
INSERT     INTO country (country_code,country_name) VALUES  ('RW','Rwanda');
INSERT     INTO country (country_code,country_name) VALUES  ('SA','Saudi Arabia');
INSERT     INTO country (country_code,country_name) VALUES  ('SB','Solomon Islands');
INSERT     INTO country (country_code,country_name) VALUES  ('SC','Seychelles');
INSERT     INTO country (country_code,country_name) VALUES  ('SD','Sudan');
INSERT     INTO country (country_code,country_name) VALUES  ('SE','Sweden');
INSERT     INTO country (country_code,country_name) VALUES  ('SG','Singapore');
INSERT     INTO country (country_code,country_name) VALUES  ('SI','Slovenia');
INSERT     INTO country (country_code,country_name) VALUES  ('SK','Slovakia');
INSERT     INTO country (country_code,country_name) VALUES  ('SL','Sierra Leone');
INSERT     INTO country (country_code,country_name) VALUES  ('SM','San Marino');
INSERT     INTO country (country_code,country_name) VALUES  ('SN','Senegal');
INSERT     INTO country (country_code,country_name) VALUES  ('SO','Somalia');
INSERT     INTO country (country_code,country_name) VALUES  ('SR','Suriname');
INSERT     INTO country (country_code,country_name) VALUES  ('ST','Sao Tome and Principe');
INSERT     INTO country (country_code,country_name) VALUES  ('SV','El Salvador');
INSERT     INTO country (country_code,country_name) VALUES  ('SY','Syrian Arab Republic');
INSERT     INTO country (country_code,country_name) VALUES  ('SZ','Swaziland');
INSERT     INTO country (country_code,country_name) VALUES  ('TC','Turks and Caicos Islands');
INSERT     INTO country (country_code,country_name) VALUES  ('TD','Chad');
INSERT     INTO country (country_code,country_name) VALUES  ('TG','Togo');
INSERT     INTO country (country_code,country_name) VALUES  ('TH','Thailand');
INSERT     INTO country (country_code,country_name) VALUES  ('TJ','Tajikistan');
INSERT     INTO country (country_code,country_name) VALUES  ('TK','Tokelau');
INSERT     INTO country (country_code,country_name) VALUES  ('TM','Turkmenistan');
INSERT     INTO country (country_code,country_name) VALUES  ('TN','Tunisia');
INSERT     INTO country (country_code,country_name) VALUES  ('TO','Tonga');
INSERT     INTO country (country_code,country_name) VALUES  ('TR','Turkey');
INSERT     INTO country (country_code,country_name) VALUES  ('TT','Trinidad and Tobago');
INSERT     INTO country (country_code,country_name) VALUES  ('TV','Tuvalu');
INSERT     INTO country (country_code,country_name) VALUES  ('TW','Taiwan');
INSERT     INTO country (country_code,country_name) VALUES  ('TZ','Tanzania, United Republic of');
INSERT     INTO country (country_code,country_name) VALUES  ('UA','Ukraine');
INSERT     INTO country (country_code,country_name) VALUES  ('UG','Uganda');
INSERT     INTO country (country_code,country_name) VALUES  ('UM','United States Minor Outlying Islands');
INSERT     INTO country (country_code,country_name) VALUES  ('US','United States');
INSERT     INTO country (country_code,country_name) VALUES  ('UY','Uruguay');
INSERT     INTO country (country_code,country_name) VALUES  ('UZ','Uzbekistan');
INSERT     INTO country (country_code,country_name) VALUES  ('VA','Holy See (Vatican City State)');
INSERT     INTO country (country_code,country_name) VALUES  ('VC','Saint Vincent and the Grenadines');
INSERT     INTO country (country_code,country_name) VALUES  ('VE','Venezuela');
INSERT     INTO country (country_code,country_name) VALUES  ('VG','Virgin Islands, British');
INSERT     INTO country (country_code,country_name) VALUES  ('VI','Virgin Islands, U.S.');
INSERT     INTO country (country_code,country_name) VALUES  ('VN','Vietnam');
INSERT     INTO country (country_code,country_name) VALUES  ('VU','Vanuatu');
INSERT     INTO country (country_code,country_name) VALUES  ('WF','Wallis and Futuna');
INSERT     INTO country (country_code,country_name) VALUES  ('WS','Samoa');
INSERT     INTO country (country_code,country_name) VALUES  ('YE','Yemen');
INSERT     INTO country (country_code,country_name) VALUES  ('YT','Mayotte');
INSERT     INTO country (country_code,country_name) VALUES  ('ZA','South Africa');
INSERT     INTO country (country_code,country_name) VALUES  ('ZM','Zambia');
INSERT     INTO country (country_code,country_name) VALUES  ('ZW','Zimbabwe');



--South African Porvinces
INSERT     INTO province (country_code,province_name,province_code) VALUES  ( 'ZA','Eastern Cape','EC');
INSERT     INTO province (country_code,province_name,province_code) VALUES  ( 'ZA','Free State','FS');
INSERT     INTO province (country_code,province_name,province_code) VALUES  ( 'ZA','KwaZulu Natal','KZN');
INSERT     INTO province (country_code,province_name,province_code) VALUES  ( 'ZA','Mpumalanga','MP');
INSERT     INTO province (country_code,province_name,province_code) VALUES  ( 'ZA','North West','NW');
INSERT     INTO province (country_code,province_name,province_code) VALUES  ( 'ZA','Northern Cape','NC');
INSERT     INTO province (country_code,province_name,province_code) VALUES  ( 'ZA','Limpopo','LP');
INSERT     INTO province (country_code,province_name,province_code) VALUES  ( 'ZA','Western Cape','WC');
INSERT     INTO province (country_code,province_name,province_code) VALUES  ( 'ZA','Gauteng','GP');


--South African Cities (Eastern Cape)
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Adelaide');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Alice');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Balfour');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Berlin');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Bhisho, (Bisho)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Braunschweig');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Cathcart');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Dohne');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Dordrecht');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','East London(eMonti)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Elliot');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Fort Beaufort');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Gonubie');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Haga-Haga');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Hamburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Hertzog');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Hogsback');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Humansdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Jeffreys Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Katberg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Kei Mouth');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Keiskammahoek');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Kidds Beach');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','King William''s Town');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Komga');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Mdantsane');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Morgan''s Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Ngcobo');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Oyster Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Peddie');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Seymour');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','St Francis Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Stutterheim');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Tarkastad');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Aberdeen');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Addo');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Alexandria');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Bathurst');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Bedford');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Cookhouse');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Cradock');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Graaff Reinet');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Grahamstown');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Hankey');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Humansdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Jeffreys Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Joubertina');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Kareedouw');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Kenton-on-Sea');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Kirkwood');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Krakeelrivier');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Middelburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Nieu-Bethesda');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Patensie');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Port Alfred');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Port Elizabeth (Ebhayi)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Salem');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Somerset East');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','St Francis Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Steytlerville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Sunland');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Uitenhage');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Willowmore');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Chintsa');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Coffee Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Flagstaff');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Gcuwa (Butterworth)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Idutywa');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Kentani');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Lady Frere(cacadu)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Libode');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Lusikisiki');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Mount Fletcher');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Mount Frere');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Mthatha (Umtata)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Port St Johns');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Qolora Mouth');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Willowvale');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Tsolo');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'EC','Bizana');



--South African Cities (KwaZulu-Natal)
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Charlestown');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Dannhauser');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Hattingspruit');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Madadeni');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Newcastle');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Utrecht');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Amanzimtoti');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Catoridge');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Doonside');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Drummond');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Durban');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','ekuPhakameni');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Hillcrest');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Illovo Beach');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Inanda');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Isipingo Beach');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Karridene');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Kingsburgh');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Kloof');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','KwaMashu');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','La Lucia');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','La Mercy');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Mount Edgecombe');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','New Germany');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Pinetown');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Queensburgh');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Tongaat');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Umbogintwini');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Umdloti');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Umgababa');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Umhlanga Rocks');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Verulam');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Warner Beach');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Westville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Winkelspruit');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Ballito');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','KwaDukuza (Stanger)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Salt Rock');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Bulwer');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Cedarville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Franklin');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Himeville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Ixopo');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Kokstad');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Matatiele');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Swartberg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Umzimkulu');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Underberg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Harding');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Hibberdene');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Ifafa Beach');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Margate');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Palm Beach');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Park Rynie');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Pennington');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Port Edward');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Port Shepstone');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Ramsgate');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Scottburgh');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Sezela');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Shelly Beach');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Southbroom');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','St Michael''s-on-Sea');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Umkomaas');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Umtentweni');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Umzinto');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Umzumbe');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Uvongo');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Widenham');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Balgowan');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Boston');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Byrne');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Dargle');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Hilton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Howick');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Impendile');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Merrivale');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Mooiriver');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','New Hanover');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Nottingham Road');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Pietermaritzburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Richmond');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Wartburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','York');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Hluhluwe');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Ingwavuma');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Mkuze');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Mtubatuba');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','St Lucia');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Ubombo');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Dundee');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Glencoe');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Greytown');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Kranskop');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Muden');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Pomeroy');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Wasbank');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Bergville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Colenso');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Elandslaagte');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Estcourt');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Ladysmith');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Weenen');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Winterton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Babanango');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Empangeni');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Eshowe');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Mandini');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Melmoth');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Mtunzini');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Richards Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Louwsburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Mahlabatini');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Nongoma');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Paulpietersburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Pongola');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Ulundi');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'KZN','Vryheid');



--South African Cities (Mpumalanga)
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Belfast');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Dullstroom');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Graskop');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Lydenburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Machadodorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Ohrigstad');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Pilgrim''s Rest');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Sabie');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Waterval Boven');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Waterval Onder');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Amersfoort');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Amsterdam');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Badplaas');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Breyten');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Carolina');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Chrissiesmeer');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Ermelo');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Morgenzon');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Perdekop');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Piet Retief');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Volksrust');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Wakkerstroom');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Balfour');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Bethal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Delmas');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Greylingstad');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Groblersdal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Kinross');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','KwaMhlanga');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Loopspruit');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Marble Hall');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Middelburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Secunda');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Siyabuswa');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Standerton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Trichardt');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Vaalbank');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Witbank');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Barberton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Hazyview');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Hectorspruit');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Kaapmuiden');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Komatipoort');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Malelane');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Nelspruit');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Skukuza');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','White River');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'MP','Bushbuckridge');



--South African Cities (North West)
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Amalia');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Bray');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Ganyesa');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Mareetsane');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Mothibastad');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Pampierstad');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Reivilo');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Schweizer-Reneke');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Setlagole');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Stella');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Taung');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Tosca');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Vryburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Babelegi');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Beestekraal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Brits');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Broederstroom');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Derby');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Ga-Rankuwa');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Hartbeespoort');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Hekpoort');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Jericho');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Koster');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Kroondal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Maanhaarrand');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Mabopane');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Magaliesburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Marikana');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Mogwase');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Mooinooi');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Ramokoka');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Rustenburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Skeerpoort');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Swartruggens');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Tlhabane');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Lethabong( Haartebeesfontien )');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Coligny');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Delareyville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Ganyesa');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Groot Marico');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Lehurutshe');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Lichtenburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Mareetsane');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Mafikeng');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Mmabatho');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Ottosdal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Ottoshoop');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Sannieshof');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Zeerust');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Bloemhof');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Christiana');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Fochville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Hartbeesfontein');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Klerksdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Leeudoringstad');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Makwassie');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Orkney');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Potchefstroom');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Stilfontein');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Ventersdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NW','Wolmaransstad');



--South African Cities (Free State)
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Arlington' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Bethlehem' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Clarens' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Clocolan' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Cornelia' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Excelsior' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Ficksburg' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Fouriesburg' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Harrismith' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Hobhouse' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Kestell' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Ladybrand' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Lindley' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Marquard' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Memel' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Paul Roux' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Petrus Steyn' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Phuthaditjhaba' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Reitz' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Rosendal' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Senekal' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Steynsrus' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Swinburne' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Tweespruit' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Van Reenen' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Vrede' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Warden' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Winburg' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Allanridge' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Boshof' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Bothaville' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Brandfort' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Bultfontein' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Dealesville' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Hennenman' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Hertzogville' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Hoopstad' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Kgotsong' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Makeleketla' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Odendaalsrus' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Theunissen' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Ventersburg' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Verkeerdevlei' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Virginia' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Welkom' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Wesselsbron' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Deneysville' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Edenville' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Frankfort' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Heilbron' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Koppies' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Kroonstad' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Oranjeville' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Parys' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Sasolburg' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Tweeling' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Viljoenskroon' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Villiers' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Vredefort' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Bethulie' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Bloemfontein' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Botshabelo' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Dewetsdorp' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Edenburg' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Fauresmith' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Itumeleng' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Jacobsdal' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Jagersfontein' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Koffiefontein' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Luckhoff' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Mangaung' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Petrusburg' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Philippolis' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Reddersburg' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Rouxville' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Smithfield' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Springfontein' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Thaba Nchu' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Trompsburg' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Van Stadensrus' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Wepener' );
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'FS','Zastron' );



--South African Cities (Northern Cape)
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Barkly West');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Campbell');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Delportshoop');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Douglas');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Griquatown');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Hartswater');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Jan Kempdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Kimberley');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Modder River');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Warrenton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Windsorton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Andriesvale');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Askham');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Groblershoop');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Kakamas');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Kanoneiland');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Keimoes');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Kenhardt');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Onseepkans');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Pofadder');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Upington');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Brandvlei');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Calvinia');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Carnarvon');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Fraserburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Loeriesfontein');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Nieuwoudtville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Sutherland');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Van Wyksvlei');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Williston');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Beeshoek');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Danielskuil');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Dibeng');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Hotazel');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Kathu');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Kuruman');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Olifantshoek');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Postmasburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Van Zylsrus');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Aggeneys');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Alexander Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Carolusberg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Concordia');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Garies');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Hondeklip');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Kamieskroon');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Kleinzee');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Nababeep');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Okiep');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Pella');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Port Nolloth');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Soebatsfontein');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Springbok');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Steinkopf');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Britstown');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Colesburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Copperton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','De Aar');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Hanover');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Hopetown');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Hutchinson');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Loxton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Marydale');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Norvalspont');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Noupoort');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Orania');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Petrusville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Philipstown');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Prieska');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Richmond');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Strydenburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Three Sisters');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Vanderkloof');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Victoria West');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'NC','Vosburg');



--South African Cities (Limpopo)
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Bela Bela (Warmbaths)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Lephalale (Ellisras)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Modimolle (Nylstroom)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Naboomspruit(Mookgopong)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Thabazimbi');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Vaalwater (Mabatlane)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Haenertsburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Mokopane (Potgietersrus)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Polokwane (Pietersburg)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Alldays');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Bandelierkop');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Louis Trichardt (Makhado)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Musina (Messina)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Thohoyandou');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Vivo');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Bosbokrand');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Duiwelskloof (Modjadjiskloof)');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Gravelotte');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Hoedspruit');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Klaserie');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Letsitele');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Leydsdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Ofcolaco');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Phalaborwa');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'LP','Tzaneen');




--South African Cities (Western Cape)
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Franschhoek');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Paarl');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Stellenbosch');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Brandwacht');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Cloetesville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Dalsig');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Die Boord');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Idas Valley');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Karendal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Kayamandi');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','La Coline');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Mostertsdrift');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Simonsig');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Universiteitsoord');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Voeltjiesdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Koelenhof');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Vlottenburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Lynedoch');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Wellington');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Aurora');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Bitterfontein');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Citrusdal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Clanwilliam');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Darling');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Doringbaai');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Eendekuil');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Elandsbaai');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Graafwater');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Hopefield');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Klawer');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Lamberts Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Langebaan');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Leipoldtville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Malmesbury');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Moorreesburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Nuwerus');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Papendorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Paternoster');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Piketberg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Porterville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Redelinghuys');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Riebeek-Kasteel');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Riebeek West');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Rietpoort');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Saldanha Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','St Helena Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Strandfontein');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Trawal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Vanrhynsdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Velddrif');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Vredenburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Vredendal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Wupperthal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Yzerfontein');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Arniston');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Baardskeerdersbos');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Barrydale');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Betty''s Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Bot River');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Bredasdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Buffelsjagbaai');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Caledon');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','De Kelders');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Elgin');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Elim');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Franskraal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Gansbaai');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Genadendal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Grabouw');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Greyton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Hangklip');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Hermanus');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Kleinbaai');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Kleinmond');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','L''Agulhas');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Malgas');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Napier');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Pearly Beach');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Pringle Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Riviersonderend');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Rooiels');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Stanford');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Struisbaai');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Suurbraak');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Swellendam');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Villiersdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Waenhuiskrans');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Witsand');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Ashton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Bonnievale');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Ceres');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','De Doorns');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Gouda');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','McGregor');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Montagu');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Prince Alfred''s Hamlet');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Rawsonville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Robertson');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Saron');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','De Rust');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Touwsrivier');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Tulbagh');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Wolseley');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Worcester');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Amalienstein');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Calitzdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','De Rust');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Dysselsdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Haarlem');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Ladismith');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Oudtshoorn');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Uniondale');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Vanwyksdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Zoar');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Beaufort West');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Klaarstroom');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Laingsburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Leeu-Gamka');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Matjiesfontein');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Merweville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Murraysburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Nelspoort');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Prince Albert');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Albertinia');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','George');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Great Brak River');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Hartenbos');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Heidelberg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Knysna');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Little Brak River');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Mossel Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Nature''s Valley');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Plettenberg Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Riversdale');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Sedgefield');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Stilbaai');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Victoria Bay');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Wilderness');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'WC','Witsand');


--South African Cities (Gauteng)
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Alexandra');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Johannesburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Lenasia');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Midrand');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Randburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Roodepoort');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Sandton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Soweto');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Alberton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Benoni');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Boksburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Brakpan');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Daveyton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Devon');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Duduza');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Edenvale');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Germiston');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Impumelelo');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Isando');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Katlehong');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Kempton Park');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','KwaThema');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Nigel');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Reiger Park');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Springs');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Tembisa');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Thokoza');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Tsakane');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Vosloorus');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Wattville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Atteridgeville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Centurion');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Irene');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Mamelodi');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Pretoria');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Soshanguve');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Boipatong');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Bophelong');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Evaton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Sebokeng');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Sharpeville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Vanderbijlpark');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Vereeniging');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Meyerton');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Heidelberg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Ratanda');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Bronkhorstspruit');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Ekangala');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Bronberg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Bronkhorstspruit');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Cullinan');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Hammanskraal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Refilwe');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Zithobeni');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Carletonville');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Khutsong');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Kagiso');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Kromdraai');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Krugersdorp');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Magaliesburg');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Muldersdrift');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Mohlakeng');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Randfontein');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Bekkersdal');
INSERT     INTO city ( province_code,city_name ) VALUES  ( 'GP','Westonaria');

