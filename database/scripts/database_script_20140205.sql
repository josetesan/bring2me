GRANT ALL ON SCHEMA public TO ikuunuser;
COMMENT ON SCHEMA public
  IS 'dev db schema';

  
--------------------------------------------------------------------------------------------  
-- tb_language
--------------------------------------------------------------------------------------------  
CREATE SEQUENCE public.sq_language
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999; 

create table public.tb_language(
lg_id INT PRIMARY KEY   NOT NULL,
lg_created timestamp  ,
lg_name varchar(300) not null UNIQUE,
lg_reference_db_language_id int not null UNIQUE, 
attribute01 varchar(10), 
attribute02 varchar(10), 
attribute03 varchar(10) 
);


CREATE OR REPLACE FUNCTION public.prd_tb_language() RETURNS TRIGGER AS 
$BODY$
    BEGIN
	New.lg_id = nextval('sq_language');
	New.lg_created = now();
		RETURN NEW;
    END
	$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER tg_tb_user 
    BEFORE insert ON public.tb_language
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tb_language();


--------------------------------------------------------------------------------------------  
-- tb_country_iso
--------------------------------------------------------------------------------------------   


CREATE SEQUENCE public.sq_country_iso
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999; 

create table public.tb_country_iso
(
country_id INT PRIMARY KEY  NOT NULL,
country_created timestamp,
country_iso_country_short varchar(10) not null ,
country_iso_country_name varchar(64) not null UNIQUE,
country_iso_db_language int REFERENCES public.tb_language (lg_reference_db_language_id),
country_phone_code varchar(50),
country_payment_fee_currency varchar(20) not null,
attribute01 varchar(30),
attribute02 varchar(30),
attribute03 varchar(30)
);


CREATE OR REPLACE FUNCTION public.prd_tb_county_iso() RETURNS TRIGGER AS
 $BODY$
    BEGIN
	New.country_id = nextval('sq_country_iso');
	New.country_created = now();
		RETURN NEW;
    END
	$BODY$
LANGUAGE 'plpgsql' ;


CREATE TRIGGER tg_tb_country_iso
    BEFORE insert ON public.tb_country_iso 
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tb_county_iso();

   
--------------------------------------------------------------------------------------------  
-- tb_service_type
--------------------------------------------------------------------------------------------   
CREATE SEQUENCE public.sq_service_type
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999; 


create table public.tb_service_type (
service_id INT PRIMARY KEY  NOT NULL,
service_created  timestamp  ,
service_name varchar(100) not null, 
service_description varchar(1000) not null,
service_picture text,
service_active  varchar(10) not null,
service_fee decimal not null,
service_db_language int REFERENCES public.tb_language (lg_reference_db_language_id),
attribute01 varchar(10),
attribute02 varchar(10),
attribute03 varchar(10)
);


CREATE OR REPLACE FUNCTION public.prd_tb_service_type() RETURNS TRIGGER AS 
 $BODY$
    BEGIN
	New.service_id = nextval('sq_service_type');
	New.service_created = now();
		RETURN NEW;
    END
	$BODY$
LANGUAGE 'plpgsql' ;


CREATE TRIGGER tg_tb_service_type
    BEFORE insert ON public.tb_service_type 
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tb_service_type();


--------------------------------------------------------------------------------------------  
-- tb_currency
--------------------------------------------------------------------------------------------   
CREATE SEQUENCE public.sq_currency
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999; 

create table public.tb_currency(
currency_id  INT PRIMARY KEY  NOT NULL,
currency_created timestamp  ,
currency_name varchar(10) not null unique,
attribute01  varchar(10),
artribute02 varchar(10)
);


CREATE OR REPLACE FUNCTION public.prd_tb_currency() RETURNS TRIGGER AS 
 $BODY$
    BEGIN
	New.currency_id = nextval('sq_currency');
	New.currency_created = now();
		RETURN NEW;
    END
	$BODY$
LANGUAGE 'plpgsql' ;


CREATE TRIGGER tg_tb_currency
    BEFORE insert ON public.tb_currency 
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tb_currency();


--------------------------------------------------------------------------------------------  
-- tb_payment_type
--------------------------------------------------------------------------------------------  
CREATE SEQUENCE public.sq_payment_type
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999; 
 
create table public.tb_payment_type (
payment_id   INT PRIMARY KEY  NOT NULL,
payment_created timestamp ,
payment_name varchar(50) not null ,
payment_description  varchar(200),
payment_active  varchar(10),
payment_db_language int REFERENCES public.tb_language (lg_reference_db_language_id) not null,
attribute01  varchar(10),
attribute02  varchar(10)
);

CREATE OR REPLACE FUNCTION public.prd_tb_payment_type() RETURNS TRIGGER AS

 $BODY$
    BEGIN
	New.payment_id = nextval('sq_payment_type');
	New.payment_created = now();
		RETURN NEW;
    END
	$BODY$
	
LANGUAGE 'plpgsql' ;


CREATE TRIGGER tg_tb_payment_type
    BEFORE insert ON public.tb_payment_type 
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tb_payment_type();


--------------------------------------------------------------------------------------------  
-- tb_user
--------------------------------------------------------------------------------------------  
CREATE SEQUENCE public.sq_user
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999; 

create table public.tb_user(
user_id INT PRIMARY KEY   NOT NULL,
user_created timestamp  ,
user_email varchar(64) not null UNIQUE,
user_alias character varying(24) not null UNIQUE;
user_name varchar(64) not null,
user_surname varchar(64) ,
user_country_id int REFERENCES public.tb_country_iso (country_id) not null,
user_phone_or_mobile varchar(20),
user_twitter_account varchar(64),
user_gender varchar(16) not null,
user_year int not null,
attribute01 varchar(10), 
attribute02 varchar(10), 
attribute03 varchar(10) 
);


CREATE OR REPLACE FUNCTION public.prd_tb_user() RETURNS TRIGGER AS 
$BODY$
    BEGIN
	New.user_id = nextval('sq_user');
	New.user_created = now();
	New.user_email = trim(lower(New.user_email));
	New.user_name = trim(lower(New.user_name));	
	New.user_surname = trim(lower(New.user_surname));	
	 
		RETURN NEW;
    END
	$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER tg_tb_user 
    BEFORE insert ON public.tb_user 
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tb_user();



   
--------------------------------------------------------------------------------------------  
-- tb_user_access_control
--------------------------------------------------------------------------------------------   
CREATE SEQUENCE public.sq_user_access_control
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999; 

CREATE TABLE public.tb_user_access_control (
control_id INT PRIMARY KEY   NOT NULL,
control_created timestamp  ,
control_updated timestamp, 
user_id INT not null REFERENCES public.tb_user(user_id), 
user_pass_control_word varchar(100)  not null,  -- hash and salted http://www.postgresql.org/docs/8.3/static/pgcrypto.html 
attribute01 varchar(10), 
attribute02 varchar(10)
);


CREATE OR REPLACE FUNCTION public.prd_tg_user_access_control() RETURNS TRIGGER AS 
 $BODY$
    BEGIN
	
	if (TG_OP = 'INSERT') then
	New.control_id = nextval('sq_user_access_control');
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
    BEFORE insert or update ON public.tb_user_access_control 
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tg_user_access_control();
  

--------------------------------------------------------------------------------------------  
-- tb_rating
--------------------------------------------------------------------------------------------   
CREATE SEQUENCE public.sq_rating
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999;   

create table public.tb_rating
(
rating_id INT PRIMARY KEY   NOT NULL,
rating_created timestamp  , 
rating_given_by_user_id  INT not null REFERENCES public.tb_user( user_id), 
rating_given_to_user_id int  not null REFERENCES public.tb_user(user_id), 
rating_rating_given int not null, 
attribute01   varchar(10), 
attribute02   varchar(10), 
atrribure03   varchar(10)


);


CREATE OR REPLACE FUNCTION public.prd_tb_rating() RETURNS TRIGGER AS 
 $BODY$
    BEGIN
	New.rating_id = nextval('sq_rating');
	New.rating_created = now();
		RETURN NEW;
    END
	$BODY$
 LANGUAGE 'plpgsql';

CREATE TRIGGER tg_tb_rating 
    BEFORE insert ON public.tb_rating 
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tb_rating();
  
  



--------------------------------------------------------------------------------------------   
-- tb_request_master
--------------------------------------------------------------------------------------------   
  
CREATE SEQUENCE public.sq_request_master
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999;


create table public.tb_request_master (
request_id INT PRIMARY KEY   NOT NULL,
request_created timestamp ,
request_updated timestamp,
request_created_by_user_id INT not null REFERENCES public.tb_user (user_id),
request_service_type_id INT not null REFERENCES public.tb_service_type (service_id) ,
request_from_iso_country_id INT not null REFERENCES public.tb_country_iso (country_id),
request_from_pick_up_address varchar(350) not null,
request_from_city_location varchar(150) not null,
request_from_post_code varchar(20) ,
request_from_pick_up_address_url varchar(500),
request_from_pick_up_time varchar(100) not null,
request_to_iso_country_id INT not null REFERENCES public.tb_country_iso (country_id),
request_to_city_location varchar(150) not null,
request_to_post_code varchar(20),
request_to_deliver_address varchar(350) not null,
request_to_deliver_address_url varchar(500),
request_weight_package varchar(10),
request_weight_in varchar(50),
request_description_package varchar(1000),
request_duration_minutes INT not null,
request_payment_money int not null,
request_currency_id INT not null REFERENCES public.tb_currency (currency_id),
request_comments varchar(1000), 
attribute01 varchar(10),
attribute02 varchar(10),
attribute03 varchar(10)
);


CREATE OR REPLACE FUNCTION public.prd_tg_tb_request_master() RETURNS TRIGGER AS 
$BODY$
    BEGIN
	
	if (TG_OP = 'INSERT') THEN
	
	New.request_id = nextval('sq_request_master');
	New.request_created = now();
	New.request_updated = now();	
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
    BEFORE insert or UPDATE ON public.tb_request_master 
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tg_tb_request_master();


   
   
--------------------------------------------------------------------------------------------   
-- tb_request_action
--------------------------------------------------------------------------------------------   
  
CREATE SEQUENCE public.sq_request_action
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999;


create table public.tb_request_action (
action_id INT PRIMARY KEY  NOT NULL,
action_created timestamp ,
action_request_master_id INT not null REFERENCES public.tb_request_master(request_id),
action_claim_given_by_user_id INT not null REFERENCES public.tb_user(user_id),
attribute01 varchar(10),
attribute02 varchar(10)
);

CREATE OR REPLACE FUNCTION public.prd_tb_request_action() RETURNS TRIGGER AS $BODY$
    BEGIN
	New.action_id = nextval('sq_request_action');
	New.action_created = now();
		RETURN NEW;
    END
	$BODY$
LANGUAGE 'plpgsql' ;


CREATE TRIGGER tg_tb_request_action 
    BEFORE UPDATE ON public.tb_request_action 
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tb_request_action();


--------------------------------------------------------------------------------------------   
-- tb_request_to_proceed
--------------------------------------------------------------------------------------------   
  
CREATE SEQUENCE public.sq_request_to_proceed
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999;


create table public.tb_request_to_proceed
(
proceed_id INT PRIMARY KEY  NOT NULL,
proceed_created timestamp, 
proceed_request_action_id INT REFERENCES public.tb_request_action (action_id),
proceed_user_to_do_service_id INT REFERENCES  public.tb_request_master(request_id), 
proceed_payment_currency_id INT REFERENCES public.tb_currency (currency_id),
proceed_payment_type_id INT REFERENCES public.tb_payment_type (payment_id),
proceed_payment_external_id int, -- id from the bank or from paypal or any other source
attribute01 varchar(10),
attribute02 varchar(10),
attribute03 varchar(10)

);



CREATE OR REPLACE FUNCTION public.prd_tb_request_to_proceed() RETURNS TRIGGER AS
$BODY$
    BEGIN
	New.proceed_id = nextval('sq_request_to_proceed');
	New.proceed_created = now();
		RETURN NEW;
    END
	$BODY$
 LANGUAGE 'plpgsql' ;


CREATE TRIGGER tg_tb_request_to_proceed 
    BEFORE insert ON public.tb_request_to_proceed 
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tb_request_to_proceed();


SET public.TIMEZONE = 'UTC';


--------------------------------------------------------------------------------------------   
-- tb_user_conn
--------------------------------------------------------------------------------------------   
  
CREATE SEQUENCE public.sql_conn
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999; 
   
create table public.tb_user_conn
(
connection_id INT PRIMARY KEY  NOT NULL,
connection_created timestamp,
connection_user_id int REFERENCES public.tb_user (user_id),
attribute01 varchar(30),
attribute02 varchar(30),
attribute03 varchar(30)
);


CREATE OR REPLACE FUNCTION public.prd_tb_user_conn() RETURNS TRIGGER AS
 $BODY$
    BEGIN
	New.connection_id = nextval('sql_conn');
	New.connection_created = now();
		RETURN NEW;
    END
	$BODY$
LANGUAGE 'plpgsql' ;


CREATE TRIGGER tg_tb_user_conn
    BEFORE insert ON public.tb_user_conn 
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tb_user_conn();


--------------------------------------------------------------------------------------------   
-- tb_miscellaneous. bin-trash-tb
--------------------------------------------------------------------------------------------   
  
CREATE SEQUENCE public.sql_miscellaneous
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999; 
   
create table public.tb_miscellaneous
(
mis_id INT PRIMARY KEY  NOT NULL,
mis_created timestamp,
mis_web_display_name varchar(100),
mis_global_ref varchar(10) ,
mis_db_language int REFERENCES public.tb_language (lg_reference_db_language_id) not null,
attribute01 varchar(30),
attribute02 varchar(30),
attribute03 varchar(30)
);


CREATE OR REPLACE FUNCTION public.prd_tb_miscellaneous() RETURNS TRIGGER AS
 $BODY$
    BEGIN
	New.mis_id = nextval('sql_miscellaneous');
	New.mis_created = now();
		RETURN NEW;
    END
	$BODY$
LANGUAGE 'plpgsql' ;


CREATE TRIGGER tg_tb_miscellaneous
    BEFORE insert ON public.tb_miscellaneous 
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tb_miscellaneous();


--------------------------------------------------------------------------------------------   
-- tb_user_trips_preferences. 
--------------------------------------------------------------------------------------------   
  
CREATE SEQUENCE public.sql_user_main_trips
   INCREMENT 1
   START 1
   MINVALUE 1
   MAXVALUE 99999999999999; 
   
create table public.tb_user_main_trips
(
user_pre_id INT PRIMARY KEY  NOT NULL,
user_pre_created timestamp,
user_pref_user_main_id int REFERENCES public.tb_user (user_id),
user_pref_iso_country_id INT not null REFERENCES public.tb_country_iso (country_id),
user_pref_from_city varchar(200),
user_pref_to_city varchar(200),
user_pref_week_days varchar(200),
user_pref_time_go varchar(100),
attribute01 varchar(30),
attribute02 varchar(30),
attribute03 varchar(30)
);


CREATE OR REPLACE FUNCTION public.prd_tb_user_main_trips() RETURNS TRIGGER AS
 $BODY$
    BEGIN
	New.user_pre_id = nextval('sql_user_main_trips');
	New.user_pre_created = now();
		RETURN NEW;
    END
	$BODY$
LANGUAGE 'plpgsql' ;


CREATE TRIGGER tg_tb_user_main_trips
    BEFORE insert ON public.tb_user_main_trips 
    FOR EACH ROW
   EXECUTE PROCEDURE public.prd_tb_user_main_trips();


   
-- scrip to insert values into most of the tables created above. 


insert into tb_language (lg_name, lg_reference_db_language_id) values ('English', 1);
insert into tb_language (lg_name, lg_reference_db_language_id) values ('Español', 2);

insert into public.tb_country_iso (
 country_iso_country_short , country_iso_country_name , country_iso_db_language, country_payment_fee_currency ) values ( 'ES', 'SPAIN', '1', 'EUR');

insert into public.tb_country_iso (
 country_iso_country_short , country_iso_country_name , country_iso_db_language,country_payment_fee_currency ) values ( 'US', 'UNITED STATES', '1', 'USD' );

insert into public.tb_country_iso (
 country_iso_country_short , country_iso_country_name , country_iso_db_language,country_payment_fee_currency ) values ( 'IE', 'IRELAND', '1', 'EUR');

insert into public.tb_country_iso (
 country_iso_country_short , country_iso_country_name , country_iso_db_language,country_payment_fee_currency ) values ( 'GB', 'UNITED KINGDOM', '1', 'GBP');

insert into public.tb_service_type (service_name, service_description, service_active, service_fee, service_db_language)  values
( 'Person to Person. Goods Delivery', 'Delivery goods (keys, books...) from an user to another', 1, 0.99, 1);

insert into public.tb_service_type (service_name, service_description, service_active, service_fee, service_db_language)  values
( 'Person to Person. Car Sharing', 'Car sharing/Pooling', 1, 0.99, 1);

insert into public.tb_payment_type (payment_name ,payment_description  ,payment_active  ,payment_db_language ) values
('Credit Card', 'Credit card paymet (Visa or Masterdard)', 1, 1);

insert into public.tb_payment_type (payment_name ,payment_description  ,payment_active  ,payment_db_language ) values
('PayPal', 'Payment serviced by PayPal', 1, 1);

insert into public.tb_miscellaneous ( mis_web_display_name, mis_global_ref,mis_db_language) values
('Male', 'Gender', 1);
insert into public.tb_miscellaneous ( mis_web_display_name, mis_global_ref,mis_db_language) values
('Female', 'Gender', 1);

insert into public.tb_miscellaneous ( mis_web_display_name, mis_global_ref,mis_db_language) values
('Kilos', 'Weight', 1);
insert into public.tb_miscellaneous ( mis_web_display_name, mis_global_ref,mis_db_language) values
('Pounds', 'Weight', 1);


insert into public.tb_user( user_email ,user_name ,user_surname ,user_country_id ,user_gender, user_year  ) values (
'jml@GMAIL.COM', 'jml', 'mora', 1, 'Male', '1971' ) ; 

insert into public.tb_user( user_email ,user_name ,user_surname ,user_country_id ,user_gender, user_year  ) values (
'josete_@GMAIL.COM', 'josete', 'josete2', 1, 'Male', '1971' ) ; 

insert into public.tb_currency( currency_name ) values ('EUR');
insert into public.tb_currency( currency_name ) values ('USD');
insert into public.tb_currency( currency_name ) values ('GBP');


insert into public.tb_request_master (
request_created_by_user_id ,
request_service_type_id ,
request_from_iso_country_id, 
request_from_pick_up_address,  
request_from_city_location ,
request_from_post_code ,
request_from_pick_up_address_url ,
request_from_pick_up_time ,
request_to_iso_country_id ,
request_to_city_location  ,
request_to_post_code  ,
request_to_deliver_address,  
request_to_deliver_address_url, 
request_weight_package ,
request_weight_in  ,
request_description_package,  
request_duration_minutes ,
request_payment_money  ,
request_currency_id 
) values
(
1,1,1, 'pick up my address', 'my location pick up', '28012 pc', 'url..google' , 'between 12 and 1' , 1, 'to this city', '39001 pc', 'to this address',
'to this url', 1.3 , 'kilos', 'big key ring', 12, 32,1
);



