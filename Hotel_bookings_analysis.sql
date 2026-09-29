#Database creation
create database Hotel_booking;
use Hotel_booking;

#Table creation
create table hotel;
desc hotel;

#Data import
SET GLOBAL local_infile = 1;
load data local infile "C:/Users/ELCOT/Downloads/hotel_bookings.csv/hotel_bookings.csv"
into table hotel
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

#Database understanding
select * from hotel;

#KPI Analysis
#1.Total booking
#2.Cancelation to booking ratio
#3.Average lead time
#4.Average stay night (weekday night + weekend night)
#5.Top performing market segment in terms of no.of bookings 
#6.Top preffered room type (when reserving)

desc hotel;

#KPI Summary
select count(*) as 'Total Bookings', 
sum(is_canceled)/count(*)*100 as 'Cancelation Rate %',
avg(lead_time) as 'Average Lead Time',
(select avg(stays_in_week_nights+stays_in_weekend_nights) from hotel
where is_canceled=0) as 'Average stay nights' ,
(select market_segment from hotel
group by market_segment
order by sum(stays_in_week_nights+stays_in_weekend_nights) desc
limit 1) as 'Top performing market segment',
(select reserved_room_type from hotel
group by reserved_room_type
order by count(reserved_room_type) desc
limit 1) as 'Most preffered room type'  #may not be very useful because adhula pattern la ila didirnu l,p la varaduhu i la kano 
from hotel;


#Business Questions

#Cancellation Analysis

#1. What is the of cancellation distribution in each hotel type?

select hotel as 'Hotel type',sum(is_canceled)/count(*)*100 as 'Cancelation distribution%' from hotel
group by hotel
order by sum(is_canceled) desc;

#2.What is the Trend of cancellation over years?

select year(reservation_status_date) as `Year`,count(distinct month(reservation_status_date)) as `Months available`,
count(*) as `Total status recorded`,sum(is_canceled) as `Total cancellations`,
round(sum(is_canceled)/count(*)*100,2) as `Cancellation rate%` from hotel
group by year(reservation_status_date);

#3.What is the rate of Cancellation in different deposit types?

select deposit_type,sum(is_canceled)/(select count(*) from hotel)*100 as `Cancelled bookings %` from hotel
group by deposit_type
order by `Cancelled bookings %`;
 
#4. Which month and year recorded the highest cancellation rate?

select `Year`,`Month`,`No of cancellations` from 
(select year(reservation_status_date) as `Year`,monthname(reservation_status_date) as `Month`,sum(is_canceled) `No of cancellations` ,
row_number() over
 (partition by year(reservation_status_date)
 order by sum(is_canceled) desc ) AS `rn` from hotel
group by year(reservation_status_date),
month(reservation_status_date),
monthname(reservation_status_date)) as `cancellations`
where rn=1
order by `Year` ;

#Booking / Reservation Analysis

#1. Which month has the highest number of bookings/arrivals ?

select arrival_date_month as 'Month with most bookings' ,count(arrival_date_month) as `No.of bookings` from hotel
group by arrival_date_month
order by `No.of bookings` desc
limit 1 ;

#2. What is the ranking of reserved room types from top 5 based on bookings?

select reserved_room_type,count(reserved_room_type) from hotel
group by reserved_room_type 
order by count(reserved_room_type) desc
limit 5; #doubtful

#3. What is the most preferred deposit type when reserving a room?

select deposit_type as 'Most Preffered deposit type' from hotel
group by deposit_type
order by count(deposit_type) desc
limit 1; 

#4. What is the ratio of each reservation status?

select reservation_status as `Reservation status` ,count(*) as 'count',count(*)/(select count(*) from hotel)*100 as 'Percentage' 
from hotel
group by reservation_status;

#5.Are customers actually receiving the room type they reserved?

select case when reserved_room_type=assigned_room_type then 'yes' else 'no'end as 'Received reserved room?',count(*) as 'no.of stays',
count(*)/(select count(*) from hotel where reservation_status='Check-Out')*100 as 'percentage'  from hotel
where is_canceled=0
group by case when reserved_room_type=assigned_room_type then 'yes' else 'no' end;

#Stay Analysis

#1. Top 3 room types has the highest number of stays?

select assigned_room_type as 'Top Assigned rooms',count(assigned_room_type) as 'Count' from hotel
where reservation_status='Check-Out'
group by assigned_room_type
order by count(assigned_room_type) desc
limit 3;

#2.Which day of the week has the highest number of scheduled arrivals?

select dayname(`Arrival Date`) as `Day`,round(count(*)/(select count(*) from hotel where is_canceled=0)*100,2) as `Booking %` from 
(select str_to_date(concat(arrival_date_day_of_month,"-",arrival_date_month,"-",arrival_date_year),'%e-%M-%Y')
as `Arrival Date` from hotel
where is_canceled=0) as Dates
group by `Day`
order by `Booking %` desc;

#3.Which customer type has long stay durations?

select * from hotel;
select customer_type,avg(stays_in_weekend_nights+stays_in_week_nights) as `Average stay duration` from hotel
where reservation_status='Check-Out'
group by customer_type
order by `Average stay duration` desc ;

#Customer Analysis

#1. Which country has the highest number of customers/bookings?

select country,count(country) as 'No.of.bookings' from hotel
group by country
order by count(country) desc
limit 1;

#2. What is the average number of people per stay?

select avg(adults+children+babies) as 'Average people per stay' from hotel
where is_canceled=0;

#3. What percentage of guests are repeated guests compared with one-time guests?

select case when is_repeated_guest=1 then 'Yes' else 'No' end as `Repeated booking?`,count(is_repeated_guest) as 'No.Of bookings',count(is_repeated_guest)/(select count(*) from hotel) *100 as 'Repetition %'  from hotel
group by `Repeated booking?`;

#4. What is the ranking of each customer types?

select customer_type,count(customer_type) as 'No.Of bookings' from hotel
group by customer_type
order by count(customer_type) desc;

#Relationship / Pattern Analysis

#1. Does the hotel experience consistent monthly booking patterns across different years?

select arrival_date_year,arrival_date_month,count(*) as `No of Bookings` from hotel
group by  arrival_date_year,arrival_date_month
order by FIELD(arrival_date_month,
    'January', 'February', 'March', 'April',
    'May', 'June', 'July', 'August',
    'September', 'October', 'November', 'December'),
    arrival_date_year;

#2.Does cancellation rate increase with longer booking lead times?

select case when lead_time<=90 then "0-3 Months"
            when lead_time<=180 then "3-6 Months"
            when lead_time<=270 then "6-9 Months"
            when lead_time<=365 then "9-12 Months"
            when lead_time<=456 then "12-15 Months"
            when lead_time<=547 then "15-18 Months"
            when lead_time<=639 then "18-21 Months"
            when lead_time>=640 then "21-24+ Months"
end as `Lead Time Months`,count(*) as "Total bookings",sum(is_canceled)/count(*)*100 as "Cancellation percentage %"from hotel
group by `Lead Time Months`
order by `Cancellation percentage %` ASC;

#3.Does the number of special requests have a relationship with the cancellation rate?

select total_of_special_requests as `No of special requests`,count(*) as `Total bookings`,
sum(is_canceled) as `Cancelled bookings`,sum(is_canceled)/count(*)*100 as `Cancellation %` from hotel
group by total_of_special_requests
order by total_of_special_requests;
