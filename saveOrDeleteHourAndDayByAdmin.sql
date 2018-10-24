CREATE
OR REPLACE FUNCTION "public".saveOrDeleteHourAndDayByAdmin (
	IN "in_description" VARCHAR,
	IN "in_reason" VARCHAR,
	IN "in_services_hour_id" INTEGER,
	OUT "status" VARCHAR
)
AS $$
BEGIN
	IF EXISTS (SELECT 1 FROM "public".user_packages WHERE service_datee = "in_description"::DATE AND service_hour_id = in_services_hour_id AND status_service != 3) THEN
		status = 'NO SE PUEDE DESBLOQUEAR HORARIO HASTA TERMINAR EL SERVICIO';
	ELSE--IF EXISTS (SELECT 1 FROM "public".user_packages WHERE service_datee = "in_description"::DATE AND service_hour_id = in_services_hour_id AND status_service != 1 AND status_service != 2) THEN
		IF EXISTS (SELECT 1 FROM "public".services_hollidays WHERE description = "in_description"::DATE AND services_hour_id = in_services_hour_id AND all_day IS FALSE) THEN
			DELETE FROM "public".services_hollidays WHERE description = "in_description"::DATE AND services_hour_id = in_services_hour_id AND all_day IS FALSE;
			status = 'HORARIO DESBLOQUEADO';
		ELSE
			INSERT INTO "public".services_hollidays (description, reason, services_hour_id, all_day) VALUES (in_description::DATE, in_reason, in_services_hour_id, FALSE);
			status = 'HORARIO BLOQUEADO';
		END IF;
	END IF;
END ; $$ LANGUAGE 'plpgsql' VOLATILE COST 100;

SELECT "public".saveOrDeleteHourAndDayByAdmin('2018-10-30', 'CELEBRACIÓN RELIGIOSA', 2);

