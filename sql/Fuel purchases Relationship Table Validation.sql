# validating fuel purchase costs and quantities
select
	sum(
		case
			when gallons is null
				or trim(gallons) = ''
			then 1
            else 0
		end
	) as missing_gallons,
    sum(
		case
			when gallons <= 0
            then 1
            else 0
		end
	) as nonpositive_gallons,
    sum(
		case
			when total_cost is null
				or trim(total_cost) = ''
			then 1
            else 0
		end
	) as missing_costs,
    sum(
		case
			when total_cost < 0 
            then 1
            else 0
		end
	) as negative_total_cost
from fuel_purchases;

# Checking the fuel purchases date range
select
	min(purchase_date) as earliest_purchase_date,
    max(purchase_date) as latest_purchase_date
from fuel_purchases;

SELECT
    MIN(purchase_date) AS earliest_purchase,
    MAX(purchase_date) AS latest_purchase,
    COUNT(*) AS total_purchases,
    SUM(CASE
        WHEN purchase_date IS NULL THEN 1
        ELSE 0
    END) AS missing_purchase_dates
FROM fuel_purchases;

# Validating fuel costs and consumption
SELECT
    COUNT(*) AS total_records,

    SUM(CASE
        WHEN gallons IS NULL OR gallons <= 0
        THEN 1 ELSE 0
    END) AS invalid_gallons,

    SUM(CASE
        WHEN total_cost IS NULL OR total_cost < 0
        THEN 1 ELSE 0
    END) AS invalid_total_cost

FROM fuel_purchases;