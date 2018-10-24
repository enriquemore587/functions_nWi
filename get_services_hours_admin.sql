CREATE
OR REPLACE FUNCTION public.get_services_hours_admin () RETURNS TABLE (
	ID INTEGER,
	ENABLE BOOLEAN,
	description VARCHAR
) AS $$
BEGIN
	RETURN QUERY SELECT
		sH. ID,
		sH."enable"::BOOLEAN,
		sH.description::VARCHAR
	FROM
		"public"."services_hours" AS sH 
	WHERE
		sH.enable IS TRUE
	ORDER BY
	sH.description;
	END $$ LANGUAGE plpgsql;

SELECT
	public.get_services_hours_admin ();