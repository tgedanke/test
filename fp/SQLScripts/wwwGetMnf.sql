USE [ALERT_F]
GO
/****** Object:  StoredProcedure [dbo].[wwwGetMnf]    Script Date: 08/19/2012 12:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter procedure [dbo].[wwwGetMnf]
@period varchar(10), @agentID int, @is_Ready int
AS
declare @bDate date, @eDate date
/*
declare @period varchar(10), @agentID int, @is_Ready int
set @agentID = 55
set @is_Ready = -1
set @period = '201207'
*/
set @bDate = @period+'01'
set @eDate = dateadd(d, -1, DATEADD(m,1,@bDate))


select distinct mh.mnfregno, mh.mnfrefno, mh.orgtrk, mh.desttrk, mh.bpcs, mh.bwt, mh.bvwt,mh.shpd, mh.dtarr, mh.darr
, --mh.carrcode, mh.flightno, mh.courier, mh.ex, mh.mawb, mh.operid, mh.is_ready, mh.formedby, mh.whoinf, autoinf = isnull((select count(*) from mnfinf where MnfRegNo=mh.MnfRegNo),0), sms, secondname,depart=convert(varchar(5),Depart,8),arrive=convert(varchar(5),Arrive,8),
descr=rtrim(cc.CarrName)--,ex_is=case when MnfNo is not null then 1 else 0 end, earlydlv_is,
--'' as agentmnf ,destagentid,orgagentid,MH.plomb, MH.tmarrset 
from mnfHdr mH
	join Carriers CC on mh.carrCode=cc.carrCode 
	left join ExLog Ex on mh.MnfRegNo=Ex.MnfNo 
	left join CouriersTemp CT on MH.CourId = CT.id 
	left join OperScd OP on OP.OperId=MH.OperId
where (is_Ready=2  or is_ReadyA=2) and
(
( @is_Ready=2 and mh.OrgAgentID = @agentID and mh.DestAgentID != @agentID  ) or ---out
( @is_Ready=-1 and mh.OrgAgentID != @agentID and mh.DestAgentID = @agentID  ) or---in
(@agentID = -1 ) or
(@is_Ready=3 and (mh.OrgAgentID = @agentID or mh.DestAgentID = @agentID))
)    --- были еще прямые

and (shpd between @bDate and @eDate)
 order by Shpd desc
go
 
grant execute on [wwwGetMnf] to [pod]
go