SELECT 
    cabs.company_name,
    COUNT(trip_id) AS trips_amount
FROM 
    cabs
    INNER JOIN trips ON cabs.cab_id = trips.cab_id

WHERE trips.start_ts::date BETWEEN '2017-11-15' AND '2017-11-16'

GROUP BY 
    cabs.company_name

ORDER BY trips_amount DESC;

--  
SELECT 
    cabs.company_name,
    COUNT(trip_id) AS trips_amount
FROM cabs
    LEFT JOIN trips ON cabs.cab_id = trips.cab_id
WHERE 
    (cabs.company_name LIKE '%Yellow%' OR cabs.company_name LIKE '%Blue%')
    AND trips.start_ts::date BETWEEN '2017-11-01' AND '2017-11-07'
GROUP BY 
    cabs.company_name;

--
SELECT 
    CASE WHEN cabs.company_name = 'Flash Cab' THEN cabs.company_name
    WHEN cabs.company_name = 'Taxi Affiliation Services' THEN cabs.company_name
    ELSE 'Other'
    END AS company,
    COUNT(trips.trip_id) AS trips_amount
FROM 
    cabs 
    INNER JOIN trips ON cabs.cab_id = trips.cab_id
WHERE 
    trips.start_ts::date BETWEEN '2017-11-01' AND '2017-11-07'
GROUP BY 
    company
ORDER BY
    trips_amount DESC;

--
SELECT *

FROM neighborhoods

WHERE name IN ('Loop', 'O''Hare');

--
SELECT 
    ts,
    CASE WHEN description LIKE '%rain%' THEN 'Bad'
    WHEN description LIKE '%storm%' THEN 'Bad'
    ELSE 'Good'
    END AS weather_conditions
FROM weather_records;


--
SELECT 
    trips.start_ts,
    CASE WHEN description LIKE '%rain%' THEN 'Bad'
    WHEN description LIKE '%storm%' THEN 'Bad'
    ELSE 'Good'
    END AS weather_conditions,
    trips.duration_seconds

FROM trips
    INNER JOIN weather_records ON trips.start_ts = weather_records.ts
    INNER JOIN neighborhoods ON trips.pickup_location_id = neighborhoods.neighborhood_id

WHERE 
    EXTRACT(DOW FROM trips.start_ts) = 6
    AND trips.pickup_location_id = 50
    AND trips.dropoff_location_id = 63
ORDER BY trips.trip_id
