create schema edu
create table employees(empid int identity (1,1) primary key, name varchar(50), salary decimal(10,2))
insert into employees 
values ('azizbek', 1000)
select * from employees
insert into employees ( name, salary)
select 'bekzod' , 1110

insert into employees 
select 'odil', 900

update employees 
set salary=7000
where empid=1

delete  from employees 
where empid=2

--delete- jadvaldagi ma`lumotlarni o`chirish uchun ishlatiladi. Boshqalaridan farqi jadvaldagi qatorlar  o`chadi lekin jadvalni o`zi qoladi, nisbatan sekinroq ishlaydi va ma`lumotlarni qayta tiklash mumkin bo`ladi.
--drop-jadvalni o`zini umumiy o`chirish uchun ishlatiladi undagi ma`lumotlar va jadvalni o`zi butunlay o`chib ketadi. qayta tiklash imkonsiz
--truncate-jadvaldagi ma`lumotlarni o`chirish uchun ishlatiladi. shart qo`yib bo`lmaydi, ma`lumotlarni qayta tiklash imkonsiz.

ALTER TABLE employees
ALTER COLUMN name VARCHAR(100);

alter table employees
alter column salary float

create table departments (departid int identity (1,1) primary key, departmentname varchar(50))
select *from departments

truncate  table  employees

insert into departments
select  'bobur'

insert into departments
select 'nodir'

insert into departments
select 'saidbek'

insert into departments
select 'qalandar'

insert into departments
select 'murod'

update employees
set departments='management'
where salary>5000

drop table employees

alter table employees
drop column department

exec sp_rename 'department', 'StaffMembers'

drop table [dbo].[departments]

create table products (productid int primary key, productname varchar(50),category varchar(50),price decimal, productquality varchar(50))


ALTER TABLE Products
ADD CONSTRAINT chk_price_positive CHECK (Price > 0);

exec sp_rename 'products.category', 'productcategory', 'column' 

insert into products values (1, 'kokos', 'meva', 56867, 'yaxshi'), (2,'ananas', 'meva', 68878, 'ajoyib'), (3,'makaron', 'uyxojalikmahsuloti', 6567, 'zor'), (4,'suv', 'ichimlik', 323424, 'yaxshi'), (5,'koylak', 'kiyim', 200000, 'ajoyib');
select * from products
SELECT *
INTO Products_Backup
FROM Products;


exec sp_rename 'products', 'inventory'

alter table inventory
alter column price float

select * from inventory


alter table inventory
add productcode int identity(1000,5)
