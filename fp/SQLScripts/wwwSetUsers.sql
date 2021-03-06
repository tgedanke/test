USE [ALERT_F]
GO
/****** Object:  StoredProcedure [dbo].[wwwSetUsers]    Script Date: 06/04/2013 09:44:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[wwwSetUsers]
@id int,
@auser varchar(50),
@pass varchar(50),
@agentID int	
as
BEGIN TRY
BEGIN TRAN
if @id != 0
Update wwwUser set aUser = @auser, aPassword = @pass, active = 1, agentID = @agentID
where id = @id
else
insert wwwUser (aUser, aPassword, active, agentID) values (@auser, @pass, 1, @agentID)

select @id as id

COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	DECLARE @ErrorMessage NVARCHAR(4000);	
	SELECT @ErrorMessage = 'Error in wwwSetUsers: '+ ERROR_MESSAGE()
	RAISERROR (@ErrorMessage, -- Message text.
               16, -- Severity.
               1 -- State.
               );
END CATCH

GO
GRANT EXECUTE ON [dbo].[wwwSetUsers] TO [pod] AS [dbo]
GO