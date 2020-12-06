#进阶2
/*
语法：
	select 
		查询列表
	from
		表名
	where 
		筛选条件;
		
分类：
	1. 按条件表达式筛选
	条件运算符：>   <    =   !=   <>(两个都是不等于)   >=   <=  
	
	2. 按逻辑表达式筛选：
	逻辑运算符：
		&&  ||  ！
		and  or  not
		
	3. 模糊查询：
		like
		between and
		in
		is null
		
*/

#1. 按条件表达式筛选：
#案例1：查询工资 >12000的员工信息：

SELECT 
	*
FROM 
	employees
WHERE 
	salary>12000;

#案例2：查询部门编号不等于90号的员工名和部门编号

SELECT
	first_name, last_name, department_id
FROM
	employees
WHERE 
	department_id <>90; 

#2. 按逻辑表达式筛选

#案例一：工资在10000到20000之间的员工名、工资以及奖金

SELECT
	first_name, salary, `commission_pct`
FROM 
	employees
WHERE 
	salary >= 10000 
AND 
	salary <= 20000;

#案例二：部门编号不是在90-110之间，或者工资高于15000的员工信息
SELECT
	*
FROM
	employees
WHERE
	NOT (department_id >=90 AND department_id<=100) OR salary >15000;
	
#3. 模糊查询：

#3.1 like
#case1：查询员工名中包含字符a的员工信息：%通配符：表示任意多的字符，但是%%不能代表null
SELECT 
	*
FROM 
	employees
WHERE
	last_name LIKE '%a%';
	
#case2：查询员工名中第三个字符为n，第五个字符为l的员工名和工资：
SELECT 
	last_name,
	salary
FROM
	employees
WHERE
	last_name LIKE '__n_l%';

#case3:查询员工名中第二个字符为下划线_的员工 last_name LIKE '_\_%' 其中\表示转义
#	或者last_name LIKE '_$_%' ESCAPE'$'；其中escape后面可以是任意字符
SELECT 
	last_name,
	salary
FROM
	employees
WHERE
	last_name LIKE '_$_%' ESCAPE'$';
	
#3.2 between and 包含临界值，而且临界值不能交换顺序，大于等于左边，小于等于右边

#case1: 查询员工编号在100-120之间的员工信息
SELECT
	*
FROM 
	employees
WHERE 
	employee_id BETWEEN 100 AND 120;

#3.3 in 提高简洁度。
#case:查询员工的工种编号是 IT_PROG AD_VP AD_PRES中的一个员工名和工种编号
SELECT
	last_name,
	job_id
FROM
	employees
WHERE 
	job_id IN ('IT_PROG','AD_VP','AD_PRES');
	

#3.4 is null
#case：查询没有奖金的员工名和奖金率

SELECT 
	last_name,
	commission_pct
FROM 	
	employees
WHERE
	commission_pct IS NULL;

#case：查询有奖金的员工名和奖金率

SELECT 
	last_name,
	commission_pct
FROM 	
	employees
WHERE
	commission_pct IS NOT NULL;

#安全等于 <=>
#case：查询没有奖金的员工名和奖金率

SELECT 
	last_name,
	commission_pct
FROM 	
	employees
WHERE
	commission_pct <=> NULL;

#case2:查询工资为12000的员工信息
SELECT
	*
FROM
	employees
WHERE 
	salary <=> 12000;
	
/*总结：
IS NULL	仅仅可以判断null值，可读性较高，建议使用
<=> 	既可以判断null，也可以判断其他值
*/