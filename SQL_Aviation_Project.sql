-- 1

(select count(FLIGHT_NUMBER) as 'Flights_Count', 
(select round(avg(ARRIVAL_DELAY), 2)from flights where arrival_delay is not null and DAY_OF_WEEK <6)  as 'Avg_arrival_delay', 
(select round(avg(DEPARTURE_DELAY), 2) from flights where DEPARTURE_DELAY is not null and DAY_OF_WEEK <6) as 'Avg_Dept_Delay',
(select count(CANCELLED)from flights where CANCELLED =1 and DAY_OF_WEEK <6) as 'Cancelled_flights'
from flights
where day_of_week < 6 and ARRIVAL_DELAY is not null and DEPARTURE_DELAY is not null) 
union
(select count(FLIGHT_NUMBER) as 'Flights_Count',
(select round(avg(ARRIVAL_DELAY), 2)from flights where arrival_delay is not null and DAY_OF_WEEK >=6)  as 'Avg_arrival_delay', 
(select round(avg(DEPARTURE_DELAY), 2) from flights where DEPARTURE_DELAY is not null and DAY_OF_WEEK >=6) as 'Avg_Dept_Delay',
(select count(CANCELLED)from flights where CANCELLED =1 and DAY_OF_WEEK >=6) as 'Cancelled_flights'
from flights
where day_of_week >=6);


-- 2
select month_, count(CANCELLED) as 'Cancelled flights'
from flights f
join airlines a on a.IATA_CODE = f.AIRLINE
where DAY_= 1 and a.AIRLINE = 'jetblue airways' and cancelled = 1
group by month_;


-- 3
select a.AIRLINE, ar.CITY, round(avg(f.ARRIVAL_DELAY),2) as 'Avg_Arrival_Delay', round(avg(f.DEPARTURE_DELAY),2) as 'Avg_Dept_Delay'
from flights f
left join airlines a on a.IATA_CODE = f.AIRLINE
left join airports ar on ar.IATA_CODE = f.ORIGIN_AIRPORT
where ARRIVAL_DELAY is not null and DEPARTURE_DELAY is not null
group by a.AIRLINE, ar.CITY;

select a.AIRLINE, ar.state, round(avg(f.ARRIVAL_DELAY),2) as 'Avg_Arrival_Delay', round(avg(f.DEPARTURE_DELAY),2) as 'Avg_Dept_Delay'
from flights f
left join airlines a on a.IATA_CODE = f.AIRLINE
left join airports ar on ar.IATA_CODE = f.ORIGIN_AIRPORT
where ARRIVAL_DELAY is not null and DEPARTURE_DELAY is not null
group by a.AIRLINE, ar.STATE;

select a.AIRLINE, ar.CITY, ar.state, week(concat(f.year_, '-', f.month_, '-', f.day_)) as weeknum, round(avg(f.ARRIVAL_DELAY),2) as 'Avg_Arrival_Delay', round(avg(f.DEPARTURE_DELAY),2) as 'Avg_Dept_Delay'
from flights f
left join airlines a on a.IATA_CODE = f.AIRLINE
left join airports ar on ar.IATA_CODE = f.ORIGIN_AIRPORT
where 'weeknum' between 1 and 54
group by a.AIRLINE, ar.CITY, ar.state, weeknum;


-- 4

select a.AIRLINE, count(f.AIRLINE) as 'No_of_Airline'
from flights f
join airlines a on a.IATA_CODE = f.AIRLINE
where ARRIVAL_DELAY<=0 and DEPARTURE_DELAY<=0 and DISTANCE between 2500 and 3000
group by a.AIRLINE;


