CREATE
OR REPLACE FUNCTION public.insertUpdateHolliday (
	IN "in_id" INTEGER,
	IN "in_description" VARCHAR,
	IN "in_reason" VARCHAR,
	OUT "status" VARCHAR
)
AS $$
BEGIN
	IF in_id != 0 THEN
		UPDATE "public".services_hollidays SET description = "in_description"::DATE, reason = "upper"("in_reason") WHERE id = "in_id";
	ELSE
		INSERT INTO "public".services_hollidays (description, reason) VALUES ("in_description"::DATE, "upper"("in_reason"));
	END IF;
	status = 'SUCCESS';
END ; $$ LANGUAGE 'plpgsql' VOLATILE COST 100;

SELECT public.insertUpdateHolliday(0, '2018-10-01', 'RAZÓN');