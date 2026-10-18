describe truck_utilization_metrics;

# Checking for duplicate truck-month combinations
select
	count(*) as total_rows,
    count( 
		distinct
			concat(truck_id, '', month)
            ) as unique_truck_months,
	count(*) -  count( 
		distinct
			concat(truck_id, '', month)
            ) as duplicate_combinations
from truck_utilization_metrics;

# Checking for missing or invalid metrics
SELECT
    COUNT(*) AS total_records,

    SUM(CASE WHEN truck_id IS NULL OR TRIM(truck_id) = ''
        THEN 1 ELSE 0 END) AS missing_truck_ids,

    SUM(CASE WHEN month IS NULL OR TRIM(month) = ''
        THEN 1 ELSE 0 END) AS missing_months,

    SUM(CASE WHEN trips_completed IS NULL OR trips_completed < 0
        THEN 1 ELSE 0 END) AS invalid_trips,

    SUM(CASE WHEN total_miles IS NULL OR total_miles < 0
        THEN 1 ELSE 0 END) AS invalid_miles,

    SUM(CASE WHEN total_revenue IS NULL OR total_revenue < 0
        THEN 1 ELSE 0 END) AS invalid_revenue,

    SUM(CASE WHEN average_mpg IS NULL OR average_mpg <= 0
        THEN 1 ELSE 0 END) AS invalid_mpg,

    SUM(CASE WHEN maintenance_events IS NULL OR maintenance_events < 0
        THEN 1 ELSE 0 END) AS invalid_maintenance_events,

    SUM(CASE WHEN maintenance_cost IS NULL OR maintenance_cost < 0
        THEN 1 ELSE 0 END) AS invalid_maintenance_cost,

    SUM(CASE WHEN downtime_hours IS NULL OR downtime_hours < 0
        THEN 1 ELSE 0 END) AS invalid_downtime,

    SUM(CASE WHEN utilization_rate IS NULL
        OR utilization_rate < 0
        OR utilization_rate > 1
        THEN 1 ELSE 0 END) AS invalid_utilization_rate

FROM truck_utilization_metrics;

# Inspecting utilization rate values
select
	min(utilization_rate) as minimum_rate,
    max(utilization_rate) as maximum_rate,
    sum( 
		case
			when utilization_rate > 1
            then 1
            else 0
		end
	) as rate_above_1,
    sum( 
		case
			when utilization_rate < 0
            then 1
            else 0
		end
	) as rate_below_0
from truck_utilization_metrics;

# Investigating possible over utilisation
select
	case
		when utilization_rate <= 1 then 'At or below 100%'
        when utilization_rate <= 1.1 then '100% to 110%'
        when utilization_rate <= 1.2 then '110% to 120%'
        else 'Above 120%'
	end as utilization_band,
    count(*) as record_count,
    round( min(utilization_rate), 3) as minimum_rate,
    round( max(utilization_rate), 3) as maximum_rate
from truck_utilization_metrics
group by utilization_band
order by min(utilization_rate);

# Confirming the date range
SELECT
    MIN(month) AS earliest_month,
    MAX(month) AS latest_month,
    COUNT(DISTINCT month) AS distinct_months,
    COUNT(DISTINCT truck_id) AS distinct_trucks
FROM truck_utilization_metrics;