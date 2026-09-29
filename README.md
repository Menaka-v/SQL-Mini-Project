# SQL-Mini-Project
# Hotel Booking SQL Analysis

## Project Overview

The Hotel Booking SQL Analysis project was carried out to understand the hotel industry, customer behaviour and booking patterns. It aims to help people interested in entering the hotel industry understand historical booking trends. It can also be useful for existing hotels to identify factors associated with cancellations and explore possible solutions to improve operational efficiency and profitability.

## Dataset

The dataset used for this project is the **Hotel Booking Demand dataset**, obtained from Kaggle.

* **Source:** [Hotel Booking Demand – Kaggle](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand)
* **Total records:** 119,390 bookings
* **Total columns:** 32
* **Scheduled arrival period:** July 2015 to August 2017
* **Hotel types:** City Hotel and Resort Hotel

The complete dataset was imported from a CSV file into MySQL for analysis.

The dataset contains details about reservations, cancellations, stay durations, customer types, room preferences, deposit types and other booking-related information. Most of these columns were used to understand customer behaviour, relationships between booking characteristics and factors associated with cancellations.

Some columns contain missing values, particularly `company`, `agent` and `children`. Country names are represented using three-letter country codes. The dataset also includes reservation status dates, which indicate when a reservation's final status was recorded.

## Dataset Attribution

Dataset: Hotel Booking Demand
Kaggle publisher: Jesse Mostipak
Source: https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand
License: Creative Commons Attribution 4.0 International (CC BY 4.0)
https://creativecommons.org/licenses/by/4.0/

The dataset is used for educational and portfolio purposes. The original dataset has not been modified.

## Tools and Skills

This project was completed using **MySQL Workbench 8.0**.

The SQL concepts used include:

* DDL and data import commands
* Filtering, grouping and sorting
* Aggregate functions
* `CASE` statements
* Date functions
* Subqueries and nested queries
* Percentage calculations
* Window functions, including `ROW_NUMBER()` and `PARTITION BY`

## Business Questions and KPIs

The key performance indicators used in this analysis are:

1. Total number of bookings
2. Cancellation rate
3. Average booking lead time
4. Average stay duration, combining weekday and weekend nights
5. Top-performing market segment based on total booked nights
6. Most preferred room type when reserving

The business questions are divided into five categories:

* Cancellation Analysis
* Booking / Reservation Analysis
* Stay Analysis
* Customer Analysis
* Relationship / Pattern Analysis

The complete SQL queries for these analyses are available in the SQL file in this repository.

## Key Findings

### 1. Cancellation patterns across hotel types

Among the two hotel types, City Hotels have a higher cancellation percentage compared to Resort Hotels.

This indicates that cancellation patterns differ between the two hotel types and may require different approaches to managing reservations.

### 2. Deposit types and cancellations

The type of deposit appears to have a relationship with booking cancellations.

The No Deposit category has the highest number of cancellations. However, it is also the most preferred deposit type among customers.

Since this deposit type accounts for a large number of bookings, having the highest cancellation count does not necessarily mean it has the highest cancellation rate. Further comparison of cancellation percentages across deposit types would provide a clearer understanding of this relationship.

### 3. Monthly cancellation patterns

There appear to be some recurring patterns in the months when cancellations are recorded.

In the available data, October and January appeared among the months with the highest cancellation counts in different years.

However, the dataset does not contain complete data for every year. Therefore, further investigation is needed before concluding that these months consistently experience the highest cancellations.

### 4. Scheduled arrivals by day of the week

The number of scheduled arrivals is almost evenly distributed across the days of the week.

Monday has the highest percentage of scheduled arrivals among non-cancelled bookings, while the other days show only slight differences.

This suggests that no single weekday dominates the scheduled arrival distribution.

### 5. Customer types and stay duration

Contract customers have the highest average stay duration compared to other customer types.

However, Transient customers contribute the highest number of bookings.

Longer stays by Contract customers may contribute more occupied room nights per booking, although their actual revenue contribution would require further analysis of room rates and other factors.

### 6. Countries contributing the most bookings

Portugal has the highest number of bookings among the countries represented in the dataset.

It contributes a substantial share of the total bookings, making it an important market in this dataset.

However, the number of bookings does not necessarily represent the number of unique customers, as a customer may make multiple reservations.

### 7. Repeated guests

Approximately 3% of bookings are classified as bookings from repeated guests, while the remaining bookings are classified as first-time guests.

This shows that repeated-guest bookings represent a relatively small proportion of the dataset.

Further information about individual customers would be needed to measure actual customer retention more accurately.

### 8. Monthly booking patterns across different years

There does not appear to be a clearly consistent monthly booking pattern across the available years.

Some months perform better in particular years, but the same pattern is not consistently repeated.

Since the beginning and ending years contain only partial data, this observation is limited to the available months and years.

### 9. Relationship between lead time and cancellation

One of the key findings of this analysis is the relationship between booking lead time and cancellation.

Bookings with shorter lead times generally have lower cancellation percentages. As lead time increases, the cancellation percentage also tends to increase.

This suggests that customers who book further in advance may be more likely to cancel their reservations.

However, this relationship does not establish that longer lead time directly causes cancellations. Other factors, such as changes in travel plans, deposit policies and customer types, may also influence cancellation behaviour.

### 10. Special requests and cancellation

The number of special requests also appears to have a relationship with cancellation.

As the number of special requests increases, the cancellation percentage generally decreases.

However, this is not strong evidence that making more special requests directly reduces cancellations. Bookings with many special requests may be less common, and other customer characteristics could influence this relationship.

Further analysis would be required to understand the reasons behind this pattern.

## Recommendations

### 1. Managing cancellations associated with longer lead times

Since longer booking lead times are associated with higher cancellation percentages, hotel management could explore ways to reduce cancellations among customers who book well in advance.

Hotels could introduce quarterly offers, suitable booking packages or promotional incentives that encourage customers to make reservations closer to their intended arrival dates.

For customers who prefer booking early, hotels could consider reservation reminders, flexible rescheduling options or incentives for keeping their bookings.

Management could also compare cancellation behaviour across different lead-time groups before making changes to pricing or cancellation policies.

### 2. Understanding the needs of Contract customers

Since Contract customers have the highest average stay duration, hotels could investigate the reasons behind their longer stays.

Management could analyse what types of customers fall under this category, their booking purposes and the services they require.

Based on this information, hotels could introduce suitable long-stay packages or additional services to attract similar customers and encourage repeat bookings.

Further analysis of room rates and actual revenue would help determine the financial value of these longer stays.

### 3. Investigating months with higher cancellations

October and January appeared among the months with high cancellation counts in the available data.

Hotel management could investigate the reasons behind these monthly cancellation patterns.

They could examine whether seasonal demand, booking lead times, customer types or deposit policies are associated with higher cancellations during these periods.

Based on the findings, hotels could introduce suitable promotional offers, reservation reminders or revised booking policies to help reduce avoidable cancellations.

## Conclusion

This project helped me understand hotel booking patterns, customer behaviour, stay preferences and factors associated with cancellations.

The analysis identified relationships between cancellation and booking characteristics such as lead time, deposit type and special requests. It also provided insights into customer types, stay durations and monthly booking patterns.

These findings may help existing hotels identify areas for further investigation and support people interested in understanding the hotel industry.

With additional supporting data, including customer feedback, cancellation reasons and more detailed revenue information, hotels could make more informed decisions to improve customer retention, operational efficiency and profitability.

**Project limitations:** The dataset contains historical records, incomplete years and missing values in some columns. The relationships identified in this analysis do not necessarily establish the causes of customer cancellations.
