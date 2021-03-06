USE [ALERT_F]
GO
/****** Object:  StoredProcedure [dbo].[wwwSetActive]    Script Date: 06/04/2013 12:50:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[wwwSetActive]
@id int,
@active int	
as
BEGIN TRY
BEGIN TRAN
if @active != 0
update wwwUser set active=0 where id = @id
else
update wwwUser set active=1 where id = @id

select @id as id
COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	DECLARE @ErrorMessage NVARCHAR(4000);	
	SELECT @ErrorMessage = 'Error in wwwSetActive: '+ ERROR_MESSAGE()
	RAISERROR (@ErrorMessage, -- Message text.
               16, -- Severity.
               1 -- State.
               );
END CATCH

GO
GRANT EXECUTE ON [dbo].[wwwSetActive] TO [pod] AS [dbo]
GO