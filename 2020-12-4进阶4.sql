#进阶4 常见函数
/*

概念：类似于java的方法，将一组逻辑语句封装在方法体中，对外暴露方法名
好处：1.隐藏了实现细节 2.提高代码的重用性
调用：select 函数名（实参列表）【from 表】；
特点：
	1. 叫什么（函数名）
	2. 干什么（函数功能）
分类：
	1. 单行函数：
	如 concat、length、ifnull等
	2. 分组函数
	功能：做统计使用，又称为统计函数、聚合函数、组函数

*/

#一、字符函数
#1.length
SELECT LENGTH('john'); #4
SELECT LENGTH('张三丰hahaha'); #15 一个汉字三个字节

SHOW VARIABLES LIKE '%char%';

#2. concat拼接字符串
SELECT CONCAT(last_name, '_', first_name) AS 姓名 FROM employees;

#3. upper, lower
SELECT UPPER('john');
SELECT LOWER('JohN');
#函数嵌套函数
SELECT CONCAT(UPPER(last_name), '_', LOWER(first_name)) AS 姓名 FROM employees;

#4. substr, substring
SELECT SUBSTR('李莫愁爱上了陆展元',7) out_put; #陆展元，索引从1开始

SELECT SUBSTR('李莫愁爱上了陆展元',1, 3) out_put; #李莫愁， 索引从1开始，三个字符结束，lenght是字节，其他都是字符

#案例：姓名中首字符大写，其他小写然后用_拼接，显示出来
SELECT CONCAT (UPPER(SUBSTR(last_name,1,1)), '_', LOWER(SUBSTR(last_name,2))) out_put
FROM employees;

#5. instr 返回子串第一次出现的索引，如果找不到返回0

SELECT INSTR('杨不悔爱上了殷梨亭','殷梨亭') AS out_put; #7, 起始索引

#6. trim 去掉前后的空格或者字符
SELECT TRIM ('    张翠山   ') AS out_put;

SELECT TRIM('a' FROM 'aaaaa张aa翠山aaaaa') AS out_put; #张aa翠山

#7. lpad 用指定的字符实现左填充指定长度

SELECT LPAD('殷素素', 10, '*') AS out_put; #*******殷素素
SELECT LPAD('殷素素', 2, '*') AS out_put; #殷素


#8. rpad 用指定的字符实现右填充指定长度
SELECT RPAD('殷素素', 10, 'ab') AS out_put; #殷素素abababa

#9. replace 替换
SELECT REPLACE ('张无忌爱上了周芷若', '周芷若', '赵敏') AS out_put; #全替换，如果有两个周芷若则两个都替换



#二、数学函数

#1.round 四舍五入
SELECT ROUND(1.65); #2
SELECT ROUND(-1.65); #-2
SELECT ROUND(1.644,2);#1.64 保留两位

#2. ceil向上取整
SELECT CEIL(1.25); #2
SELECT CEIL(1.00); #1
SELECT CEIL(-1.1); #-1

#floor 向下取整
SELECT FLOOR(9.9);#9

#truncate 截断
SELECT TRUNCATE (1.69999999,1); #1.6

#mod 取余
/*
mod(a,b)   : a- a/b*b
*/
SELECT MOD(-10,-3); #-1
SELECT 10%3;

#三、日期函数：
#now 返回当前系统时间
SELECT NOW();

#curdate: 返回当前系统日期，不包含时间
SELECT CURDATE();

#curtime 返回当前时间，不包含日期
SELECT CURTIME();

#可以获取指定的部分，年、月、日、小时、分钟、秒
SELECT YEAR(NOW()) 年;
SELECT YEAR('1998-1-1');

SELECT YEAR(hiredate) 年 FROM employees;

SELECT MONTH(NOW()) 月;
SELECT MONTHNAME(NOW()) 月;

#str_to_date 将字符通过指定的格式转换成日期

SELECT STR_TO_DATE('1998-3-2','%Y-%c-%d') AS out_put;

#查询入职日期为1992-4-3的员工信息
SELECT * FROM employees WHERE hiredate = STR_TO_DATE('4-3 1992','%c-%d %Y');

#date_format 将日期转换成字符
SELECT DATE_FORMAT(NOW(),'%y年%m月%d日')AS out_put;

#查询有奖金的员工的入职日期：xx月/xx日  xx年
SELECT last_name, DATE_FORMAT (hiredate, '%m月/%d日  %y年')
FROM employees
WHERE `commission_pct` IS NOT NULL

#四、其他函数：

SELECT VERSION();
SELECT DATABASE();
SELECT USER();

#五、流程控制函数：

#1.if函数： if else效果

SELECT IF(10>5, '大','小');

SELECT last_name, commission_pct, IF(commission_pct IS NULL, '没有奖金','有奖金') 备注
FROM employees;

#2. case函数	使用一：switch case的效果
/*
语法：
case要判断的字段或表达式：
when 常量1 then 要显示的值1或语句1 注意这里没有分号
when 常量2 then 要显示的值2或语句2
。。。
else 要显示的值n或语句n
end
*/

#案例：查询工资，要求：部门号=30，显示的工资为1.1倍
		      #部门号=40，显示的工资为1.2倍
		      #部门号=50，显示的工资为1.3倍
		      #其他部门，显示的是原工资

SELECT salary 原始工资, department_id, 
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END AS 新工资
FROM employees;


#case 使用二：类似于多重if
/*
case
when 条件1 then 要显示的值1或语句1
when 条件2 then 要显示的值2或语句2
。。。
else 要显示的值n或语句n
end

*/

#案例：查询工资情况：
/*
如果工资大于20000，显示A级
如果工资大于15000，显示B级
如果工资大于10000，显示C级
否则显示D级
*/

SELECT last_name,salary,
CASE 
WHEN salary>20000 THEN 'A'
WHEN salary>15000 THEN 'B'
WHEN salary>10000 THEN 'C'
ELSE 'D'
END AS 工资级别
FROM employees;


#case: 视频52
SELECT CONCAT(last_name,' earns ',salary,' monthly, but wants ',salary*3) AS "Dream Salary"
FROM employees
WHERE salary=24000;

SELECT job_id AS job,
CASE job_id
WHEN 'AD_PRES' THEN 'A'
WHEN 'ST_MAN' THEN 'B'
WHEN 'IT_PROG' THEN 'C'
ELSE 'D'
END AS grade
FROM employees;






