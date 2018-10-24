CREATE
OR REPLACE FUNCTION public.getServicesHollidays () RETURNS TABLE (
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
		sH.services_hour_id ISNULL
	ORDER BY
	sH.description;
	END $$ LANGUAGE plpgsql;

SELECT
	public.getServicesHollidays ();