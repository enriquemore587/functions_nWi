CREATE
OR REPLACE FUNCTION public.getServicesHoursByDay (IN in_date VARCHAR) RETURNS TABLE (
	"id" INTEGER,
	hora VARCHAR,
	enabled BOOLEAN
) AS $$
BEGIN
	RETURN QUERY
		
		SELECT sHours.id, SUBSTRING (sHours.description::VARCHAR,0, 6)::VARCHAR  AS hora, (CASE WHEN sHol.services_hour_id IS NOT NULL OR uP.service_hour_id IS NOT NULL THEN FALSE ELSE TRUE END) AS enabled
		FROM "public"."services_hours" AS sHours	-- obtengo todos los horarios
		LEFT JOIN "public".services_hollidays AS sHol ON sHol.services_hour_id = sHours.id AND sHol.description = in_date::DATE AND sHol.all_day = FALSE -- obtengo los horarios de los dias bloqueados por la administración
		LEFT JOIN "public".user_packages AS uP ON uP.service_hour_id = sHours.id AND uP.service_datee = in_date::DATE
		AND uP.status_service != 3--obtengo los horarios ocupados por servicios
		WHERE sHours.enable is TRUE
		ORDER BY sHours.description;


	END $$ LANGUAGE plpgsql;

SELECT
	public.getServicesHoursByDay ('2018-10-31');