INSERT INTO tb_country_iso(country_created, country_iso_country_short, country_iso_country_name)   VALUES (now(), 'ES', 'SPAIN');
--country is missing international ISO code
INSERT INTO tb_currency(currency_created, currency_currency_iso_name, currency_currency_fee)   VALUES (now(), 'EURO', 1); 
--currency is missing short name