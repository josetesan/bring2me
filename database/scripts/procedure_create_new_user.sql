﻿-- Function: update_user_pass(character, character)

-- DROP FUNCTION update_user_pass(character, character);

CREATE OR REPLACE FUNCTION update_user_pass(IN v_user_email character, IN v_user_pwd character, OUT v_message_out integer)
  RETURNS integer AS
$BODY$
DECLARE
v_check_existing_email integer;
g_user_id int;
g_max_user_id int;

BEGIN

 select count(*) into 	v_check_existing_email from tb_user where 1=1 and trim(lower(user_email)) = trim(lower(v_user_email));

 -- verify the existing account exists   
 if v_check_existing_email = 0 or v_check_existing_email is null then 

		 -- get user_id
		 select  user_id into g_user_id from tb_user where   trim(lower(user_email)) = trim(lower(v_user_email));
			 
		 -- update pwd, no plain txt
		 update tb_user_access_control set user_pass_control_word = v_user_pwd where user_id = g_user_id;
							
   v_message_out := 1; --pwd changed. 1 ok
   
   end if; 
 
     v_message_out := 0 ; --pwd not changed. problems.
 

  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION update_user_pass(character, character)
  OWNER TO postgres;
