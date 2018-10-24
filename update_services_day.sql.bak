CREATE
OR REPLACE FUNCTION "public"."update_services_day" (
	IN "in_id" INTEGER,
	IN "in_enable" BOOLEAN,
	IN "in_start" VARCHAR,
	IN "in_end" VARCHAR,
	OUT "status" VARCHAR
)
AS $$
BEGIN
	UPDATE "public".services_days
	SET
		"enable" = "in_enable",
		"start" = "in_start"::TIME,
		"end" = "in_end"::TIME
	WHERE
		"id" = "in_id";
	"status" = 'success';
END ; $$ LANGUAGE 'plpgsql' VOLATILE COST 100;

SELECT update_services_day(1,TRUE, '09:00','17:00');

