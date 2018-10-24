CREATE
OR REPLACE FUNCTION public.getServicesToPerform (IN in_service_date VARCHAR)
RETURNS TABLE (
id_user VARCHAR,
service_sheet VARCHAR,
photo TEXT,
user_name VARCHAR,
"hour" VARCHAR,
num_bike INTEGER
)
AS $$
	BEGIN
			RETURN QUERY
		SELECT 
			up.id_user::VARCHAR AS id_user,
			up.service_sheet::VARCHAR AS service_sheet,
			(SELECT u.user_photo FROM "public"."user" AS u WHERE u."id" = up.id_user)::TEXT AS photo,
			(SELECT u."name"||' '||u.last_name FROM "public"."user" AS u WHERE u."id" = up.id_user)::VARCHAR AS user_name,
			(SELECT (SELECT description::VARCHAR FROM "public".services_hours AS sH WHERE "id" = up2.service_hour_id) FROM "public".user_packages AS up2 WHERE up2.id_user = up.id_user AND up2.service_sheet = up.service_sheet ORDER BY up2.service_hour_id ASC LIMIT 1) AS "hour",
			"count"(*)::INTEGER AS num_bike
		FROM "public"."user_packages" AS up
		WHERE up.service_datee = in_service_date::DATE
		AND up.status_service != 3
		GROUP BY (up.service_sheet, up.id_user);

	END $$ LANGUAGE plpgsql;

SELECT public.getServicesToPerform('2018-10-31');
