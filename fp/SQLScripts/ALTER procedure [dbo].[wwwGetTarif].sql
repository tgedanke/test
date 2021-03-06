USE [ALERT_F]
GO
/****** Object:  StoredProcedure [dbo].[wwwGetTarif]    Script Date: 12/17/2014 17:01:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[wwwGetTarif] 
	@code varchar(5), @wt float, @frmid int = 4
as
--select @code = 'CEE', @wt = 10.5
declare @cRate float

select top 1 @cRate = C1 from RATES
order by DateOfRate desc

declare @frmLoc varchar(50)
select @frmLoc = LOC from frm where Idx = @frmid

if @code <> @frmLoc --'MOW'
	begin
	select code=@code, wt=@wt, del=ISNULL(delST, delEX), price=dbo.RoundMoney(@cRate*dbo.Tarif(@code, @wt, 'ST', PlanNo, firmid))
	--, @cRate, dbo.Tarif(@code, @wt, 'ST', PlanNo, firmid) 
	from RaidPlan
	where firmid = @frmid and PlanNo = 1 and DEST = @code
	end
else
	begin
	Select code=@code, wt=@wt, del='1', price= dbo.RoundMoney( @cRate* (Rate + (CEILING(( @wt - Before_KG )/ For_Kg) ) * Add_Rate)  )
	 from incity
	 where loc = @frmLoc AND SRV='ICR'
	end
