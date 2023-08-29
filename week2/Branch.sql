use lb;
create table Branch(branch_name int,branch_city varchar(20),assets varchar(20));

select * from Branch;

alter table Branch add primary key(branch_name);
alter table Branch add column Empno int;

alter table Branch add constraint
foreign key (Empno) references employee(Empno);

alter table Branch modify assets varchar(35);

alter table Branch add column partnership varchar(20);
alter table Branch drop column partnership;

insert into Branch
values(1,'Chittoor','Rubber',2),
(2,'Vellore','Cotton',3);

update Branch
set branch_name=3
where branch_name=2;

alter table Branch drop column branch_name;
alter table Branch drop column branch_city;

SHOW COLUMNS FROM Branch;
