-- ProblemSet 1, November 14,2017
-- Submission by r.elizabeth.ranjit@accenture.com 

/*1. List full details of all hotels. */

select * from hotel;

/*Record Count: 6 */

/*2. List full details of all hotels in New York. */

select * from hotel where city='New York';

/*Record Count: 2*/

/*3. List the names and cities of all guests, ordered according to their cities.*/

select name,city from guest group by city,name;

/*Record Count: 6*/

/*4. List all details for non-smoking rooms in ascending order of price.*/

select * from room where type='N' order by price;

/*Record Count: 8*/

/*5. List the number of hotels there are.*/

select count(*) from hotel;

/*Record Count: 1*/

/*6. List the cities in which guests live. Each city should be listed only once.*/

select city from guest group by city;

/*Record Count: 4*/

/*7. List the average price of a room.*/

select avg(price) from room;

/*Record Count: 1*/

/*8. List hotel names, their room numbers, and the type of that room.*/

select name,room_no,type from hotel inner join room on hotel.hotel_no=room.hotel_no;

/*Record Count: 12*/

/*9. List the hotel names, booking dates, and room numbers for all hotels in New York.*/

select hotel.name,booking.room_no,booking.date_from,booking.date_to from hotel inner join booking on hotel.hotel_no=booking.hotel_no where hotel.city='New York';

/*Record Count: 3*/

/*10.  What is the number of bookings that started in the month of September?*/

select count(date_from) from booking where extract(month from date_from)=09;

/*Record Count: 1*/

/*11.  List the names and cities of guests who began a stay in New York in August.*/

select s.name,s.city from (select b.hotel_no,g.name,g.city from guest g inner join booking b on g.guest_no=b.guest_no where extract(month from date_from)=08) s 
join hotel h on s.hotel_no=h.hotel_no where h.city='New York';

/*Record Count: 2*/

/*12.  List the hotel names and room numbers of any hotel rooms that have not been booked.*/

select h.name,t.room_no from hotel h inner join (select room_no,hotel_no from room where room_no NOT IN(SELECT room_no from booking)) t on h.hotel_no=t.hotel_no;

/*Record Count: 5*/

/*13.  List the hotel name and city of the hotel with the highest priced room.*/

select name,city from hotel inner join room on hotel.hotel_no=room.hotel_no where price>=(select max(price) from room);

/*Record Count: 1*/

/*14.  List hotel names, room numbers, cities, and prices for hotels that have rooms with prices lower than the lowest priced room in a Boston hotel.*/

select name,room_no,city,price from hotel inner join room on hotel.hotel_no=room.hotel_no where price<(select min(price) from room inner join hotel on hotel.hotel_no=room.hotel_no where city='Boston');

/*Record Count: 2*/

/*15.  List the average price of a room grouped by city.*/

select city,avg(price) from room inner join hotel on room.hotel_no=hotel.hotel_no group by city;

/*Record Count: 3*/