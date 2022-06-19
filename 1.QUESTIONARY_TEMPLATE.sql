CREATE TABLE QUESTIONARY_TEMPLATE
(ID 		NUMBER, 
NAME 		VARCHAR2(4000) 	NOT NULL);
  
ALTER TABLE QUESTIONARY_TEMPLATE ADD CONSTRAINT QUESTIONARY_TEMPLATE_PK PRIMARY KEY (ID);
ALTER TABLE QUESTIONARY_TEMPLATE ADD CONSTRAINT QUESTIONARY_TEMPLATE_UK UNIQUE (NAME);

CREATE SEQUENCE SEQ_QUESTIONARY_TEMPLATE
	START WITH     1
	INCREMENT BY   1
		NOCACHE
		NOCYCLE;

CREATE TRIGGER TRG_QUESTIONARY_TEMPLATE_I_U
	BEFORE UPDATE OR INSERT
		ON QUESTIONARY_TEMPLATE
	FOR EACH ROW
BEGIN
    IF(INSERTING) THEN
		:NEW.ID := SEQ_QUESTIONARY_TEMPLATE.NEXTVAL;
    END IF;
   
    IF(UPDATING) THEN
		IF :NEW.ID <> :OLD.ID THEN 
			raise_application_error(-20555, 'Can`t change id');
		END IF;
    END IF; 
END;
/

CREATE VIEW V_QUESTIONARY_TEMPLATE
(ID, 
NAME)
AS 
SELECT  ID, 
		NAME 
	FROM QUESTIONARY_TEMPLATE;