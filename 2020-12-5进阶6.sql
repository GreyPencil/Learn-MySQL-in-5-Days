#作业
#查询90号部门员工的job_id和90号部门的location_id
SELECT job_id, location_id
FROM employees e, departments d
WHERE e.`department_id`=d.`department_id`
AND d.department_id=90;

#选择所有有奖金的员工的 Last_name, department_name, location_id, city
SELECT last_name, department_name, l.location_id, city
FROM departments d, employees e, locations l
WHERE e.`department_id`=d.`department_id`
AND d.`location_id`=l.`location_id`
AND e.`commission_pct` IS NOT NULL;

#查询每个工种、每个部门的部门名、工种名和最低工资
SELECT j.job_id, department_name, job_title, MIN(salary)
FROM jobs j, employees e, departments d
WHERE j.`job_id`=e.`job_id`
AND e.`department_id`=d.`department_id`
GROUP BY d.department_name,job_title;

#查询每个国家下的部门个数大于2的国家编号：
SELECT COUNT(*), country_id
FROM locations l, departments d
WHERE l.`location_id`=d.`location_id`
GROUP BY l.`country_id`
HAVING COUNT(*)>2;

#选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号

SELECT e.last_name AS 'employees', e.employee_id AS 'Emp\#', m.last_name AS 'manager', m.employee_id AS 'Mgr\#'
FROM employees e, employees m
WHERE e.manager_id = m.employee_id
AND e.last_name = 'Kochhar';

#二。sql99的语法
/*
语法：
	select 查询列表
	from 表1 别名 【连接类型】
	join 表2 别名 
	on 连接条件
	【where 筛选条件】
	【group by 分组】
	【having 筛选条件】
	【order by 排序列表】
	
内连接（❤）：inner
外连接
	左外（❤）：left 【outer】
	右外（❤）：right【outer】
	全外：ful 【outer】
交叉连接：cross
*/

#一）内连接
/*
语法：
	select 查询列表
	from 表1 别名 【连接类型】
	inner join 表2 别名 
	on 连接条件
	【where 筛选条件】
	【group by 分组】
	【having 筛选条件】
	【order by 排序列表】
	
	
分类：等值、非等值、自连接

特点：
添加排序、分组、筛选
inner可以省略
筛选条件放在where后面，连接条件放在on后面，提高分离性，便于阅读
inner join连接和92中的连接效果一致
*/

#1.等值连接
#案例：查询员工名、部门名

SELECT last_name, department_name
FROM employees e
INNER JOIN departments d
ON e.`department_id`=d.`department_id`;

#2.添加筛选
#案例：查询名字中包含e的员工名和工种名

SELECT last_name, job_title
FROM employees e
INNER JOIN jobs
ON e.`job_id`=jobs.`job_id`
WHERE e.`last_name` LIKE '%e%';

#3.添加分组和筛选
#案例：查询部门个数大于三的城市名和部门个数

SELECT COUNT(*), city
FROM departments d
INNER JOIN locations l
ON d.`location_id`=l.`location_id`
GROUP BY l.`city`
HAVING COUNT(*)>3;

#4.添加排序
#案例：哪个部门的员工个数大于三的部门名和员工个数，并按个数降序

SELECT COUNT(*) 员工个数, department_name
FROM departments d
INNER JOIN employees e
ON e.`department_id`=d.`department_id`
GROUP BY d.`department_id`
HAVING COUNT(*)>3
ORDER BY COUNT(*) DESC; 

#5.三表连接：查询员工名，部门名，工种名，并按部门名降序

SELECT last_name, department_name, job_title
FROM employees e 
INNER JOIN departments d ON e.`department_id`=d.`department_id`
INNER JOIN jobs j ON e.`job_id`=j.`job_id`
ORDER BY department_name DESC;


#二）非等值连接

#查询员工的工资级别
SELECT salary, grade_level
FROM employees e
JOIN job_grades g
ON e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`;

#查询每个工资级别>2的个数，并且排序
SELECT COUNT(*), grade_level
FROM employees e
JOIN job_grades g
ON e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`
GROUP BY g.`grade_level`
HAVING COUNT(*)>2
ORDER BY COUNT(*);

#三）自连接
#员工名字，上级名字

SELECT e.last_name, m.last_name
FROM employees e
JOIN employees m
ON e.`manager_id`=m.`employee_id`;


#二：外连接

/*
应用场景：用于查询一个表中有，一个表中没有的记录
特点：
1. 外连接的查询结果为主表中的所有记录
	如果从表中有和它匹配的，则显示匹配值
	如没有，则显示null
	外连接查询结果=内连接结果+主表中有而从表中没有的记录
2. 左外连接：left join 左边的是主表
   右外连接：right join 右边的是主表
3. 左外和右外交换两个表的顺序，可以实现同样的效果
4. 全外连接=内连接的结果+表1中有单表2中没有的+表2中有但表1中没有的（mysql不支持）
*/

#引入：查询蓝盆友不在男神表的女神

SELECT b.name, bo.*
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id`=bo.`id`
WHERE bo.`id` IS NULL;

#案例：查询哪个部门没有员工
SELECT d.*, e.employee_id
FROM departments d
LEFT OUTER JOIN employees e
ON e.`department_id`=d.`department_id`
WHERE employee_id IS NULL;

SELECT d.*, e.employee_id
FROM employees e
RIGHT OUTER JOIN departments d
ON e.`department_id`=d.`department_id`
WHERE employee_id IS NULL;

#全外连接
 USE girls
SELECT b.*,bo.*
FROM beauty b
FULL OUTER JOIN boys bo
ON b.boyfriend_id = bo.id; 

#交叉连接 99连接标准实现笛卡尔乘积

SELECT b.*, bo.*
FROM beauty b
CROSS JOIN boys bo;

/*
sql92  vs  sql99

功能：sql99支持的较多
可读性：sql实现连接条件和筛选条件的分离，可读性较高
*/

#习题：
#1. 查询编号>3的女神的蓝朋友信息，如有则列出详细，如没有，用null填充

SELECT b.*, bo.*
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id`=bo.`id`
WHERE b.`id`>3;



#2. 查询哪个城市没有部门

USE myemployees;
SELECT city, department_id
FROM locations l
LEFT OUTER JOIN departments d
ON d.location_id=l.location_id
WHERE department_id IS NULL;

#3. 查询部门名为SAL或IT的员工信息

SELECT department_name, e.*
FROM departments d
LEFT OUTER JOIN employees e
ON e.`department_id` = d.`department_id`
WHERE d.`department_name` IN ('SAL','IT');













