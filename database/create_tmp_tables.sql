DROP SEQUENCE "REQUEST_ID_seq";

CREATE SEQUENCE REQUEST_ID_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE "REQUEST_ID_seq"
  OWNER TO bring2me;
  
  
  DROP SEQUENCE "REQUEST_ownerId_seq";

CREATE SEQUENCE REQUEST_ownerId_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE "REQUEST_ownerId_seq"
  OWNER TO bring2me;
  
  
  DROP TABLE "REQUESTS";

CREATE TABLE REQUESTS
(            
  ID integer NOT NULL DEFAULT nextval('REQUEST_ID_seq'::regclass),
  source character(32),
  destination character(32),
  subject character(32),
  reward integer,
  dueDate DATE,
  ownerId integer ,
  CONSTRAINT pk PRIMARY KEY (ID)
)
WITH (
  OIDS=FALSE
);

