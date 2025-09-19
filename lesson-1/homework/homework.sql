--data -jadvaldagi malumot 
-- database- malumotlar saqlanadigan ombor
-- relational database-bu ma’lumotlarni jadval ko‘rinishida saqlaydigan ma’lumotlar bazasi turi.
-- table-jadval 

-- Sql server ma`lumotlarni jadval shaklida saqlaydi va ular orasidagi bog`lanishlarni kalitlar yordamida tashkil qiladi.
-- Shifrlash, auzentifikatsiya, rollarga asoslangan kirishni nazorat qilish va audit funksiyalri mavjud.
-- Always on availabilty groups, failover clustering va database mirroring kabi texnologiyalar yordamida tizim uzluksiz ishlashni ta`minlaydi
--SSRS,SSIS VA SSAS bilan birga ma`lumotlarni tahlil qilsih va hisobotlar yaratsih imkonini beradi.
--Indekslar, ma`lumotlarni bo`laklarga ajratish, xotira ichida ishlov berish va so`rovlarni optimallashtirish orqali katta hajmdagi ma`lumotlarni tez va samarali boshqaradi.

--ikki xil  aetentifikatsiya mavjud: windows autentifikatsiya va aralash rejim.

create database schooldb

create table students(studentid int primary key, name varchar(50), age int)

--sqlning vazifasi malumotlar bazasi bilan muloqot qilish.
--sql serverning vazifasi ma`lumotlarni saqlash va boshqarish.
--ssmsning vazifasi sql server bilan ishlashni yengillashtirish.

--DQL(data query language)- ma`lumotlar bazasidan ma`lumotlarni so`rab olish vazifasini bajaradi.
--DML(data manipulation language) ma`lumotlarni jadvalga qo`shish, o`zgartirish yoki o`chirish vazifalarini bajaradi.DDL(data definition language)- jadval, ustun, indeks kabi ma`lumotlar tuzilmasini yaratsih yoki o`zgartirsh vazifasini bajaradi.

--DCL(data control language)- foydalanuvchilarga huquqlar berish yoki olib tashlash vazifasini bajaradi.
--TCL(transaction control language)-tranzaksiyalarni boshqarish- ya'ni bir nechta DML buyrug'ini birgalikda bajarish yoki beekor qilish vazifasini bajaradi.


insert into students values (1, 'azizbek', 18), (2, 'bekzod', 20), (3, 'najim', 33)
select * from students
