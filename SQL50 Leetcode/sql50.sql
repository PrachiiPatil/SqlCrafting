/*
SELECT queries
*/

/* 1757. Recyclable and Low Fat Products */
SELECT product_id FROM Products WHERE low_fats = 'Y' AND recyclable = 'Y';

/* 584. Find Customer Referee */
SELECT name FROM Customer WHERE referee_id != 2 OR referee_id IS NULL;

/* 595. Big Countries */
SELECT name, population, area FROM World WHERE area >= 3000000 OR population >= 25000000;

/* 1148. Article Views I */
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY author_id;

/* 1683. Invalid Tweets */
SELECT tweet_id FROM Tweets WHERE length(content) > 15;

/*
BASIC JOINS
*/

/* 1378. Replace Employee ID With The Unique Identifier */
SELECT EmployeeUNI.unique_id, Employees.name FROM Employees LEFT JOIN  EmployeeUNI ON EmployeeUNI.id = Employees.id;

/* 1068. Product Sales Analysis I */
SELECT Product.product_name,  Sales.year, Sales.price FROM Sales LEFT JOIN Product ON Product.product_id = Sales.product_id;

/* 1581. Customer Who Visited but Did Not Make Any Transactions */
SELECT v.customer_id, COUNT(v.visit_id) AS count_no_trans FROM Visits v LEFT JOIN Transactions t ON v.visit_id = t.visit_id WHERE t.visit_id IS NULL GROUP BY v.customer_id;

/* 197. Rising Temperature */
SELECT w1.id FROM Weather w1 INNER JOIN Weather w2 ON datediff(w1.recordDate,w2.recordDate)=1 WHERE w1.temperature > w2.temperature;

/* 1661. Average Time of Process per Machine */
SELECT a1.machine_id, round(avg(a2.timestamp - a1.timestamp),3) AS processing_time FROM Activity a1 INNER JOIN Activity a2 ON a1.machine_id = a2.machine_id AND a1.process_id = a2.process_id AND a1.activity_type = 'start' AND a2.activity_type = 'end' GROUP BY a1.machine_id;

/* 577. Employee Bonus */
SELECT e.name, b.bonus FROM Employee e LEFT JOIN Bonus b ON e.empId = b.empId WHERE ifnull(b.bonus,0) < 1000;

/* 1280. Students and Examinations */
sELECT s.student_id, s.student_name, su.subject_name, ifnull(COUNT(e.subject_name),0) AS attended_exams
FROM Students s
CROSS JOIN Subjects su
LEFT JOIN Examinations e
ON su.subject_name = e.subject_name
AND s.student_id = e.student_id
GROUP BY s.student_id, su.subject_name
ORDER BY s.student_id, su.subject_name;

/* 570. Managers with at Least 5 Direct Reports */
SELECT e1.name FROM Employee e1 JOIN Employee e2 ON e2.managerId = e1.id GROUP BY e2.managerId HAVING COUNT(e2.managerId) >= 5;

/* 1934. Confirmation Rate */
/* SELECT s.user_id, round(COUNT(c.action) / COUNT(c.user_id),2) AS confirmation_rate FROM Signups s LEFT JOIN Confirmations c ON s.user_id = c.user_id GROUP BY c.user_id HAVING c.action = 'confirmed'; */
SELECT s.user_id, round(ifnull(sum(c.action = 'confirmed')/COUNT(*), 0),2) AS confirmation_rate FROM Signups s LEFT JOIN Confirmations c ON s.user_id = c.user_id GROUP BY s.user_id;
