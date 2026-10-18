# Check for duplicate facility ids
select
	count(*) as total_facilities,
    count(distinct facility_id) as unique_facility_id,
    count(*) - count(distinct facility_id) as duplicate_facility_ids
from facilities;