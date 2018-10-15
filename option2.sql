--Drop previously made procedures
DROP PROCEDURE op2Func;

GO
CREATE PROCEDURE op2Func
    @aid INT
AS
    BEGIN

        --Nest if exists to check cases of count

        IF EXISTS(SELECT Top 1 aid, count(*) as NUM FROM problem WHERE @aid = aid GROUP BY aid ORDER BY NUM DESC)
        BEGIN
            UPDATE author
                SET compensation = compensation*1.2         --If aid count is top 1, give 20% raise
                where @aid = aid;
        END
        ELSE
        BEGIN
            IF EXISTS(SELECT Top 2 aid, count(*) as NUM FROM problem WHERE @aid = aid GROUP BY aid ORDER BY NUM DESC)
            BEGIN
                UPDATE author
                    SET compensation = compensation*1.15         --If aid count is top 2, give 15% raise
                    where @aid = aid;
            END
            ELSE
            BEGIN
                IF EXISTS(SELECT Top 3 aid, count(*) as NUM FROM problem WHERE @aid = aid GROUP BY aid ORDER BY NUM DESC)
                BEGIN
                    UPDATE author
                        SET compensation = compensation*1.1         --If aid count is top 3, give 10% raise
                        where @aid = aid;
                END
                ELSE
                BEGIN
                    UPDATE author
                        SET compensation = compensation*1.05         --give 5% raise default
                        where @aid = aid;
                END
            END
        END
    END
GO
