#进阶8：分页查询（❤）
/*

应用场景：当要显示的数据，一页显示不全，需要分页提交sql请求
语法&执行顺序：
	7-> select查询列表
	1-> from 表
	2-> 【join typejoin 表2
	3-> on连接条件
	4-> where筛选条件
	5-> group by 分组字段
	6-> having 分组后的筛选
	8-> order by 排序的字段】
	9-> limit offset, size;
	
	offset要显示条目的起始索引（起始索引从0开始）
	size要显示的条目个数
	
特点：
	1. limit语句放在查询语句最后
	2. 公式：
	要显示的页数 page，每页的条目数 size
	
	select 查询列表
	from 表
	limit （page-1）*size， size；

*/

#案例1：查询前五条员工信息

SELECT * FROM employees LIMIT 0,5;
SELECT * FROM employees LIMIT 5;

#案例2：查询第11-25

SELECT * FROM employees LIMIT 10, 15;


#案例3：有奖金的员工信息，工资较高的前十名

SELECT *
FROM employees
WHERE `commission_pct` IS NOT NULL
ORDER BY salary DESC
LIMIT 10;




