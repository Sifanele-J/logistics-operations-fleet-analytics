# Checking for unique event ids in delivery events
select
	count(*) as total_event_ids,
    count(distinct event_id) as unique_event_id,
    count(*) - count(distinct event_id) as duplicate_event_ids
from delivery_events;

# Checking for missing delivery events references
select
	sum(
		case
			when load_id is null
				or trim(load_id) = ''
			then 1
            else 0
		end
	) as missing_load_ids,
    sum(
		case
			when trip_id is null
				or trim(trip_id) = ''
			then 1
            else 0
		end
	) as missing_trip_ids,
    sum(
		case
			when facility_id is null
				or trim(facility_id) = ''
			then 1
            else 0
		end
	) as missing_facility_ids
from delivery_events;

# Validating delivery events references
select
	sum(
		case
			when t.trip_id is null
				or trim(t.trip_id) = ''
			then 1
            else 0
		end
	) as unmatched_trip_ids,
    sum(
		case
			when l.load_id is null
				or trim(l.load_id) = ''
			then 1
            else 0
		end
	) as unmatched_load_ids,
    Sum(
		case
			when f.facility_id is null
				or trim(f.facility_id) = ''
			then 1
            else 0
		end
	) as unmatched_facility_ids
from delivery_events as e
left join trips as t
	on e.trip_id = t.trip_id
left join loads as l
	on e.load_id = l.load_id
left join facilities as f
	on e.facility_id = f.facility_id;

# Validating delivery events
SELECT
    event_type,
    COUNT(*) AS event_count
FROM delivery_events
GROUP BY event_type
ORDER BY event_count DESC;

# Validating delivery event dates
describe delivery_events;

SELECT
    MIN(scheduled_datetime) AS earliest_scheduled,
    MAX(scheduled_datetime) AS latest_scheduled,

    MIN(actual_datetime) AS earliest_actual,
    MAX(actual_datetime) AS latest_actual,

    SUM(CASE
        WHEN scheduled_datetime IS NULL THEN 1
        ELSE 0
    END) AS missing_scheduled_dates,

    SUM(CASE
        WHEN actual_datetime IS NULL THEN 1
        ELSE 0
    END) AS missing_actual_dates

FROM delivery_events;

# Validating on-time delivery flag
SELECT
    on_time_flag,
    COUNT(*) AS event_count
FROM delivery_events
GROUP BY on_time_flag
ORDER BY event_count DESC;

# checking the on-time flag for delivery events only
SELECT
    on_time_flag,
    COUNT(*) AS delivery_events,
    ROUND(COUNT(*) * 100.0 / (
        SELECT COUNT(*)
        FROM delivery_events
        WHERE event_type = 'Delivery'
    ), 2) AS percentage
FROM delivery_events
WHERE event_type = 'Delivery'
GROUP BY on_time_flag
ORDER BY delivery_events DESC;

# Validating detention times
SELECT
    COUNT(*) AS total_events,
    SUM(CASE WHEN detention_minutes IS NULL THEN 1 ELSE 0 END) AS missing_detention,
    SUM(CASE WHEN detention_minutes < 0 THEN 1 ELSE 0 END) AS negative_detention,
    ROUND(AVG(detention_minutes), 2) AS average_detention_minutes,
    MAX(detention_minutes) AS maximum_detention_minutes
FROM delivery_events
WHERE event_type = 'Delivery';