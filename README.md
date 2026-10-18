# Logistics Operations & Fleet Performance Analytics

**SQL | MySQL | Power BI | DAX | Power Query | Logistics Analytics**

## Project Overview

This portfolio project analyses logistics operations and fleet performance across a three-year reporting period, from January 2022 to December 2024.

Using MySQL for data validation and analysis and Power BI for visualisation, the project investigates delivery reliability, route performance, facility detention, revenue efficiency, fuel expenditure, vehicle maintenance, and fleet utilisation.

The objective is to translate operational data into actionable insights that can help logistics managers identify service-delivery challenges, evaluate asset performance, and make more informed decisions.

## Business Problem

How can a logistics operation improve service reliability and asset efficiency while maintaining revenue performance?

To investigate this question, the project examines relationships between delivery performance, facility detention, route-level outcomes, fuel expenditure, maintenance costs, and fleet utilisation.

## Tools & Technologies

* **MySQL:** Data validation, SQL queries, aggregations, and analytical investigation.
* **Power BI:** Interactive dashboards and performance reporting.
* **DAX:** Measures and calculated columns for key performance indicators.
* **Power Query:** Data preparation and transformation.
* **Microsoft Word:** Project documentation and reporting.

## Dataset Overview

The project uses multiple related datasets covering:

* Loads and trips
* Delivery events
* Customers, routes, and facilities
* Fuel purchases
* Trucks, trailers, and drivers
* Maintenance records
* Driver performance metrics
* Truck utilisation metrics
* Safety incidents

The dataset contains more than 85,000 loads and trips, approximately 196,000 fuel-purchase records, and additional operational records covering the 2022–2024 reporting period.

## Key Findings

### 1. Delivery Reliability

Overall on-time delivery performance was **44.61%**, indicating a significant service-reliability challenge in the dataset.

The finding supports further investigation into scheduling, route planning, facility processes, and other potential contributors to late deliveries.

### 2. Facility Detention

Average delivery detention was approximately **106.60 minutes**.

Some facilities recorded higher average detention than others. However, lower detention did not consistently correspond to better on-time delivery performance, suggesting that detention should be assessed alongside other operational factors.

### 3. Revenue Efficiency

Revenue per mile was approximately **2.44** across the reporting period.

Route-level results varied, with the highest observed revenue per mile at 3.62 and the lowest at 1.70. These differences can help identify routes for further commercial and operational investigation.

Revenue per mile is a revenue-efficiency measure, not a profit measure.

### 4. Fuel Expenditure

Recorded fuel expenditure decreased from approximately 34.35 million in 2022 to 30.08 million in 2024, a reduction of around 12.4%.

Over the same period, recorded fuel consumption increased slightly, while average expenditure per gallon decreased. This suggests that lower recorded fuel prices were the main contributor to the reduction in expenditure.

### 5. Fleet Performance

Average fleet fuel efficiency remained relatively stable at approximately 6.44–6.45 miles per gallon.

The project also compares trucks with the highest recorded maintenance costs against those with the highest average utilisation rates. This comparison identifies vehicles for further investigation; it does not establish that utilisation caused maintenance costs.

## Power BI Dashboards

### Page 1: Executive Overview

Provides a high-level view of revenue, loads, mileage, revenue per mile, on-time delivery, and average detention. It also presents monthly revenue trends, booking-type distribution, and delivery timeliness.

### Page 2: Service & Route Performance

Examines on-time delivery performance by route, average detention by facility, and revenue per mile by route to highlight areas requiring further operational investigation.

### Page 3: Fleet Performance

Focuses on monthly fuel expenditure, trucks with the highest maintenance costs, and trucks with the highest average utilisation rates.

The comparison supports further investigation into asset efficiency and maintenance requirements.

## Recommendations

Based on the findings, the following actions are recommended:

1. **Investigate late deliveries:** Review scheduling, route planning, delivery windows, and other potential contributors to poor service reliability.
2. **Review high-detention facilities:** Investigate loading and unloading processes, waiting times, appointment scheduling, and facility-level operational constraints.
3. **Evaluate route-level revenue efficiency:** Investigate differences in revenue per mile alongside mileage, service requirements, and operating costs before making route decisions.
4. **Monitor fuel expenditure:** Track fuel prices, consumption, and fuel efficiency separately to distinguish price-driven savings from operational improvements.
5. **Review high-maintenance vehicles:** Compare maintenance costs with vehicle age, mileage, utilisation, and downtime before making replacement or maintenance-planning decisions.
6. **Improve data quality:** Investigate missing vehicle and driver identifiers and review utilisation records exceeding 100% before relying on these fields for operational decisions.

## Data Quality & Limitations

The analysis identified several limitations that should be considered when interpreting the results:

* Some trip records have missing driver, truck, or trailer identifiers.
* Some truck utilisation records exceed 100%, requiring further validation.
* The recorded detention values include a maximum of 239 minutes across facilities, which may reflect a data cap or dataset-generation feature.
* The reporting period is January 2022 to December 2024. Some related records extend into early January 2025 and are outside the core reporting window.
* The available data does not include all operating costs required to calculate true profitability.
* Observed relationships between operational metrics should not be interpreted as proof of causation.

## Project Deliverables

* **[Project Report](report/Logistics_Operations_Fleet_Analytics_Report.pdf)** — Methodology, data quality assessment, findings, recommendations, and limitations.
* **[Power BI Dashboard Files](powerbi/)** — Power BI report file.
* **[SQL Analysis](sql/)** — SQL queries used in the project.
* **[Dashboard Screenshots](screenshots/)** — Visual previews of the three dashboard pages.

## Conclusion

This project demonstrates the use of SQL and Power BI to investigate logistics performance, evaluate operational metrics, and communicate findings through dashboards and structured reporting.

It highlights the importance of combining data analysis with data-quality checks, business context, and practical recommendations to support evidence-based decision-making in logistics and supply chain management.
