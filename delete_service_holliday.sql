CREATE
OR REPLACE FUNCTION "public"."delete_service_holliday" (
	IN "in_id" INTEGER,
	OUT "status" VARCHAR
)
AS $$
BEGIN
	DELETE FROM "public".services_hollidays WHERE "id" = in_id;
	status = 'SUCCESS';
END ; $$ LANGUAGE 'plpgsql' VOLATILE COST 100;

SELECT delete_service_holliday(1);