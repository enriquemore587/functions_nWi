CREATE
OR REPLACE FUNCTION public.get_services_hollidays_admin () RETURNS TABLE (
	ID INTEGER,
	description VARCHAR,
	reason VARCHAR
) AS $$
BEGIN
	RETURN QUERY SELECT
		sH. ID::INTEGER,
		sH.description::VARCHAR,
		sH.reason::VARCHAR
	FROM
		"public"."services_hollidays" AS sH 
	WHERE
		sH.all_day IS TRUE
	AND
		sH.services_hour_id IS NULL
	ORDER BY
	sH.description;
	END $$ LANGUAGE plpgsql;

SELECT
	public.get_services_hollidays_admin ();