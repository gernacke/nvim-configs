SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[usp_StuProjEOYStudents]  
-- 24/03/2023: Changed Future Status from using SynergyMeaning to using FutureStatus
AS  
    DECLARE 
        @cy int = YEAR(GETDATE()),
        @cs int = 1;

    SELECT @cy = FileYear, @cs = FileSemester FROM FileSemesters WHERE SystemCurrentFlag = 1;

    with cte as (
        -- 'FIN' future students starting in current year
        SELECT
            f.FutureID as 'StudentID'
            ,   f.FutureYearLevel as 'YearLevel'
            ,   f.FutureGender as 'Gender'
            ,   f.FutureStatus as 'Status'
        FROM vFutureStudents f
            INNER JOIN Community c on c.ID = f.FutureID
        WHERE f.FutureStatus = 'FIN'
            and f.FutureEnrolYear = @cy

        UNION

        -- All current year students
        SELECT
            s.ID as 'StudentID'
            ,   s.StudentYearLevel 'YearLevel'
            ,   c.Gender
            ,   s.StudentStatus
        FROM vStudentsAll s
            INNER JOIN Community c on c.ID = s.ID
        WHERE s.FileYear = @cy and s.FileSemester = @cs
        -- WHERE s.FileYear = 2023 and s.FileSemester = 1
            and s.StudentStatusSynergyMeaning in ('NEW', 'NORMAL', 'REPEATING', 'LEAVING', 'LEFT')

        UNION

        -- Retrieve the past students of the current year
        SELECT
            p.ID
        ,   p.LastYearLevel as 'YearLevel'
        ,   c.Gender
        ,   'Past'
        FROM PastStudents p
            INNER JOIN Community c on c.ID = p.ID
        WHERE YEAR(p.LeftDate) = @cy
 
        UNION

        -- All current students who are leaving next year
        SELECT
            s.ID
            ,   s.StudentYearLevel
            ,   c.Gender
            ,   s.StudentStatus
        FROM vStudentsAll s
            INNER JOIN Community c on c.ID = s.ID
        WHERE s.FileYear = @cy and s.FileSemester = @cs
        -- WHERE s.FileYear = 2023 and s.FileSemester = 1
            and s.StudentStatusSynergyMeaning in ('LEAVING')
            and YEAR(s.StudentLeavingDate) > @cy

        UNION

        -- All 'LOA' students who are returning this current year
        SELECT
            s.ID
            ,   s.StudentYearLevel
            ,   c.Gender
            ,   s.StudentStatus
        FROM vStudentsAll s
            INNER JOIN Community c on c.ID = s.ID
        WHERE s.FileYear = @cy and s.FileSemester = @cs
        -- WHERE s.FileYear = 2023 and s.FileSemester = 1
            and s.StudentStatusSynergyMeaning in ('LOA')
            and YEAR(s.StudentReturningDate) = @cy
    ),
        count_table as (
            SELECT
                cte.YearLevel
                -- ,   count(p.id) as 'count'
                ,   ROUND(COUNT(cte.StudentID), 0) as 'StudentCount'
                ,  ROUND(SUM(case cte.Gender when 'F' then 1 else 0 end), 0) as 'Girls'
                ,  ROUND(SUM(case cte.Gender when 'M' then 1 else 0 end), 0) as 'Boys'
                -- , c.Gender
            FROM cte
            GROUP BY cte.YearLevel
        )
    
    SELECT
       l.Code
       ,   l.YearLevelSort
       ,   ISNULL(count_table.[StudentCount], 0) as 'Total Numbers'
       ,   ISNULL(count_table.[Girls], 0) as 'Female Numbers'
       ,   ISNULL(count_table.[Boys], 0)  as 'Male Numbers'
    from luYearLevel l
        LEFT JOIN count_table on l.Code = count_table.YearLevel
    ORDER BY l.YearLevelSort

GO
