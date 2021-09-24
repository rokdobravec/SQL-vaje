-- ob drisu v tabeli rojstni_dnevi naj prošžilec shrani izbrisano vrednost shrani v 
-- tabelo rojstni_dnevi_arhi

-- izdelava tabele arhiv
CREATE TABLE rojstni_dnevi_arhiv LIKE rojstni_dnevi

 -- izdelava prožilca za po uporabi delete
CREATE TRIGGER prožilec_delete
AFTER DELETE
ON rojstni_dnevi
FOR EACH ROW 
INSERT INTO rojstni_dnevi_arhiv(id, ime, priimek, rojstni_dan, spol)
VALUES(OLD.id, OLD.ime, OLD.priimek, OLD.rojstni_dan, OLD.spol)

-- upoaba prožilca
DELETE FROM rojstni_dnevi
WHERE id BETWEEN 20 AND 40

-- ob vnosu nove knjige v knjige preverimo ali avtor obstaja 
-- v tabeli rojstni dnevi, če ne ga tja vnesemo
delimiter $
CREATE TRIGGER prozilec_insert
AFTER INSERT
ON knjige
FOR EACH ROW
BEGIN
	DECLARE stevilo INT;
	
	SELECT COUNT(*)
	INTO stevilo INT FROM rojstni_dnevi
	WHERE NEW.ime_avtorja=ime AND NEW.priimek_avtorja=priimek;
	
	if strevilo=0 then
		INSERT INTO rojstni_dnevi(ime, priimek)
		VALUES(NEW.ime_avtorja, NEW.priimek_avtorja);
	END if;
END 
$ 
delimiter ;


-- ustvarite prožilec ki bo o spremembi imena ali 
-- priimka iz tabele rojstni_dnnevi popravil ustrecne podatke v tabeli knjige 
delimiter $
CREATE TRIGGER prozilec_update
AFTER UPDATE
ON rojstni_dnevi
FOR EACH ROW
BEGIN
	if OLD.ime != NEW.ime then
		UPDATE knjige 
		SET ime_avtorja = NEW.ime
		WHERE ime_avtorja = OLD.ime
		AND priimek_avtorja = OLD.priimek;
	END if;
	if OLD.priimek != NEW.priimek then
		UPDATE knjige 
		SET priimek_avtorja = NEW.priimek
		WHERE priimek_avtorja = OLD.priimek
		AND ime_avtorja = OLD.ime;
	END if;
END 
$
delimiter ;

-- uporaba prozilec_update
UPDATE rojstni_dnevi
SET ime = 'Franc'
WHERE ime = 'France'


-- če vnesemo negativno ceno vnese ceno 0
delimiter $
CREATE TRIGGER prozilec_before
BEFORE INSERT
ON knjige
FOR EACH ROW
BEGIN
	if NEW.cena < 0 then
	SET new.cena = 0;
	END if;
END
$
delimiter ;

INSERT INTO knjige(cena)
VALUES(34);














