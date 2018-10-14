 /* This code creates tables and runs queries for problem 1 in gp3.
 *  
 *  In this problem, we chose author ID in the problem table. 
 *  The table is well queried in the database and the author 
 *  table's Author ID is the attribute used to find the index. 
 *  Author ID in the problem table is secondary and problems 
 *  5,7, and 9 all use the problem.aid so we chose to rerun these 
 *  queries.
 */

DROP TABLE student;
DROP TABLE contest;
DROP TABLE participated;
DROP TABLE author;
DROP TABLE problem;
DROP TABLE scored;
DROP TABLE contest_problems;

CREATE TABLE student (

    login VARCHAR(64) PRIMARY KEY,
    sname VARCHAR(64) NOT NULL,
    university VARCHAR(64) NOT NULL,
    grad_year INT NOT NULL
    
)

INSERT INTO student 
    (login, sname, university, grad_year)
VALUES
    ('stefan', 'Stefan Keller', 'University of Oklahoma', 2020),
    ('cfox', 'Colin Fox', 'Oklahoma State University', 2021),
    ('moerman', 'Fientje Moerman', 'Oklahoma State University', 2019),
    ('grice', 'George Rice', 'Texas A&M University', 2019),
    ('1udaya1', 'Udaya Chandrika', 'Baylor University', 2018),
    ('mightybruce', 'Bruce Yamashita', 'Texas A&M University', 2018),
    ('_ash_', 'Ashley Brzozowicz', 'University of Oklahoma', 2020),
    ('jose1980', 'Jose Monteiro', 'Texas Christian University', 2018);



CREATE TABLE contest (
    cname VARCHAR(64) PRIMARY KEY,
    year INT NOT NULL,
    location VARCHAR(64) NOT NULL
)

INSERT INTO contest 
    (cname, year, location)
VALUES
    ('Week of Code', 2016, 'Norman, OK'),
    ('University Codesprint', 2017, 'College Station, TX'),
    ('Hour Rank', 2018, 'Norman, OK');

CREATE TABLE participated (
    login VARCHAR(64) NOT NULL,
    cname VARCHAR(64) NOT NULL,
    primary key(login, cname)
)

INSERT INTO participated
    (login, cname)
VALUES
    ('1udaya1', 'Week of Code'),
    ('mightybruce', 'Week of Code'),
    ('jose1980', 'Week of Code'),
    ('moerman', 'University Codesprint'),
    ('grice', 'University Codesprint'),
    ('stefan', 'University Codesprint'),
    ('stefan', 'Hour Rank'),
    ('cfox', 'Hour Rank'),
    ('_ash_', 'Hour Rank');

CREATE TABLE author (
    aid INT PRIMARY KEY,
    aname VARCHAR(64) NOT NULL,
    compensation INT NOT NULL
)

INSERT INTO author
    (aid, aname, compensation)
VALUES
    (101, 'Alexander Sforza', 2000),
    (102, 'Rachel Moran', 1500),
    (103, 'David Terans', 2000),
    (104, 'Elizabeth Forster', 2500);

CREATE TABLE problem (
    pid INT PRIMARY KEY,
    pname VARCHAR(64) NOT NULL,
    max_score INT NOT NULL,
    aid INT NOT NULL
)

INSERT INTO problem
    (pid, pname, max_score, aid)
VALUES
    (10, 'Exceeding the Speed Limit', 10, 101),
    (11, 'Array Triplets', 20, 102),
    (12, 'a,b Special Points', 30, 104),
    (13, 'Cube-loving Numbers', 50, 103),
    (14, 'Interesting Trip', 15, 104),
    (15, 'Sword Profit', 20, 103),
    (16, 'Which Section?', 40, 103),
    (17, 'Minute to Win It', 10, 103),
    (18, 'Watson''s Love for Arrays', 30, 102),
    (19, 'Dynamic Trees', 50, 102);

--Created index on aid in Problem table
CREATE INDEX aid_idx
ON problem (aid);

CREATE TABLE scored (
    pid INT,
    login VARCHAR(64),
    score REAL,
    primary key(pid, login)
)

INSERT INTO scored
    (pid, login, score)
VALUES 
    (10, '1udaya1', 10),
    (10, 'mightybruce', 8),
    (10, 'jose1980', 5),
    (11, '1udaya1', 20),
    (11, 'jose1980', 8),
    (12, 'mightybruce', 10),
    (12, 'jose1980', 20),
    (13, 'jose1980', 35),
    (14, 'moerman', 10),
    (14, 'grice', 15),
    (14, 'stefan', 14),
    (15, 'moerman', 19),
    (15, 'stefan', 18),
    (16, 'grice', 33),
    (17, 'stefan', 10),
    (17, '_ash_', 10),
    (17, 'cfox', 9),
    (18, 'stefan', 27),
    (18, '_ash_', 18),
    (19, 'stefan', 41);



CREATE TABLE contest_problems (
    cname VARCHAR(64),
    pid VARCHAR(64),
    primary key(cname, pid)
)

INSERT INTO contest_problems
    (cname, pid)
VALUES
    ('Week of Code', 10),
    ('Week of Code', 11),
    ('Week of Code', 12),
    ('Week of Code', 13),
    ('University Codesprint', 14),
    ('University Codesprint', 15),
    ('University Codesprint', 16),
    ('Hour Rank', 17),
    ('Hour Rank', 18),
    ('Hour Rank', 19);

-- This code runs all queries for Project 2

-- Problem 2.c.1 Display all data
SELECT * FROM student
SELECT * FROM contest
SELECT * FROM participated
SELECT * FROM author
SELECT * FROM problem
SELECT * FROM scored
SELECT * FROM contest_problems

-- Problem 2.c.5
SELECT pname
FROM problem
INNER JOIN author ON problem.aid = author.aid
WHERE aname = 'Rachel Moran' AND
    max_score =(SELECT MAX(problem.max_score) FROM problem);


-- Problem 2.c.7
SELECT cname, SUM(author.compensation) AS comp_sum
FROM (
SELECT cname, problem.pid, aid 
FROM contest_problems 
INNER JOIN problem ON problem.pid = contest_problems.pid ) cproblems 
INNER JOIN author ON author.aid = cproblems.aid
GROUP BY cname


-- Problem 2.c.9
UPDATE author
SET compensation = compensation*1.1 
WHERE author.aid IN (
    SELECT aid
    FROM (
        SELECT problem.pid, problem.aid, problem_avg.avg_score/problem.max_score AS ppercent
        FROM (
            SELECT pid, AVG(score) AS avg_score
            FROM scored 
            GROUP BY pid
        ) problem_avg
        FULL JOIN problem ON problem_avg.pid = problem.pid
    ) ppercentages
    WHERE ppercent > .5 AND ppercent <.75) 

SELECT * FROM author
