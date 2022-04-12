CREATE TABLE QUESTIONARY_TEMPLATE
(ID 		NUMBER, 
 NAME 		VARCHAR2(4000) 	not NULL);
  
ALTER TABLE QUESTIONARY_TEMPLATE ADD CONSTRAINT QUESTIONARY_TEMPLATE_PK PRIMARY KEY (ID);
ALTER TABLE QUESTIONARY_TEMPLATE ADD CONSTRAINT QUESTIONARY_TEMPLATE_UK UNIQUE (NAME);

CREATE SEQUENCE SEQ_QUESTIONARY_TEMPLATE
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE TRIGGER TRG_QUESTIONARY_TEMPLATE_I_U
	before update or insert
		ON QUESTIONARY_TEMPLATE
	for each row
begin
    IF(inserting) THEN
		:NEW.id := SEQ_QUESTIONARY_TEMPLATE.nextval;
    END IF;
   
    IF(updating) THEN
		IF :NEW.id <> :OLD.id THEN 
			raise_application_error(-20555, 'Can`t change id')
		END IF;
    END IF; 
end;