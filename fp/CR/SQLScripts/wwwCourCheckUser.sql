USE [ALERT_F]
GO
/****** Object:  StoredProcedure [dbo].[wwwCourCheckUser]    Script Date: 11/21/2012 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[wwwCourCheckUser] 
	@user varchar(20), @password varchar(10)
as

declare @user_ varchar(20), @password_ varchar(10)
set @user_=@user
set @password_=@password

select u.FirstName, u.SecondName, u.id
from CouriersTemp u	
where u.MobileLogin=@user_ 
and u.MobilePassword COLLATE Cyrillic_General_CS_AS = @password_ COLLATE Cyrillic_General_CS_AS
--and u.Fired is null

--if @@ROWCOUNT=1 insert [Log] ([user], [PKName]) values (@user_, @ip)


