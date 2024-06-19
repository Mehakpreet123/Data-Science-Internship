-- Data Query Language -> DQL statements are used for performing queries on the data within schema objects. The purpose of the DQL Command is to get some schema relation based on the query passed to it.
/*
DQL statements are used for performing queries on the data within schema objects.
The purpose of the DQL Command is to get some schema relation based on the query passed to it.
*/

-- SELECT -> It is used to retrieve data from the database
use employee_db;
select * from employee_details;
-- we can use where clause with select to filter specific data
select * from employee_details where id =2;

/*
MySQL has many built-in functions.
This reference contains string, numeric, date, and some advanced functions in MySQL.
*/
select * from customers;

-- STRING FUNCTIONS

-- ABS -> Returns the ASCII value for the specific character
SELECT ASCII(FirstName) AS NumCodeOfFirstChar
FROM Customers;
-- CHAR_LENGTH -> 	Returns the length of a string (in characters)
SELECT CHAR_LENGTH("HELLO") AS LengthOfString;
-- CONCAT -- Adds two or more strings
SELECT CONCAT("Learning", "is ", "fun!") AS Concatenated_string;
-- FIND_IN_SET --> 	Returns the position of a string within a list of strings
SELECT FIND_IN_SET("q", "s,q,l");
-- Format the number as "#,###,###.##" (and round with two decimal places):
SELECT FORMAT(250500.5634, 2);
-- INSTR Returns the position of the first occurrence of a string in another string
SELECT INSTR("123hello", "3") AS MatchPosition;
-- LCASE	Converts a string to lower-case (LOWER)
SELECT LCASE("SQL learNiNg");
-- LEFT	Extracts a number of characters from a string (starting from left)
SELECT LEFT("SQL Tutorial", 3) AS ExtractString;
-- LENGTH	Returns the length of a string (in bytes)
SELECT LENGTH("SQL Tutorial") AS LengthOfString;
-- LOCATE	Returns the position of the first occurrence of a substring in a string
SELECT LOCATE("3", "hell3ooo") AS MatchPosition;
-- LPAD	Left-pads a string with another string, to a certain length
SELECT LPAD("SQL Tutorial", 20, "ABC");
-- LTRIM	Removes leading spaces from a string
SELECT LTRIM("     SQL Tutorial") AS LeftTrimmedString;
-- MID	Extracts a substring from a string (starting at any position)
SELECT MID("SQL Tutorial", 5, 3) AS ExtractString;
-- POSITION	Returns the position of the first occurrence of a substring in a string
SELECT POSITION("3" IN "123456") AS MatchPosition;
-- REPEAT	Repeats a string as many times as specified
SELECT REPEAT("SQL Tutorial", 3);
-- REPLACE	Replaces all occurrences of a substring within a string, with a new substring
SELECT REPLACE("SQL Tutorial", "SQL", "HTML");
-- 	Reverses a string and returns the result
SELECT REVERSE("SQL Tutorial");
-- RIGHT	Extracts a number of characters from a string (starting from right)
SELECT RIGHT("SQL Tutorial is cool", 4) AS ExtractString;
-- RPAD	Right-pads a string with another string, to a certain length
SELECT RPAD("SQL Tutorial", 20, "ABC");
-- RTRIM	Removes trailing spaces from a string
SELECT RTRIM("SQL Tutorial     ") AS RightTrimmedString;
-- SPACE	Returns a string of the specified number of space characters
SELECT SPACE(10);
-- STRCMP	Compares two strings
SELECT STRCMP("SQL Tutorial", "SQL Tutorial");
-- SUBSTR	Extracts a substring from a string (starting at any position)
SELECT SUBSTR("SQL Tutorial", 5, 3) AS ExtractString;
-- TRIM	Removes leading and trailing spaces from a string
SELECT TRIM('    SQL Tutorial    ') AS TrimmedString;
-- UCASE /UPPER onverts a string to upper-case
SELECT UCASE("SQL Tutorial is FUN!");

-- NUMERIC FUNCTIONS
-- ABS	Returns the absolute value of a number
SELECT(ABS(234.684);
-- AVG	Returns the average value of an expression
SELECT AVG(Price) AS AveragePrice FROM Products;
-- CEIL	Returns the smallest integer value that is >= to a number
SELECT CEIL(25.75);

-- COUNT	Returns the number of records returned by a select query
SELECT COUNT(ProductID) AS NumberOfProducts FROM Products;
-- DEGREES	Converts a value in radians to degrees

-- DIV	Used for integer division
SELECT 10 DIV 5;
-- EXP	Returns e raised to the power of a specified number
SELECT EXP(1);
-- FLOOR	Returns the largest integer value that is <= to a number
SELECT FLOOR(25.75);
-- GREATEST	Returns the greatest value of the list of arguments
SELECT GREATEST(3, 12, 34, 8, 25);
-- LEAST	Returns the smallest value of the list of arguments
SELECT LEAST(3, 12, 34, 8, 25);
-- LN	Returns the natural logarithm of a number
SELECT LN(2);
-- LOG	Returns the natural logarithm of a number, or the logarithm of a number to a specified base
SELECT LOG(2);
-- MAX/min	Returns the maximum/minimum value in a set of values
SELECT MIN(Price) AS SmallestPrice FROM Products;
-- MOD	Returns the remainder of a number divided by another number
SELECT MOD(18, 4);
-- PI	Returns the value of PI
SELECT PI();
-- POW / POWER	Returns the value of a number raised to the power of another number
SELECT POW(4, 2);
-- RADIANS	Converts a degree value into radians
SELECT RADIANS(180);
-- RAND	Returns a random number
SELECT RAND();
-- ROUND	Rounds a number to a specified number of decimal places
SELECT ROUND(135.375, 2);
-- SIGN	Returns the sign of a number
SELECT SIGN(255.5);
-- SIN	Returns the sine of a number
SELECT SIN(2);
-- SQRT	Returns the square root of a number
SELECT SQRT(64);
-- SUM	Calculates the sum of a set of values
SELECT SUM(Quantity) AS TotalItemsOrdered FROM OrderDetails;

-- DATE TIME FUNCTIONS

-- ADDDATE	Adds a time/date interval to a date and then returns the date
SELECT ADDDATE("2017-06-15", INTERVAL 10 DAY);-- ADDTIME	Adds a time interval to a time/datetime and then returns the time/datetime
-- CURDATE	Returns the current date
SELECT CURDATE();
-- ADDTIME	Adds a time interval to a time/datetime and then returns the time/datetime
SELECT ADDTIME("2017-06-15 09:34:21", "2");
-- CURRENT_DATE	Returns the current date
SELECT CURRENT_DATE();
-- CURRENT_TIME	Returns the current time
SELECT CURRENT_TIME();
-- CURRENT_TIMESTAMP	Returns the current date and time
SELECT CURRENT_TIMESTAMP();
-- DATE	Extracts the date part from a datetime expression
SELECT DATE("2017-06-15");
-- DATEDIFF	Returns the number of days between two date values
SELECT DATEDIFF("2017-06-25", "2017-06-15");
-- DATE_FORMAT	Formats a date
SELECT DATE_FORMAT("2017-06-15", "%Y");
-- DAY	Returns the day of the month for a given date
SELECT DAY("2017-06-15");
-- DAYNAME	Returns the weekday name for a given date
SELECT DAYNAME("2017-06-15");
-- DAYOFMONTH	Returns the day of the month for a given date
SELECT DAYOFMONTH("2017-06-15");
-- DAYOFWEEK	Returns the weekday index for a given date
SELECT DAYOFWEEK("2017-06-15");
-- DAYOFYEAR	Returns the day of the year for a given date
SELECT DAYOFYEAR("2017-06-15");
-- EXTRACT	Extracts a part from a given date
SELECT EXTRACT(MONTH FROM "2017-06-15");
-- NOW	Returns the current date and time
SELECT NOW();

-- SPECIAL FUNCTIONS
-- CASE	Goes through conditions and return a value when the first condition is met
SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN "The quantity is greater than 30"
    WHEN Quantity = 30 THEN "The quantity is 30"
    ELSE "The quantity is under 30"
END
FROM OrderDetails;

SELECT IF(500<1000, "YES", "NO");

SELECT ISNULL(NULL); -- RETURNS 0 OR 1
