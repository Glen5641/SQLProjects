--This code creates and populates the tables for Group Project 2

DROP TABLE student;
DROP TABLE contest;
DROP TABLE participated;
DROP TABLE author;
DROP TABLE problem;
DROP TABLE scored;
DROP TABLE contest_problems;

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

SELECT * FROM author
SELECT * FROM problem
