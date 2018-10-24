CREATE
OR REPLACE FUNCTION "public"."set_packages_subscribe_copy" (
	IN "v_id_user" VARCHAR,
	IN "v_id_package" int4,
	IN "v_id_address" int4,
	IN "v_registration_date" TIMESTAMP,
	IN "v_service_date" TIMESTAMP,
	IN "v_id_bike" int4,
	IN "in_tipo_inmueble" VARCHAR,
	OUT "v_status" VARCHAR
) RETURNS "pg_catalog"."varchar" AS $BODY$
DECLARE v_id_pck INT ;
BEGIN
	INSERT INTO user_packages (
		id_user,
		id_package,
		id_address,
		registration_date,
		"
service_date",
		id_bike,
		"tipo_inmueble"
	)
VALUES
	(
		v_id_user :: uuid,
		v_id_package,
		v_id_address,
		v_registration_date,
		v_service_date,
		V_id_bike,
		in_tipo_inmueble
	) RETURNING ID INTO v_id_pck ;
IF (v_id_pck > 0) THEN
	INSERT INTO sms_packages (id_service)
VALUES
	(v_id_pck) ;
END
IF ; v_status = (SELECT '1,' || v_id_pck) ; EXCEPTION
WHEN OTHERS THEN
	v_status = (SELECT '0,0') ;
END ; $BODY$ LANGUAGE 'plpgsql' VOLATILE COST 100;

