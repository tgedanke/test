USE [ALERT_F]
GO
/****** Object:  StoredProcedure [dbo].[wwwGetAgentslist]    Script Date: 06/05/2013 07:37:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[wwwGetAgentslist]
as
select partcode, partloc, partname, displayname = partname +' ('+partloc+')'  from Partinf
where partname is not null and partname != ''
order by partname

GO
GRANT EXECUTE ON [dbo].[wwwGetAgentslist] TO [pod] AS [dbo]
GO