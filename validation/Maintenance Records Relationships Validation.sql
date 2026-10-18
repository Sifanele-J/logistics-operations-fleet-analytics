# Checking for unique maintenance ids in maintenance records
select
	count(*) as total_records,
    count(distinct maintenance_id) as unique_maintenance_ids,
    count(*) - count(distinct maintenance_id) as duplicate_maintenance_ids
from maintenance_records;

# Checking missing fields
select
	sum( 
		case
			when truck_id is null
				or trim(truck_id)
			then 1
            else 0
		end
	) as missing_truck_ids,
    sum( 
		case
			when maintenance_date is null
				or trim(maintenance_date) = ''
			then 1
            else 0
		end
	) missing_maintenance_dates,
    sum(
		case
			when total_cost is null
				or trim(total_cost) = ''
			then 1
            else 0
		end
	) as missing_total_costs
from maintenance_records;

# Checking trucks referenced in maintenance match trucks
select
	count(*) as total_records,
	sum(
		case
			when t.truck_id is null
				or trim(t.truck_id) = ''
			then 1
            else 0
		end
	) as unmatched_truck_ids
from maintenance_records as m
left join trucks as t
	on m.truck_id = t.truck_id;