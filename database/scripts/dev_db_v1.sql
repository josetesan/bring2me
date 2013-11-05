

-- create DB



--CREATE DATABASE devDB

--  WITH OWNER = devdb

--       ENCODING = 'UTF8'

--       TABLESPACE = pg_default

--       LC_COLLATE = 'C'

--       LC_CTYPE = 'C'

--       CONNECTION LIMIT = -1;



--COMMENT ON DATABASE devDB

--  IS 'default administrative connection database';





-- create db schema . For the time being, there is only one schema

--drop schema dev cascade; commit



CREATE SCHEMA dev;

commit;







GRANT ALL ON SCHEMA dev TO public;

COMMENT ON SCHEMA dev

  IS 'standard development schema';





------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- create sequence, only for users

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



CREATE SEQUENCE dev.sql_id_user

   INCREMENT 1

   START 1

   MINVALUE 1

   MAXVALUE 99999999999999; 

   

commit;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- triggers for the following tables only: tb_user_access_control  , tb_user and tb_rating 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





  

  

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- YELLOW (see db_schema document) -----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





-- create tables -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- no foreign keys created, code handles that



CREATE TABLE dev.tb_user_access_control (

uac_id INT PRIMARY KEY   NOT NULL,

uac_created timestamp  , 

uac_user_id INT not null, 

uac_user_pwd varchar(100)  not null, 

uac_attribute01 varchar(10), 

uac_attribute02 varchar(10),

uac_atrribute03 varchar(10) 

);





CREATE OR REPLACE FUNCTION dev.prd_tg_user_access_control() RETURNS TRIGGER AS 

 $BODY$

    BEGIN

	New.uac_id = nextval('sql_id_user');

	New.uac_created = now();

        RETURN NEW;

    END

	 $BODY$

 LANGUAGE 'plpgsql';



CREATE TRIGGER tg_tb_user_access_control 

    BEFORE insert ON dev.tb_user_access_control 

    FOR EACH ROW

   EXECUTE PROCEDURE dev.prd_tg_user_access_control();

  

  



create table dev.tb_user(

u_id INT PRIMARY KEY   NOT NULL,

u_created timestamp  ,

u_email varchar(300) not null UNIQUE,

u_nickname varchar(100) not null UNIQUE,

u_country_id int not null, 

u_attribute01  varchar(10), 

u_attribute02 varchar(10), 

u_attribute03 varchar(10), 

u_attribute04 varchar(10) 

);





CREATE OR REPLACE FUNCTION dev.prd_tb_user() RETURNS TRIGGER AS 

$BODY$

    BEGIN

	New.u_id = nextval('sql_id_user');

	New.u_created = now();

		RETURN NEW;

    END

	$BODY$

LANGUAGE 'plpgsql';



CREATE TRIGGER tg_tb_user 

    BEFORE insert ON dev.tb_user 

    FOR EACH ROW

   EXECUTE PROCEDURE dev.prd_tb_user();

  

  



create table dev.tb_rating

(

r_id INT PRIMARY KEY   NOT NULL,

r_created timestamp  , 

r_given_by_user_id  INT not null, 

r_given_to_user_id int not null, 

r_rating_given int not null, 

r_attribute01   varchar(10), 

r_attribute02   varchar(10), 

r_atrribure03   varchar(10)





);





CREATE OR REPLACE FUNCTION dev.prd_tb_rating() RETURNS TRIGGER AS 

 $BODY$

    BEGIN

	New.r_id = nextval('sql_id_user');

	New.r_created = now();

		RETURN NEW;

    END

	$BODY$

 LANGUAGE 'plpgsql';



CREATE TRIGGER tg_tb_rating 

    BEFORE insert ON dev.tb_rating 

    FOR EACH ROW

   EXECUTE PROCEDURE dev.prd_tb_rating();

  

  





-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ORANGE (see db_schema document) -----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





CREATE SEQUENCE dev.sql_id_activity

   INCREMENT 1

   START 1

   MINVALUE 1

   MAXVALUE 99999999999999;



   commit;

-- tb_request_master

--------------------------------------------------------------------------------------------   





create table dev.tb_request_master (

rm_id INT PRIMARY KEY   NOT NULL,

rm_created timestamp ,

rm_created_by_user_id INT not null,

rm_service_type_id INT not null,

rm_from_iso_country_id INT not null,

rm_to_iso_country_id INT not null,

rm_from_location varchar(300),

rm_to_location varchar(300),

rm_pick_up_address varchar(300),

rm_deliver_address varchar(300),

rm_weight_package int,

rm_description_package varchar(1000),

rm_requester_duration_minutes INT not null,

rm_payment_money decimal not null,

rm_currency_id INT not null,

rm_comments varchar(1000), 

rm_attribute01 varchar(10),

rm_attribute02 varchar(10),

rm_attribute03 varchar(10)

);







CREATE OR REPLACE FUNCTION dev.prd_tg_tb_request_master() RETURNS TRIGGER AS 

$BODY$

    BEGIN

	New.rm_id = nextval('sql_id_activity');

	New.rm_created = now();

		RETURN NEW;

    END

	$BODY$

LANGUAGE 'plpgsql';





CREATE TRIGGER tg_tb_request_master 

    BEFORE insert ON dev.tb_request_master 

    FOR EACH ROW

   EXECUTE PROCEDURE dev.prd_tg_tb_request_master();





-- tb_request_action

--------------------------------------------------------------------------------------------   





create table dev.tb_request_action (

ra_id INT PRIMARY KEY  NOT NULL,

ra_created timestamp ,

ra_request_master_id INT not null,

ra_claim_given_by_user_id INT not null,

ra_attribute01 varchar(10),

ra_attribute02 varchar(10)

);



CREATE OR REPLACE FUNCTION dev.prd_tb_request_action() RETURNS TRIGGER AS $BODY$

    BEGIN

	New.ra_id = nextval('sql_id_activity');

	New.ra_created = now();

		RETURN NEW;

    END

	$BODY$

LANGUAGE 'plpgsql' ;





CREATE TRIGGER tg_tb_request_action 

    BEFORE UPDATE ON dev.tb_request_action 

    FOR EACH ROW

   EXECUTE PROCEDURE dev.prd_tb_request_action();





-- tb_request_to_proceed

--------------------------------------------------------------------------------------------   



create table dev.tb_request_to_proceed

(

rtp_id INT PRIMARY KEY  NOT NULL,

rtp_created timestamp, 

rtp_request_action_id INT ,

rtp_user_to_do_service_id INT,

rtp_payment_current_id INT ,

rtt_payment_type_id INT ,

rtp_payment_service_type_id INT,

rtp_payment_external_id int



);







CREATE OR REPLACE FUNCTION dev.prd_tb_request_to_proceed() RETURNS TRIGGER AS

$BODY$

    BEGIN

	New.rtp_id = nextval('sql_id_activity');

	New.rtp_created = now();

		RETURN NEW;

    END

	$BODY$

 LANGUAGE 'plpgsql' ;





CREATE TRIGGER tg_tb_request_to_proceed 

    BEFORE insert ON dev.tb_request_to_proceed 

    FOR EACH ROW

   EXECUTE PROCEDURE dev.prd_tb_request_to_proceed();







-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SALMON  (see db_schema document) -----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



CREATE SEQUENCE dev.sql_id_administration

   INCREMENT 1

   START 1

   MINVALUE 1

   MAXVALUE 99999999999999;



-- tb_country_iso

--------------------------------------------------------------------------------------------   



create table dev.tb_county_iso

(

ci_id INT PRIMARY KEY  NOT NULL,

ci_created timestamp,

ci_iso_country_reference varchar(300),

ci_iso_country_name varchar(300),

ci_attribute01 varchar(30),

ci_attribute02 varchar(30),

ci_attribute03 varchar(30)

);





CREATE OR REPLACE FUNCTION dev.prd_tb_county_iso() RETURNS TRIGGER AS

 $BODY$

    BEGIN

	New.ci_id = nextval('sql_id_administration');

	New.ci_created = now();

		RETURN NEW;

    END

	$BODY$

LANGUAGE 'plpgsql' ;





CREATE TRIGGER tg_tb_county_iso

    BEFORE insert ON dev.tb_county_iso 

    FOR EACH ROW

   EXECUTE PROCEDURE dev.prd_tb_county_iso();





-- tb_city_country

--------------------------------------------------------------------------------------------   



create table dev.tb_city_country (

cc_id INT PRIMARY KEY  NOT NULL,

cc_created timestamp ,

cc_country_id int, 

cc_city_name varchar(200),

cc_attribute01 varchar(10),

cc_attribute02 varchar(10),

cc_attribute03 varchar(10)

);



CREATE OR REPLACE FUNCTION dev.prd_tb_city_country() RETURNS TRIGGER AS

$BODY$

   BEGIN

	New.cc_id = nextval('sql_id_administration');

	New.cc_created = now();

		RETURN NEW;

    END

	$BODY$

LANGUAGE 'plpgsql' ;





CREATE TRIGGER tg_tb_city_country

    BEFORE insert ON dev.tb_city_country 

    FOR EACH ROW

   EXECUTE PROCEDURE dev.prd_tb_city_country();





-- tb_service_type

--------------------------------------------------------------------------------------------   



create table dev.tb_service_type (

st_id INT PRIMARY KEY  NOT NULL,

st_created  timestamp  ,

st_name varchar(100), 

st_description varchar(1000),

st_picture text,

st_active  varchar(10),

st_service_fee decimal,

st_attribute01 varchar(10),

st_attribute02 varchar(10),

st_attribute03 varchar(10)

);









CREATE OR REPLACE FUNCTION dev.prd_tb_service_type() RETURNS TRIGGER AS 

 $BODY$

    BEGIN

	New.st_id = nextval('sql_id_administration');

	New.st_created = now();

		RETURN NEW;

    END

	$BODY$

LANGUAGE 'plpgsql' ;





CREATE TRIGGER tg_tb_service_type

    BEFORE insert ON dev.tb_service_type 

    FOR EACH ROW

   EXECUTE PROCEDURE dev.prd_tb_service_type();





-- tb_currency

--------------------------------------------------------------------------------------------   



create table dev.tb_currency(

c_id  INT PRIMARY KEY  NOT NULL,

c_created timestamp  ,

c_currency_iso_name varchar(100), 

c_currency_fee decimal, 

c_actvity varchar(10),

c_attribute01  varchar(10),

c_artribute02 varchar(10)

);









CREATE OR REPLACE FUNCTION dev.prd_tb_currency() RETURNS TRIGGER AS 

 $BODY$

    BEGIN

	New.c_id = nextval('sql_id_administration');

	New.c_created = now();

		RETURN NEW;

    END

	$BODY$

LANGUAGE 'plpgsql' ;





CREATE TRIGGER tg_tb_currency

    BEFORE insert ON dev.tb_currency 

    FOR EACH ROW

   EXECUTE PROCEDURE dev.prd_tb_currency();







-- tb_payment_type

--------------------------------------------------------------------------------------------   

create table dev.tb_payment_type (

pt_id   INT PRIMARY KEY  NOT NULL,

pt_created timestamp ,

pt_name varchar(100),

pt_description  varchar(100),

pt_active  varchar(10),

pt_attribute01  varchar(10),

pt_attribute02  varchar(10),

pt_attribute03  varchar(10)

);







CREATE OR REPLACE FUNCTION dev.prd_tb_payment_type() RETURNS TRIGGER AS



 $BODY$

    BEGIN

	New.pt_id = nextval('sql_id_administration');

	New.pt_created = now();

		RETURN NEW;

    END

	$BODY$

	

LANGUAGE 'plpgsql' ;





CREATE TRIGGER tg_tb_payment_type

    BEFORE insert ON dev.tb_payment_type 

    FOR EACH ROW

   EXECUTE PROCEDURE dev.prd_tb_payment_type();



SET dev.TIMEZONE = 'UTC';



commit;



--------------------------------------------------------------------------------------

--- TEST DATA ------------------------------------------------------------------------

--------------------------------------------------------------------------------------



insert into dev.tb_county_iso (ci_iso_country_reference,ci_iso_country_name) values ('SPAIN', 'ES');

insert into dev.tb_county_iso (ci_iso_country_reference,ci_iso_country_name) values ('UNITED STATES', 'US');

insert into dev.tb_county_iso (ci_iso_country_reference,ci_iso_country_name) values ('UNITED KINGDOM', 'GB');

commit;



insert into dev.tb_service_type (st_name, st_description, st_active, st_service_fee)

values

('People to People', 'Goods delivery between people', 1, 0.99);



insert into dev.tb_service_type (st_name, st_description, st_active, st_service_fee)

values

('Car Pooloing', 'Car Pooling', 1, 0.99);

commit;

insert into dev.tb_currency (c_currency_iso_name) values ('EUR');

insert into dev.tb_currency (c_currency_iso_name) values ('GBP');

insert into dev.tb_currency (c_currency_iso_name) values ('USD');

commit;

insert into dev.tb_payment_type (pt_name, pt_description, pt_active) values ('Visa', 'Credit Card Payment', 1);

insert into dev.tb_payment_type (pt_name, pt_description, pt_active) values ('PayPal', 'PayPal Payment', 1);

commit;



￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿￿
