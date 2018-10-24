CREATE
OR REPLACE FUNCTION public.getServiceSelected (IN in_id_user VARCHAR, IN in_service_datee VARCHAR, IN in_service_sheet VARCHAR)
RETURNS TABLE (
service_id VARCHAR,
user_name VARCHAR,
phone VARCHAR,
serviceName VARCHAR,
tipo_inmueble VARCHAR,
ubicacion VARCHAR,
address VARCHAR,
bike VARCHAR,
observations VARCHAR,
hour VARCHAR
)
AS $$
	BEGIN
			RETURN QUERY
		SELECT 
			uP.id::VARCHAR AS service_id,
			(SELECT u."name"||' '||u.last_name FROM "public"."user" AS u WHERE u."id" = up.id_user)::VARCHAR AS user_name,
			(SELECT u.phone FROM "public"."user" AS u WHERE u."id" = up.id_user)::VARCHAR AS phone,
			(SELECT p.name_package FROM "public".packages AS p WHERE p."id" = uP.id_package) AS serviceName,
			uP.tipo_inmueble,
			(SELECT uA1.gps::VARCHAR FROM "public".user_address AS uA1 WHERE uA1."id" = uP.id_address) AS ubicacion,
			(SELECT "upper"(uA.street||' '|| (CASE WHEN uA.number_ext ISNULL THEN '1' ELSE uA.number_ext END)||', '||uA.colony||' C.P. '||uA.cp)::VARCHAR FROM "public".user_address AS uA WHERE uA."id" = uP.id_address) AS address,
			(SELECT b.model_bike::VARCHAR FROM "public".bikes AS b WHERE b."id" = uP.id_bike) AS bike,
			uP.observations,
			--uP.service_sheet,
			(SELECT sH.description::VARCHAR FROM "public".services_hours AS sH WHERE sH."id" = uP.service_hour_id) AS "hour"
		FROM "public".user_packages AS uP
		WHERE
			uP.id_user = in_id_user::uuid
		AND
			uP.service_datee = in_service_datee::DATE
		AND
			uP.service_sheet = in_service_sheet;

	END $$ LANGUAGE plpgsql;

SELECT public.getServiceSelected('47a04de7-d728-4430-8393-a17babdf358c', '2018-10-31', 'HOLA');
