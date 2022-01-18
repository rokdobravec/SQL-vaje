-- 2. test

-- 1. a) Prijavite se na omenjeni strežnik in ugotovite kakšne pravice imate. Te pravice zapišite med kodo.
SHOW GRANTS;
-- GRANT CREATE USER ON *.* TO `rok`@`%` IDENTIFIED BY PASSWORD '*1138F32F44D0BD1A398263876D87A130CAC3C2B7'
-- GRANT ALL PRIVILEGES ON `podatkovna_zbirka`.* TO `ork`@`%` WITH GRANT OPTION

-- b) V podatkovni zbirki z imenom enakim vašemu uporabniškemu imenu ustvarite poljubno tabelo, ki vsebuje vsaj dva stolpca različnih podatkovnih tipov. Podpira naj šumnike in ima primarni ključ.
CREATE TABLE tabela (
	ID INT(11) PRIMARY KEY,
	stevilo INT(11),
	besedilo VARCHAR(30)
)
DEFAULT CHARSET='utf8'

-- c) Ustvarjeni tabeli odstranite en stolpec.
ALTER TABLE tabela
DROP COLUMN stevilo;

--ustvarjanje gesla za varen uporabniški račun
SELECT PASSWORD('password');

-- 2. a) Ustvarite uporabniško ime, ki je kot vaše iz prve naloge, le da na zadnje mesto namesto črke a napišete črko c. (npr. Novak Špela bi imela uporabniško ime novspec.) Geslo naj bo g3sl0 in naj bo ustvarjeno na varen način.
CREATE USER rok
IDENTIFIED BY PASSWORD 'password';

-- b) Prej ustvarjenemu uporabniku dodelite pravice za izpisovanje in brisanje podatkov, za ustvarjanje pogledov in ustvarjanje ter izvajanje funkcij in procedur na vaši podatkovni zbirki.
GRANT SELECT, DELETE, CREATE VIEW, CREATE ROUTINE, EXECUTE
ON podatkovna_zbirka.*
TO rok@31.15.151.78;

-- c) Odvzemite mu pravico za brisanje podatkov.
REVOKE DELETE
ON podatkovna_zbirka.tabela    [* za vse tabele v bazi]
FROM rok@31.15.151.78;

-- d) V isti podatkovni zbirki ustvarite funkcijo (6t) z imenom vsota3, ki vrne vsoto treh podanih realnih vrednosti. Dodelite pravice (6t) za dostop do ustvarjene funkcije. Uporabite ustvarjeno funkcijo in izpišite rezultat (3t).
delimiter $
CREATE FUNCTION funkcija (a DOUBLE, b DOUBLE, c DOUBLE)
RETURNS DOUBLE
BEGIN
	RETURN a + b + c;
END
$
delimiter ;

GRANT EXECUTE
ON FUNCTION podatkovna_zbirka.ime_funkcije
TO rok@31.15.151.78;

SELECT vsota3(5.5, 4.5, 3.5);
-- Rezultat = 13.5

-- 3. a) Izvedite naslednje zaporedje ukazov:
SET autocommit = 0;

CREATE TABLE knjige (
	naslov VARCHAR(30)
)
DEFAULT CHARSET='utf8'

INSERT INTO knjige
VALUES('Formula smrti');

START TRANSACTION;

UPDATE knjige
SET naslov = 'Vojna in mir'
WHERE naslov = ' Formula smrti';

SAVEPOINT sp;

SET autocommit = 1;

DELETE FROM knjige
WHERE naslov = 'Vojna in mir';

ROLLBACK;

-- b) Kakšni so podatki (pravilni) v tabeli knjige po koncu zaporedja ukazov točke a). Napišite poizvedbo in odgovor.
SELECT * FROM knjige;
-- V tabeli je naslov 1. vnešene knjige: Formula smrti.