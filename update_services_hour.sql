CREATE
OR REPLACE FUNCTION "public"."updateServicesHour" (
	IN "in_id" INTEGER,
	IN "in_enable" BOOLEAN,
	OUT "status" VARCHAR
)
AS $$
BEGIN
	UPDATE "public".services_hours
	SET
		"enable" = "in_enable"
	WHERE
		"id" = "in_id";
	"status" = 'SUCCESS';
END ; $$ LANGUAGE 'plpgsql' VOLATILE COST 100;

SELECT "updateServicesHour"(1,TRUE);