INSERT INTO tb_country_iso(country_created, country_iso_country_short, country_iso_country_name)   VALUES (now(), 'ES', 'SPAIN');
--country is missing international ISO code  ( 34 )
INSERT INTO tb_currency(currency_created, currency_currency_iso_name, currency_currency_fee)   VALUES (now(), 'EURO', 1); 
--currency is missing short name and symbol ( EU, €)
INSERT INTO tb_payment_type(payment_created, payment_name, payment_description,   payment_active)    VALUES (now(),'VISA','Credit Card',true);
INSERT INTO tb_payment_type(payment_created, payment_name, payment_description,   payment_active)    VALUES (now(),'PayPal','Online method',true);

INSERT INTO tb_service_type(service_created, service_name, service_description, service_active, service_service_fee)    VALUES (now(),'Bring Stuff','Main Function',true,1);

INSERT INTO tb_user(user_created, user_email, user_nickname, user_country_id,user_phone_or_mobile, user_twitter_account)   VALUES (now(),'muallin@gmail.com','josete',1,'123456','josetesan');
INSERT INTO tb_user(user_created, user_email, user_nickname, user_country_id,user_phone_or_mobile, user_twitter_account)   VALUES (now(),'jmlavin@gmail.com','javi',1,'7890123','jml');

INSERT INTO tb_request_master(request_created,  request_created_by_user_id,  request_service_type_id,
	    request_from_iso_country_id, request_to_iso_country_id, 
            request_from_city_location, request_to_city_location,
            request_pick_up_address,  request_pick_up_time, request_deliver_address,
            request_weight_package,   request_description_package, request_duration_minutes,
            request_payment_money, request_currency_id )
    VALUES (now(), 1, 1,
            1, 1, 
            'madrid', 'santander', 
            'calle 5', now() + interval '3 hour', 'plaza 7',
            '0.73','reloj complicado',100, 
            '13', 1 );

--request_master falta CP ciudades ( origen, destino). ¿ que es request_duration_minutes ?


--user-control: password está mal. Falta joined time.
