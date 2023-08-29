use lb;

create table Reserves
(Boat_id int,
Sid int,
Day Varchar(20)
);

select * from Reserves;
alter table Reserves add constraint foreign key (Sid) references Sailor(Sid);

insert into Reserves
values(2,2,'2003-04-12'),
(3,3,'2023-03-09');
-- (2,2,'Tu-- esday'),
-- (3,3,'Friday');

delete from Reserves where Sid=1;

alter table Reserves add column time int;
alter table Reserves modify Day  Date not null;
alter table Reserves drop column time;

delete from Reserves where Sid=2;
