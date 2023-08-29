start transaction;
use lb;

create table Sailor
(Sid int,
Sname Varchar(20),
Rating Varchar(20),
Age int);

select * from Sailor;
insert into Sailor
values(1,'Ravi','A',28),
(2,'Mohan','A',40);

insert into Sailor
VALUES (3, 'Bob', 'C', 28);

savepoint a;

insert into Sailor
values(4,'Avd','B',45);

rollback to savepoint a;

insert into Sailor
values(5,'Ava','c',45);

alter table Sailor add primary key(Sid);

insert into Sailor
values(5,'Raj','A',38);

delete from Sailor 
where Rating='B';

update Sailor
set Age=44 where Rating='c';

insert into Sailor
values(6,'Raja','A',null);
