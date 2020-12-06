#测试：
#1 查询工号为176的员工姓名、部门号和年薪：
SELECT	
	last_name,
	first_name,
	department_id,
	salary*12*(1+ IFNULL(commission_pct,0)) AS 年薪
FROM
	employees
WHERE 	
	employee_id = 176;


DESC departments;

#经典面试：
#select * from employees;
#和select * from employees where commission_pct like '%%' and last_name like '%%';
#是否一样？  不一样，因为%%不能代表null



	