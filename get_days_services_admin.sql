CREATE
OR REPLACE FUNCTION public.get_days_services_admin () RETURNS TABLE (
	ID INTEGER,
	ENABLE BOOLEAN,
	description_day VARCHAR,
	"start" VARCHAR,
	"end" VARCHAR
) AS $$
BEGIN
	--in_req_id es id de banco
	RETURN QUERY SELECT
		sD. ID,
		sD."enable",
		sD.description_day,
		SUBSTRING (sD."start"::VARCHAR,0, 6)::VARCHAR,
		SUBSTRING (sD."end"::VARCHAR,0, 6)::VARCHAR
	FROM
		"public"."services_days" AS sD 
	WHERE
		sD.id > 0
	ORDER BY
	sD.id;
	END $$ LANGUAGE plpgsql;

SELECT
	public.get_days_services_admin ();