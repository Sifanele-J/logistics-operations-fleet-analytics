# Validating maintenance costs values
select
	count(*) as total_records,
    sum( 	
		case
			when total_cost < 0 
            then 1
            else 0
		end
	) as negative_costs,
    min(total_cost) as minimum_cost,
    max(total_cost) as maximum_cost,
    round(avg(total_cost), 2) as average_cost
from maintenance_records;

# Checking maintenance dates
select
	min(maintenance_date) as earliest_maintenance_date,
    max(maintenance_date) as latest_maintenance_date
from maintenance_records;