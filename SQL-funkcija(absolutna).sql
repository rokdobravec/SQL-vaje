delimiter $
CREATE FUNCTION absolutna(a DOUBLE)
RETURNS double
BEGIN
	if a<0 then RETURN -a;
	ELSE RETURN a;
	END if;
END
$
delimiter ;


select absolutna(-10)
