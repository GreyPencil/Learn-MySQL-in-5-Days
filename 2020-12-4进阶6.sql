#进阶6：连接查询
/*
含义：多表查询，当查询的字段来自于多个表时，就会用到连接查询

笛卡尔乘机现象：表1 m行，表2 n行，一共m*n行

发生原因：没有有效的连接条件
如何避免：添加有效的连接条件

分类：
	按年代分类：
	sql92标准：仅仅支持内连接
	sql99标准【推荐】：支持内连接+外连接（左外和右外）+交叉连接
	
	按功能分类：
		内连接：
			等值连接
			非等值连接
			自连接
		外连接：
			左外连接
			右外连接
			全外连接
		交叉连接：
	
	
*/
USE girls;
SELECT * FROM beauty;
SELECT * FROM boys;

SELECT NAME, boyname FROM boys, beauty
WHERE beauty.`boyfriend_id`=boys.id;

#一、sql92标准
#1. 等值连接
/*
1. 多表等值连接的结果为多表的交集部分
2. n表连接，至少需要n-1个连接条件
3. 多表连接的顺序没有要求
4. 一般需要为表起别名
5. 可以搭配前面介绍的所有子句使用，比如排序、分组、筛选
*/

#案例：查询女神名和对应的男神名：
SELECT NAME, boyname 
FROM boys, beauty
WHERE beauty.`boyfriend_id`=boys.id;


#案例：查询员工名和对应的部门名
SELECT last_name, department_name
FROM employees, departments
WHERE employees.`department_id`=departments.`department_id`;

#2. 为表起别名 
/*
①提高语句的简洁度
②区分多个重名的字段
③如果使用了别名，就不可以使用原始表名
*/
#查询员工名、工种号、工种名
SELECT last_name, e.job_id, job_title
FROM employees e, jobs 
WHERE e.`job_id`=jobs.`job_id`;

#3. 两个表的顺序是否可以调换？ 可以

#4. 加上筛选

#案例：查询有奖金的员工名、部门名

SELECT last_name, department_name, commission_pct
FROM employees e, departments d
WHERE e.`department_id`=d.`department_id`
AND e.`commission_pct` IS NOT NULL;

#案例：查询城市名中第二个字符为o的部门名和城市名

SELECT department_name, city
FROM departments d, locations l
WHERE d.`location_id`=l.`location_id`
AND l.`city` LIKE '_o%';

#5. 添加分组：
#案例：查询每个城市的部门个数

SELECT COUNT(*), city
FROM departments d, locations l
WHERE d.`location_id` = l.`location_id`
GROUP BY city;

#案例：查询有奖金的每个部门的部门名和部门的领导编号和该部门的最低工资

SELECT MIN(e.`salary`),d.`department_name`,d.`manager_id`
FROM departments d, employees e
WHERE d.`department_id`=e.`department_id`
AND commission_pct IS NOT NULL
GROUP BY department_name;

#6.添加排序

#案例： 查询每个工种的工种名和员工的个数，并且按照员工个数降序

SELECT COUNT(*) 个数, job_title 工种名
FROM employees e, jobs j
WHERE e.`job_id`=j.`job_id`
GROUP BY job_title
ORDER BY 个数 DESC;

#7.三表连接

#案例：查询员工名、部门名和所在的城市

SELECT last_name, department_name, city
FROM employees e, departments d, locations l
WHERE e.`department_id`= d.`department_id`
AND l.`location_id`=d.`location_id`;














