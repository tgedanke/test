USE [ALERT_F]
GO
/****** Object:  StoredProcedure [dbo].[wwwCourGetAll]    Script Date: 11/08/2012 07:27:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[wwwCourGetAll]
	@courId int
as	

declare @actDate datetime
--set @courId = 10231
set @actDate = /*'20120808'--*/CAST('20120808' as date)

if object_id('tempdb..#CourierAll') is not null
drop table #CourierAll

CREATE TABLE #CourierAll(
	aNo [varchar](11) NULL,
	displayNo [varchar](10) NULL,
	aCash [float] NULL,
	aAddress [varchar](70) NULL,
	client [varchar](60) NULL,
	timeB [varchar](5) NULL,
	timeE [varchar](5) NULL,
	tdd [varchar](5) NULL,
	Cont [varchar](100) NULL,
	ContPhone [varchar](50) NULL,
	Packs [int] NULL,
	Wt [float] NULL,
	VolWt [float] NULL,
	Rems [varchar](300) NULL,
	ordStatus [varchar](10) NULL,
	ordType [tinyint] NULL,
	recType [tinyint] NULL -- 0 - заказ, 1 - накладная, 2 - 
	
	)


--заказы
INSERT INTO #CourierAll
select 
  aNo = OrderNo
, displayNo = 'ЗАКАЗ'
, aCash = Amt
, aAddress = [Address]
, client = ISNULL(o.NewCCO, k.c_co)
, timeB = CONVERT(varchar(5), ReadyTime, 108)
, timeE = CONVERT(varchar(5), ReadyTime1, 108)
, null
, [NewName]
, [ContPhone]
, [Packs]
, [RealWt]
, [VolWt]
, [OrdRems]
, case [Status] when 0 then 'Не готов'
		        when 1 then 'Готов'
		        --when 2 then '???'
		        --when 3 then '???'
		        --when 4 then '???'
                end
, [Type]
, 0
from OrdHdr o 
	left join Klient k on o.CACC = k.CACC
where (Ready = @actDate/* or Perenos = @actDate*/)and CourId = @courId
order by [Address], client


--накладные
INSERT INTO #CourierAll 
select
aNo = case when TL.Wb_No = '0' then TL.Wb_No + '(' + cast(TL.PakNo as varchar(50)) + ')' else TL.Wb_No end
, displayNo = case when TL.Wb_No = '0' then TL.Wb_No + '(' + cast(TL.PakNo as varchar(50)) + ')' else TL.Wb_No end
, aCash = m.aCash
, aAddress = m.R_Adr
, client = m.R_Co
, null
, null
, tdd = CONVERT(varchar(5), m.TDD, 108)
, [R_Name]
, [R_Tel]
, [PCS]
, m.Wt
, [Vol_WT]
, [Descr]
, null
, null
, recType = 1
from TransactLog TL
left join Main m on m.Wb_No = TL.Wb_No
where TrTypeId = 2 and DateTransact = @actDate and CourIdTo = @courId  and TL.Wb_No <> '0'
order by m.R_Adr, m.R_Co


INSERT INTO #CourierAll 
select
aNo = case when TL.Wb_No = '0' then TL.Wb_No + '(' + cast(TL.PakNo as varchar(50)) + ')' else TL.Wb_No end
, displayNo = case when TL.Wb_No = '0' then TL.Wb_No + '(' + cast(TL.PakNo as varchar(50)) + ')' else TL.Wb_No end
, null
, aAddress = k.C_Adr
, client = k.C_CO
, null
, null
, null
, k.C_Name
, k.C_Tel
, null
, null
, null
, null
, null
, null
, recType = 2
from TransactLog TL
--left join Main m on m.Wb_No = TL.Wb_No
left join Inv_hdr inv on inv.INV_NO = TL.PakNo
left join Klient k on k.CACC = inv.CACC
where TrTypeId = 2 and DateTransact = @actDate and CourIdTo = @courId and TL.Wb_No = '0'



update #CourierAll set aAddress = UPPER(aAddress), client = UPPER(client)

select *, isredy=0, inway=0, isview=0, rcpn=null 
from #CourierAll
order by aAddress, client

--drop table #CourierAll

go
grant execute on [wwwCourGetAll] to [pod]
go
