USE [ALERT_F]
GO
/****** Object:  StoredProcedure [dbo].[wwwSetPOD]    Script Date: 04/09/2013 09:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[wwwSetPOD]
	@wb_no varchar(50), @p_d_in datetime, @tdd datetime, @rcpn varchar(50), @user varchar(50)=null
as

BEGIN TRY
BEGIN TRAN

set @rcpn = LTRIM( RTRIM(@rcpn) )
if (ISDATE(@p_d_in)=0) or (ISDATE(@tdd)=0) or (@rcpn='')
	begin
	RAISERROR ('Неверный формат данных', -- Message text.
               16, -- Severity.
               1 -- State.
               );
    return
	end

update Main
set DOD = @p_d_in,
	P_D_IN = CONVERT(varchar(20), GETDATE(), 112),
	P_D_IN_HOW=1,
	TDD = @tdd,
	User_TDD = ISNULL(@user, User_TDD),
	RCPN = @rcpn
where Wb_No = @wb_no

select @wb_no as wb_no

COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	DECLARE @ErrorMessage NVARCHAR(4000);	
	SELECT @ErrorMessage = 'Error in wwwSetPOD: '+ ERROR_MESSAGE()
	RAISERROR (@ErrorMessage, -- Message text.
               16, -- Severity.
               1 -- State.
               );
END CATCH
