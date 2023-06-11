WITH cte as (
select distinct 
    s.StudentID,
    s.StudentNameInternal as 'Student',
    s.StudentYearLevelDescription,
    s.StudentSurname,
    p.LastHouseDescription,
    r.Relationship
    -- r.RecipientDefaultEmail,
from vStudents s inner join vStudentContactsAndRelations r on s.StudentID=r.StudentID
                left join vPastStudentAddress p on r.RecipientID=p.ID
where s.CurrentSemesterOnlyFlag=1
        and s.StudentYearLevel = 6
        -- and s.StudentYearLevel=4
        -- and r.Relationship in ('Mother','Aunt','Grandmother','Sister','Great Grandmother','Cousin','Step Sister','Daughter')
        and r.Relationship in ('Mother','Aunt','Grandmother','Great Grandmother', 'Sister')
--        and r.RecipientID in 
--            ( SELECT
--                c.ID
--            FROM Constituencies c
--            where c.ConstitCode = '@SP')
)
SELECT * from cte
--seg_table as (
--select
--cte.[Grammarian ID]
--,   cte.[Grammarian Relation First Name]
--,   cte.[Grammarian Relation Last Name]
--,   cte.[Grammarian Relation Title]
--,   cte.Relationship
--,   cte.StudentID
--FROM cte
--where cte.Relationship = 'Mother'
--
--UNION
--
--select
--cte.[Grammarian ID]
--,   cte.[Grammarian Relation First Name]
--,   cte.[Grammarian Relation Last Name]
--,   cte.[Grammarian Relation Title]
--,   cte.Relationship
--,   cte.StudentID
--FROM cte
--    LEFT JOIN vCommunityAddresses c on c.ID = cte.[Grammarian ID]
--where cte.Relationship <> 'Mother'
--
--
--)
--SELECT distinct seg_table.* 
--,   c.DefaultEmail
--,   c.HomeAddressComma
--,   DENSE_RANK() OVER (order by AddressID) as 'Legacy Family Number'
--from seg_table
--    LEFT JOIN vCommunityAddresses c on c.ID = seg_table.[Grammarian ID]
--WHERE c.DeceasedFlag <> 1
--
--order by [Legacy Family Number]
-- SELECT top 10 * from Relationships
-- SELECT COUNT(*) from PastStudentContacts
