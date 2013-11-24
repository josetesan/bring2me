
create DB

CREATE DATABASE devDB
  WITH OWNER = devdb
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'C'
       LC_CTYPE = 'C'
       CONNECTION LIMIT = -1;

COMMENT ON DATABASE devDB
  IS 'default administrative connection database';


-- create db schema . For the time being, there is only one schema

drop schema dev cascade; 

CREATE SCHEMA dev;



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
   

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- triggers for the following tables only: tb_user_access_control  , tb_user and tb_rating 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


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

create table dev.tb_country_iso
(
country_id INT PRIMARY KEY  NOT NULL,
country_created timestamp,
country_iso_country_short varchar(10),
country_iso_country_name varchar(300),
attribute01 varchar(30),
attribute02 varchar(30),
attribute03 varchar(30)
);


CREATE OR REPLACE FUNCTION dev.prd_tb_county_iso() RETURNS TRIGGER AS
 $BODY$
    BEGIN
	New.country_id = nextval('sql_id_administration');
	New.country_created = now();
		RETURN NEW;
    END
	$BODY$
LANGUAGE 'plpgsql' ;


CREATE TRIGGER tg_tb_country_iso
    BEFORE insert ON dev.tb_country_iso 
    FOR EACH ROW
   EXECUTE PROCEDURE dev.prd_tb_county_iso();

-- tb_service_type
--------------------------------------------------------------------------------------------   

create table dev.tb_service_type (
service_id INT PRIMARY KEY  NOT NULL,
service_created  timestamp  ,
service_name varchar(100), 
service_description varchar(1000),
service_picture text,
service_active  varchar(10),
service_service_fee decimal,
attribute01 varchar(10),
attribute02 varchar(10),
attribute03 varchar(10)
);


CREATE OR REPLACE FUNCTION dev.prd_tb_service_type() RETURNS TRIGGER AS 
 $BODY$
    BEGIN
	New.service_id = nextval('sql_id_administration');
	New.service_created = now();
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
currency_id  INT PRIMARY KEY  NOT NULL,
currency_created timestamp  ,
currency_currency_iso_name varchar(100), 
currency_currency_fee decimal, 
attribute01  varchar(10),
artribute02 varchar(10)
);




CREATE OR REPLACE FUNCTION dev.prd_tb_currency() RETURNS TRIGGER AS 
 $BODY$
    BEGIN
	New.currency_id = nextval('sql_id_administration');
	New.currency_created = now();
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
payment_id   INT PRIMARY KEY  NOT NULL,
payment_created timestamp ,
payment_name varchar(50),
payment_description  varchar(200),
payment_active  varchar(10),
attribute01  varchar(10),
attribute02  varchar(10)
);



CREATE OR REPLACE FUNCTION dev.prd_tb_payment_type() RETURNS TRIGGER AS

 $BODY$
    BEGIN
	New.payment_id = nextval('sql_id_administration');
	New.payment_created = now();
		RETURN NEW;
    END
	$BODY$
	
LANGUAGE 'plpgsql' ;


CREATE TRIGGER tg_tb_payment_type
    BEFORE insert ON dev.tb_payment_type 
    FOR EACH ROW
   EXECUTE PROCEDURE dev.prd_tb_payment_type();


  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- YELLOW (see db_schema document) -----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- create tables -------------------------------------------------------------------------------------------------------------------------------------------------------------------------


create table dev.tb_user(
user_id INT PRIMARY KEY   NOT NULL,
user_created timestamp  ,
user_email varchar(300) not null UNIQUE,
user_nickname varchar(100) not null UNIQUE,
user_country_id int REFERENCES dev.tb_country_iso (country_id),
user_phone_or_mobile varchar(20),
user_twitter_account varchar(150),
attribute01 varchar(10), 
attribute02 varchar(10), 
attribute03 varchar(10) 
);


CREATE OR REPLACE FUNCTION dev.prd_tb_user() RETURNS TRIGGER AS 
$BODY$
    BEGIN
	New.user_id = nextval('sql_id_user');
	New.user_created = now();
		RETURN NEW;
    END
	$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER tg_tb_user 
    BEFORE insert ON dev.tb_user 
    FOR EACH ROW
   EXECUTE PROCEDURE dev.prd_tb_user();


CREATE TABLE dev.tb_user_access_control (
control_id INT PRIMARY KEY   NOT NULL,
control_created timestamp  ,
control_updated timestamp, 
user_id INT not null REFERENCES dev.tb_user(user_id), 
user_pass_control_word varchar(100)  not null,  -- hash and salted http://www.postgresql.org/docs/8.3/static/pgcrypto.html 
attribute01 varchar(10), 
attribute02 varchar(10)
);


CREATE OR REPLACE FUNCTION dev.prd_tg_user_access_control() RETURNS TRIGGER AS 
 $BODY$
    BEGIN
	
	if (TG_OP = 'INSERT') then
	New.control_id = nextval('sql_id_user');
	New.control_created = now();
        RETURN NEW;
	end if;
    
	if (TG_OP = 'UPDATE') then
	New.control_updated = now();
		RETURN NEW;
	end if;
	
	END
	 $BODY$
 LANGUAGE 'plpgsql';

CREATE TRIGGER tg_tb_user_access_control 
    BEFORE insert or update ON dev.tb_user_access_control 
    FOR EACH ROW
   EXECUTE PROCEDURE dev.prd_tg_user_access_control();
  
  

create table dev.tb_rating
(
rating_id INT PRIMARY KEY   NOT NULL,
rating_created timestamp  , 
rating_given_by_user_id  INT not null REFERENCES dev.tb_user( user_id), 
rating_given_to_user_id int  not null REFERENCES dev.tb_user(user_id), 
rating_rating_given int not null, 
attribute01   varchar(10), 
attribute02   varchar(10), 
atrribure03   varchar(10)


);


CREATE OR REPLACE FUNCTION dev.prd_tb_rating() RETURNS TRIGGER AS 
 $BODY$
    BEGIN
	New.rating_id = nextval('sql_id_user');
	New.rating_created = now();
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

-- tb_request_master
--------------------------------------------------------------------------------------------   


create table dev.tb_request_master (
request_id INT PRIMARY KEY   NOT NULL,
request_created timestamp ,
request_updated timestamp,
request_created_by_user_id INT not null REFERENCES dev.tb_user (user_id),
request_service_type_id INT not null REFERENCES dev.tb_service_type (service_id) ,
request_from_iso_country_id INT not null REFERENCES dev.tb_country_iso (country_id),
request_to_iso_country_id INT not null REFERENCES dev.tb_country_iso (country_id),
request_from_city_location varchar(100),
request_from_post_code varchar(20),
request_to_city_location varchar(100),
request_pick_up_address varchar(300),
request_pick_up_address_url varchar(500),
request_pick_up_time varchar(100),
request_to_post_code varchar(10),
request_deliver_address varchar(300),
request_deliver_address_url varchar(500),
request_weight_package varchar(100),
request_description_package varchar(1000),
request_duration_minutes INT not null,
request_payment_money decimal not null,
request_currency_id INT not null REFERENCES dev.tb_currency (currency_id),
request_comments varchar(1000), 
attribute01 varchar(10),
attribute02 varchar(10),
attribute03 varchar(10)
);


CREATE OR REPLACE FUNCTION dev.prd_tg_tb_request_master() RETURNS TRIGGER AS 
$BODY$
    BEGIN
	
	if (TG_OP = 'INSERT') THEN
	
	New.request_id = nextval('sql_id_activity');
	New.request_created = now();
		RETURN NEW;
	end if;
	
	if (TG_OP = 'UPDATE') THEN
	
	New.request_updated = now();
		RETURN NEW;
	end if;
	
    END
	$BODY$
LANGUAGE 'plpgsql';


CREATE TRIGGER tg_tb_request_master 
    BEFORE insert or UPDATE ON dev.tb_request_master 
    FOR EACH ROW
   EXECUTE PROCEDURE dev.prd_tg_tb_request_master();


-- tb_request_action
--------------------------------------------------------------------------------------------   


create table dev.tb_request_action (
action_id INT PRIMARY KEY  NOT NULL,
action_created timestamp ,
action_request_master_id INT not null REFERENCES dev.tb_request_master(request_id),
action_claim_given_by_user_id INT not null REFERENCES dev.tb_user(user_id),
attribute01 varchar(10),
attribute02 varchar(10)
);

CREATE OR REPLACE FUNCTION dev.prd_tb_request_action() RETURNS TRIGGER AS $BODY$
    BEGIN
	New.action_id = nextval('sql_id_activity');
	New.action_created = now();
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
proceed_id INT PRIMARY KEY  NOT NULL,
proceed_created timestamp, 
proceed_request_action_id INT REFERENCES dev.tb_request_action (action_id),
proceed_user_to_do_service_id INT REFERENCES  dev.tb_request_master(request_id), 
proceed_payment_currency_id INT REFERENCES dev.tb_currency (currency_id),
proceed_payment_type_id INT REFERENCES dev.tb_payment_type (payment_id),
proceed_payment_external_id int, -- id from the bank or from paypal or any other source
attribute01 varchar(10),
attribute02 varchar(10),
attribute03 varchar(10)

);



CREATE OR REPLACE FUNCTION dev.prd_tb_request_to_proceed() RETURNS TRIGGER AS
$BODY$
    BEGIN
	New.proceed_id = nextval('sql_id_activity');
	New.proceed_created = now();
		RETURN NEW;
    END
	$BODY$
 LANGUAGE 'plpgsql' ;


CREATE TRIGGER tg_tb_request_to_proceed 
    BEFORE insert ON dev.tb_request_to_proceed 
    FOR EACH ROW
   EXECUTE PROCEDURE dev.prd_tb_request_to_proceed();




SET dev.TIMEZONE = 'UTC';


--------------------------------------------------------------------------------------
--- identify when user logs into the site --------------------------------------------
--------------------------------------------------------------------------------------
CREATE SEQUENCE dev.sql_id_conn
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999; 
   
create table dev.tb_user_conn
(
connection_id INT PRIMARY KEY  NOT NULL,
connection_created timestamp,
connection_user_id int REFERENCES dev.tb_user (user_id),
attribute01 varchar(30),
attribute02 varchar(30),
attribute03 varchar(30)
);


CREATE OR REPLACE FUNCTION dev.prd_tb_user_conn() RETURNS TRIGGER AS
 $BODY$
    BEGIN
	New.connection_id = nextval('sql_id_conn');
	New.connection_created = now();
		RETURN NEW;
    END
	$BODY$
LANGUAGE 'plpgsql' ;


CREATE TRIGGER tg_tb_user_conn
    BEFORE insert ON dev.tb_user_conn 
    FOR EACH ROW
   EXECUTE PROCEDURE dev.prd_tb_user_conn();

