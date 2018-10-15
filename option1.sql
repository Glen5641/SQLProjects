--Drop previously made procedure
DROP PROCEDURE op1Func;

GO
CREATE PROCEDURE op1Func
    @pid INT,
    @pname VARCHAR(20),
    @aid INT
AS
    BEGIN


        --Declare a new max and an additive number
        DECLARE @new_max_score int;
        DECLARE @num numeric(5,2);

        --Find avg of max scores of problems and round the number
        SET @num = (SELECT AVG(max_score) FROM problem WHERE aid = @aid);
        SET @new_max_score = ROUND(@num, 0);

        --Find avg from the author's problems
        SET @num = (SELECT AVG(problem.max_score) FROM problem);

        --Set the new max to correct value
        SET @new_max_score = @new_max_score + ROUND(.1*@num, 0);
        
        --Insert the new problem into the database
        INSERT INTO problem 
        (pid, pname, max_score, aid)
        VALUES
            (@pid, @pname, @new_max_score, @aid);
    END
GO