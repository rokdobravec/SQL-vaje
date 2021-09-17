delimiter $
CREATE FUNCTION mesec (a INT)
RETURNS VARCHAR(20)
BEGIN
		CASE a%12 -- deli vpisano stevilo da dobimo a mansje ali enako 12
    	WHEN 1 THEN RETURN "Prosinec";
    	WHEN 2 THEN RETURN "Svecan";
    	WHEN 3 THEN RETURN "Susec";
    	WHEN 4 THEN RETURN "Mali Traven";
    	WHEN 5 THEN RETURN "Veliki Traven";
    	WHEN 6 THEN RETURN "Roznik";
    	WHEN 7 THEN RETURN "Mali Srpan";
    	WHEN 8 THEN RETURN "Veliki Srpan";
    	WHEN 9 THEN RETURN "Kimovec";
    	WHEN 10 THEN RETURN "Vinotok";
    	WHEN 11 THEN RETURN "Listopad";
    	WHEN 12 THEN RETURN "Gruden";
    	END case;
END 
$
deliniter ; 

SELECT mesec(13)

