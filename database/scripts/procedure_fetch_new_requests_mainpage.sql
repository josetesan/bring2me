
CREATE OR REPLACE FUNCTION fetch_new_request_main_page(
					out v_source char,
					out v_destination char,
					out v_subject char,
					out v_currency char,
					out v_reward int
					)
AS
$BODY$
DECLARE
g_max_user_id int default 6;

BEGIN

 
 SELECT S.country_iso_country_name , 
	D.country_iso_country_name,  
        tb_request_master.request_description_package ,
        tb_currency.currency_name ,
        tb_request_master.request_payment_money 
        INTO 
					  v_source  ,
					  v_destination  ,
					  v_subject  ,
					  v_currency  ,
					  v_reward  
                               FROM  tb_user,  tb_request_master,  tb_country_iso S,
                               tb_country_iso D,  tb_currency WHERE  tb_request_master.request_from_iso_country_id = S.country_id AND 
                               tb_request_master.request_to_iso_country_id = D.country_id AND  tb_request_master.request_created_by_user_id = tb_user.user_id AND 
                               tb_request_master.request_currency_id = tb_currency.currency_id 
                               LIMIT g_max_user_id;
  
END;
$BODY$
  LANGUAGE plpgsql 

