#Data types
/*
Integer:
	int
	decimal:
		double
		fixed point
String:
	The CHAR and VARCHAR
	The BINARY and VARBINARY
	Text, blob(long binary data)
	
Date and Time:




*/

#1. Integer
/*
Data types
tinyint, smallint, mediumint, int/integer, bigint
1	   2	     3 		4	      8

特点；
默认有符号，若需要无符号，需要添加unsigned符号
超出范围，out of range value，并插入临界值
如果不设置长度，会有默认长度

ZEROFIll:
*/

#case1: unsigned

CREATE TABLE tab_int(
	t1 INT
);
DESC tab_int;
SELECT * FROM tab_int;
INSERT INTO tab_int VALUES(-123456);

DROP TABLE IF EXISTS tab_int;

CREATE TABLE tab_int2(
	t1 INT(7) ZEROFILL,
	t2 INT UNSIGNED
);
INSERT INTO tab_int2 VALUES(123, 123);

DROP TABLE IF EXISTS tab_int2;
SELECT * FROM tab_int2;


#2. Decimal
#浮点型：
#float (M,D)
#double (M,D)
#定点型：
#decimal/dec (M,D)
/*
特点：
1. M和D
	M：整数部位加小数部位总长度
	D：小数部位
如果超过则插入临界值

2. m和d都可以省略
	其中decimal默认M为10，D为0
	如果是float或double，则会根据插入的数值精度来就决定精度
	
3. 定点型的精度比较高，如果要求插入数值的精度较高如货币运算等，则考虑定点型

*/

CREATE TABLE tab_float(
	f1 FLOAT(5,2),
	f2 DOUBLE(5,2),
	f3 DECIMAL(5,2)
);

INSERT INTO tab_float VALUES(123.15,45.123,123.5);

SELECT * FROM tab_float;

#Principle
/*
所选择的类型越简单越好，能保存数值的类型越小越好
*/

#3.String
/*
较短的文本：
char （固定长度的字符） （比较费空间，效率高）
char （M）：M：最多字符数（a，中  都是一个字符）char的m可以不写，默认为1
varchar （可变长度的字符）（比较节省空间，效率低）varchar的m不可以省略

较长的文本：

text
blob

其他：

binary 和 varbinary
enum用于保存枚举
set 用于保存集合


*/


#4.ENUM

CREATE TABLE tab_enum(
	c1 ENUM('a','b','c')
);

INSERT INTO tab_enum('a');
INSERT INTO tab_enum('d');



#5.set
CREATE TABLE tab_set(
	c1 ENUM('a','b','c','d')
);

INSERT INTO tab_enum('a','b');

#6. 日期型;

/*
只保存日期date
只保存时间time
只保存年 year


		字节		范围		时区等影响
datetime	8		1000-9999	不受
timestamp	4		1970-2038	受


*/

CREATE TABLE tab_date(
	t1 DATETIME,
	t2 TIMESTAMP
);

INSERT INTO tab_date VALUES (NOW(),NOW());

SELECT * FROM tab_date;

SHOW VARIABLES LIKE 'time_zone';

SET time_zone='+9:00';


