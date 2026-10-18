# Checking for missing identifiers in loads
select
	count(*) as total_rows,
    Sum(
		case 
			when load_id is null or trim(load_id) = ''
            then 1
            else 0
		end
	) as missing_load_ids
from loads;

# We have now established that loads has no duplicates, nulls or missing identifiers

# Validating the trip to load relationship
select
	count(*) as total_trips,
    sum(
		case
			when t.load_id is null or trim(t.load_id) = ''
            then 1
            else 0
		end 
	) as missing_load_ids,
sum(
	case 
		when t.load_id is not null 
			and trim(t.load_id) <> ''
            and l.load_id is null
		then 1
        else 0
	end 
	) as unmatched_load_ids
from trips t
left join loads l
	on t.load_id = l.load_id;

# Successfully established that every trip has a ref load_id and every load_id is in loads

# validating if every loads ref's a customer_id that exists in customers
select
	count(*) as total_loads,
    sum(
		case
			when l.customer_id is null
				or trim(l.customer_id) = ''
			then 1
            else 0
		end
	) as missing_customer_ids,
    sum(
		case
			when l.customer_id is not null 
				and trim(l.customer_id) <> ''
                and c.customer_id is null
			then 1
            else 0
		end
	) as unmatched_customer_ids
from loads l
left join customers c
	on l.customer_id = c.customer_id;

# Chckimg if every load ref's a route_id that exists in Routes
select
	count(*) as total_loads,
    sum(
		case
			when l.route_id is null
				or trim(l.route_id) = ''
			then 1
            else 0
		end
	) as missing_route_ids,
    sum(
    case
		when l.route_id is not null
			and trim(l.route_id) <> ''
            and r.route_id is null
		then 1
        else 0
	end
) as unmatched_route_ids
from loads l
left join routes r
	on l.route_id = r.route_id;
    
# Checking missing load dates
select
	count(*) as total_loads,
    sum(
		case
			when load_date is null then 1
            else 0
		end
	) as missing_load_dates
from loads;

# Confirming date range covered by table
select
	min(load_date) as earliest_load_date,
    max(load_date) as latest_load_date
from loads;

# Validating the financial figures
select
	count(*) as total_loads,
    sum(
		case
			when revenue is null
            then 1
            else 0
		end
	) as missing_revenue,
    sum(
		case
			when revenue < 0
            then 1
            else 0
		end
	) as negative_revenue,
    sum(
		case
			when fuel_surcharge is null
            then 1
            else 0
		end
	) as missing_fuel_surcharge,
    sum(
		case
			when accessorial_charges is null
            then 1
            else 0
		end
	) as missing_accessorial_charges
    from loads;
    
    # Checking for negative fuel_surcharges or accessorial_charges
    select
		sum(
			case 
				when fuel_surcharge < 0 
                then 1
                else 0
			end
		) as negative_fuel_surcharges,
        sum(
			case
				when accessorial_charges < 0
                then 1
                else 0
			end
		) as negative_accessorial_charges
	from loads;
    
    # validate load statuses
    select load_status,
		count(*) as number_of_loads
	from loads
    group by load_status
    order by number_of_loads desc;
    
    # Validating load weight and pieces
    select
		count(*) as total_loads,
        sum(
			case
				when weight_lbs is null
                then 1
                else 0
			end
		) as missing_weights,
        sum(
			case
				when weight_lbs <= 0
                then 1
                else 0
			end
		) as invalid_weights,
        sum(
			case
				when pieces is null
                then 1
                else 0
			end
		) as missing_pieces,
        sum( 
			case
				when pieces <= 0
                then 1
                else 0
			end
		) as invalid_pieces
	from loads;
    
    # Validating if booking types are consistent
    select booking_type,
     count(*) as number_of_loads
	from loads
    group by booking_type
    order by number_of_loads desc;