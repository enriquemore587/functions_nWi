CREATE
OR REPLACE FUNCTION "public"."get_historical_record_of_the_user_to_packages" (IN "v_id_user" VARCHAR) RETURNS TABLE (
	"id_package" int4,
	"id_service" int8,
	"address" TEXT,
	"registration_date" timestamptz,
	"service_date" timestamptz,
	"service_date_performed" timestamptz,
	"status_service" int2,
	"ranking" int2,
	"comments" VARCHAR,
	"status" int2,
	"name_package" VARCHAR,
	"description_package" TEXT,
	"terms" TEXT,
	"cost" float8,
	"observations" VARCHAR,
	"tipo_inmueble" VARCHAR
) AS $BODY$
BEGIN
	RETURN QUERY SELECT
		usePack.id_package,
		usePack. ID AS id_service,
		(
			addre.street || ' #Ext. ' || addre.number_ext || (
				CASE
				WHEN addre.number_int = ' ' THEN
					''
				ELSE
					' #Int ' || addre.number_int
				END
			) || ', ' || addre.colony || ', ' || muni.descripcion || ', ' || sta.descripcion || ', C.P.' || addre.cp
		) AS address,
		usePack.registration_date AT TIME ZONE 'CST' AS registration_date,
		usePack."
service_date" AT TIME ZONE 'CST' AS service_date,
		usePack.service_date_performed AT TIME ZONE 'CST' AS service_date_performed,
		usePack.status_service,
		usePack.ranking,
		usePack.comments,
		usePack.status,
		pack.name_package,
		pack.description AS description_package,
		pack.terms,
		pack. COST,
		usePack.observations,
		usePack.tipo_inmueble
	FROM
		user_packages AS usePack
	INNER JOIN packages AS pack ON usePack.id_package = pack. ID
	INNER JOIN user_address AS addre ON usePack.id_address = addre. ID
	INNER JOIN municipalities AS muni ON addre.municipality = muni. ID
	AND addre. STATE = muni.id_states
	INNER JOIN "
states" AS sta ON addre. STATE = sta. ID
	WHERE
		usePack.id_user = v_id_user :: uuid ;
	END $BODY$ LANGUAGE 'plpgsql' VOLATILE COST 100 ROWS 1000;

