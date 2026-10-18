# Establishing baseline for revenue, load volume, distance travelled and revenue per mile across the reporting period
SELECT
    DATE_FORMAT(load_date, '%Y-%m') AS reporting_month,
    COUNT(*) AS total_loads,
    ROUND(SUM(revenue + fuel_surcharge + accessorial_charges), 2) AS total_revenue,
    ROUND(SUM(revenue + fuel_surcharge + accessorial_charges)
          / NULLIF(SUM(t.actual_distance_miles), 0), 2) AS revenue_per_mile,
    SUM(t.actual_distance_miles) AS total_miles
FROM loads l
JOIN trips t
    ON l.load_id = t.loacustomersd_id
WHERE load_date >= '2022-01-01'
  AND load_date < '2025-01-01'
GROUP BY DATE_FORMAT(load_date, '%Y-%m')
ORDER BY reporting_month;

# Investigating route-revenue performance
select
	l.route_id,
    count(*) as total_loads,
    round(
		sum(l.revenue + l.fuel_surcharge + l.accessorial_charges), 2) as total_revenue,
	sum( t.actual_distance_miles) as total_miles,
    round(
		sum(l.revenue + l.fuel_surcharge + l.accessorial_charges) / nullif( sum(t.actual_distance_miles), 0)
        , 2) as revenue_per_mile,
	count( d.load_id) as delivery_count,
    sum(
		case
			when d.on_time_flag = 'True'
            then 1
            else 0
		end
	) as on_time_deliveries,
    round(
		100.0 * sum( 
					case
						when d.on_time_flag = 'true'
                        then 1
                        else 0
					end) / nullif( count(d.load_id), 0)
                    , 2) as on_time_percentage
	from loads l
    join trips t
		on l.load_id = t.load_id
	left join (
				select 
						load_id,
                        max( 
							case
								when event_type = 'Delivery'
                                then on_time_flag
							end ) as on_time_flag
				from delivery_events
                group by load_id ) d
			on l.load_id = d.load_id
            where l.load_date >= '2022-01-01'
				and l.load_date <= '2025-01-01'
			group by l.route_id
            order by on_time_percentage asc;

# Investigating Facilities with the longest dwell time
SELECT
    d.facility_id,
    f.facility_name,
    COUNT(*) AS delivery_count,
    ROUND(AVG(d.detention_minutes), 2) AS avg_detention_minutes,
    MAX(d.detention_minutes) AS max_detention_minutes,
    ROUND(
        100.0 * SUM(
            CASE WHEN d.on_time_flag = 'True' THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS on_time_percentage
FROM delivery_events d
JOIN facilities f
    ON d.facility_id = f.facility_id
WHERE d.event_type = 'Delivery'
GROUP BY
    d.facility_id,
    f.facility_name
ORDER BY avg_detention_minutes DESC;

# fuel efficiency and fuel expenditure analysis
SELECT
    YEAR(purchase_date) AS reporting_year,
    COUNT(*) AS fuel_transactions,
    ROUND(SUM(gallons), 2) AS total_gallons,
    ROUND(SUM(total_cost), 2) AS total_fuel_cost,
    ROUND(
        SUM(total_cost) / NULLIF(SUM(gallons), 0),
        3
    ) AS cost_per_gallon
FROM fuel_purchases
WHERE purchase_date >= '2022-01-01'
  AND purchase_date < '2025-01-01'
GROUP BY YEAR(purchase_date)
ORDER BY reporting_year;

# Calculating annual fleetfuel efficiency
SELECT
    YEAR(dispatch_date) AS reporting_year,
    COUNT(*) AS total_trips,
    SUM(actual_distance_miles) AS total_miles,
    ROUND(SUM(fuel_gallons_used), 2) AS total_gallons,
    ROUND(
        SUM(actual_distance_miles) /
        NULLIF(SUM(fuel_gallons_used), 0),
        3
    ) AS fleet_mpg
FROM trips
WHERE dispatch_date >= '2022-01-01'
  AND dispatch_date < '2025-01-01'
GROUP BY YEAR(dispatch_date)
ORDER BY reporting_year;

# Truck maintenance costs and downtime analysis
SELECT
    truck_id,
    COUNT(*) AS maintenance_events,
    ROUND(SUM(total_cost), 2) AS total_maintenance_cost,
    ROUND(AVG(total_cost), 2) AS average_maintenance_cost
FROM maintenance_records
WHERE maintenance_date >= '2022-01-01'
  AND maintenance_date < '2025-01-01'
GROUP BY truck_id
ORDER BY total_maintenance_cost DESC
LIMIT 10;