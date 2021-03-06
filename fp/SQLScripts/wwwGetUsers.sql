USE [ALERT_F]
GO
/****** Object:  StoredProcedure [dbo].[wwwGetUsers]    Script Date: 05/31/2013 14:01:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[wwwGetUsers]
as
select u.id
, u.aUser
, u.active
, p.PartCode as agents
, p.PartName
, p.PartLoc
, c.RusName
, DateShtdn=convert(varchar(30),p.DateShtdn, 104)  
from wwwUser u
left join Partinf p on p.PartCode = u.agentID
left join N_City c on c.Code = p.PartLoc
where u.aUser != 'webadmin'
order by u.aUser

GO
GRANT EXECUTE ON [dbo].[wwwGetUsers] TO [pod] AS [dbo]
GO