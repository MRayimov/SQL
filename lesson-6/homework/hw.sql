







SELECT DISTINCT
  CASE WHEN col1 <= col2 THEN col1 ELSE col2 END AS col1,
  CASE WHEN col1 <= col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;




SELECT *
FROM TestMultipleZero
WHERE COALESCE(A,0) + COALESCE(B,0) + COALESCE(C,0) + COALESCE(D,0) <> 0;


select * from section1
where id % 2 <> 0

select top (1) * from section1

select * from section1
where id = (select max(id) from section1)


select * from section1
where name like 'b%'

select * from ProductCodes
where Code like '%\_%' escape '\'
