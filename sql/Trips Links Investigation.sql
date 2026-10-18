# Validating truck ids in trips table
select
	count(*) as total_trips,
    sum( 
		case
			when truck_id is null
				or trim(truck_id) = ''
            then 1
            else 0
		end
	) as missing_truck_ids,
    sum(
		case
			when truck_id is not null
				and trim(truck_id) <> ''
                and truck_id not in ( select truck_id from trucks)
			then 1
            else 0
		end
	) as unmatched_truck_ids
from trips;

# result found we have 1672 trips w/out truck ids

# Investigating if trailers and drivers are also missing from the above trips
select
	count(*) as trips_with_missing_truck,
    sum(
		case
			when driver_id is null
				or trim(driver_id) = ''
			then 1
            else 0
		end
	) as also_missing_driver,
    sum(
		case
			when trailer_id is null
				or trim(trailer_id) = ''
			then 1
            else 0
		end
	) as also_missing_trailer
from trips
where truck_id is null or trim(truck_id) = '';
	
#Checking if each driver_id exists in drivers
select
	count(*) as total_trips,
	sum(
		case
			when driver_id is null
				or trim(driver_id) = ''
			then 1
            else 0
		end
	) as missing_driver_ids,
    sum(
		case
			when driver_id is not null
				and trim(driver_id) <> ''
                and driver_id not in (select driver_id from drivers)
			then 1
            else 0
		end
	) unmatched_driver_ids
from trips;

#Checking if each trailer_id exists in trailers
select
	count(*) as total_trips,
    sum(
		case
			when trailer_id is null
				or trim(trailer_id) = ''
			then 1
            else 0
		end
	) as missing_trailer_ids,
    sum(
		case
			when trailer_id is not null
				and trim(trailer_id) <> ''
                and trailer_id not in (select trailer_id from trailers)
			then 1
            else 0
		end
	) as unmatched_trailer_ids
from trips;

# Checking if each load is matched with one trip
select
	count(*) as total_trips,
    count( distinct load_id) as unique_load_id,
    count(*) - count(distinct load_id) as repeated_load_ids
from trips;


# Confirming date ranges
select
	min(dispatch_date) as earliest_dispatch_date,
    max(dispatch_date) as latest_dispatch_date
from trips;

describe trips;

# Validating trip metrics
SELECT
    SUM(CASE WHEN actual_distance_miles IS NULL THEN 1 ELSE 0 END)
        AS missing_distance,
    SUM(CASE WHEN actual_distance_miles <= 0 THEN 1 ELSE 0 END)
        AS nonpositive_distance,
    SUM(CASE WHEN actual_duration_hours IS NULL THEN 1 ELSE 0 END)
        AS missing_duration,
    SUM(CASE WHEN actual_duration_hours <= 0 THEN 1 ELSE 0 END)
        AS nonpositive_duration,
    SUM(CASE WHEN fuel_gallons_used IS NULL THEN 1 ELSE 0 END)
        AS missing_fuel_gallons,
    SUM(CASE WHEN fuel_gallons_used <= 0 THEN 1 ELSE 0 END)
        AS nonpositive_fuel_gallons
FROM trips;

# Checking MPG values
SELECT
    SUM(CASE WHEN average_mpg IS NULL THEN 1 ELSE 0 END)
        AS missing_mpg,
    SUM(CASE WHEN average_mpg <= 0 THEN 1 ELSE 0 END)
        AS nonpositive_mpg,
    MIN(average_mpg) AS minimum_mpg,
    MAX(average_mpg) AS maximum_mpg,
    ROUND(AVG(average_mpg), 2) AS average_mpg
FROM trips;

# Checking calculated MPG against recorded MPG
select
	count(*) as total_trips,
    Round( 	
		avg( 
			actual_distance_miles / fuel_gallons_used), 2) as calculated_avg_mpg,
	Round( 
				avg(average_mpg), 2) as recorded_avg_mpg,
	Round( 
		Avg(ABS( 
				(actual_distance_miles / fuel_gallons_used) - average_mpg )), 2) as average_absolute_mpg_difference
from trips;

# Additional trips to trailers, drivers and trucks validation
select
	count(*) as total_trips,
    sum(
		case
			when t.driver_id is null
				or d.driver_id is null
			then 1
            else 0
		end
	) as missing_or_mismatched_drivers,
    sum(
		case
			when t.truck_id is null
				or tr.truck_id is null
			then 1
            else 0
		end
	) as missing_or_unmatched_trucks,
	sum( 
		case
			when t.trailer_id is null
				or tl.trailer_id is null
			then 1
            else 0
		end
	) as missing_or_unmatched_trailers
from trips t
left join drivers d 
	on t.driver_id = d.driver_id
left join trucks tr
	on t.truck_id = tr.truck_id
left join trailers tl
	on t.trailer_id = tl.trailer_id;
    
select
	sum(
		case
			when driver_id is null
				or trim(driver_id) = ''
			then 1
            else 0
		end
	) as missing_driver_ids,
    sum( 
		case
			when truck_id is null
				or trim(truck_id) = ''
			then 1
            else 0
		end
	) as missing_truck_ids,
sum( 
	case
		when trailer_id is null
			or trim(trailer_id) = ''
		then 1
        else 0
	end
) as missing_trailer_ids
from trips;

# Validating trip status
select
	trip_status,
    count(*) as trip_count
from trips
group by trip_status
order by trip_count;