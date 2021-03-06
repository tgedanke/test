USE [ALERT_F]
GO
/****** Object:  StoredProcedure [dbo].[wwwEditAgOrders]    Script Date: 12/22/2011 12:58:52 ******/
DROP PROCEDURE [dbo].[wwwEditAgOrders]
GO
/****** Object:  StoredProcedure [dbo].[wwwGetAgOrders]    Script Date: 12/22/2011 12:58:52 ******/
DROP PROCEDURE [dbo].[wwwGetAgOrders]
GO
/****** Object:  StoredProcedure [dbo].[wwwGetCity]    Script Date: 12/22/2011 12:58:52 ******/
DROP PROCEDURE [dbo].[wwwGetCity]
GO
/****** Object:  StoredProcedure [dbo].[wwwSaveAgOrders]    Script Date: 12/22/2011 12:58:52 ******/
DROP PROCEDURE [dbo].[wwwSaveAgOrders]
GO
/****** Object:  StoredProcedure [dbo].[wwwSaveAgOrders]    Script Date: 12/22/2011 12:58:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[wwwSaveAgOrders]
@ORG int, 
@CName varchar(60),
@Address varchar(70),
@ContName varchar(50),
@ContPhone varchar(50),
@ContMail varchar(50),
@OrgRems varchar(1000),
@DEST int,
@DName varchar(60),
@DAdr varchar(70),
@DContName varchar(50),
@DContPhone varchar(50),
@DContMail varchar(50),
@DESTRems varchar(1000),
@Type smallint,
@Packs int,
@Wt decimal(18,2),
@VolWt decimal(18,2),
--@Amt float,
--@CurId int,
--@PayType int,
@Payr int,
@UserIn varchar (50),
@RordNum int,
@CourDate datetime,
@CourTimeF time,
@CourTimeT time
AS

if @ContMail='' set @ContMail=null
if @DContMail='' set @DContMail=null
if @CourDate='' set @CourDate=null
if @CourTimeF='' set @CourTimeF=null
if @CourTimeT='' set @CourTimeT=null

if @RordNum >0
 
Update AgOrders 
set ORGCity=@ORG, ORG=(select c.Code from N_City c where c.id=@ORG), CName=@CName, [Address]=@Address, ContName=@ContName,
ContPhone=@ContPhone, ContMail=@ContMail, OrgRems=@OrgRems, DESTCity=@DEST, DEST=(select c.Code from N_City c where c.id=@DEST),
DName=@DName, DAdr=@DAdr, DContName=@DContName, DContPhone=@DContPhone, DContMail=@DContMail, DESTRems=@DESTRems, [Type]=@Type,
Packs=@Packs, Wt=@Wt, VolWt=@VolWt, CourDate=@CourDate, CourTimeF=@CourTimeF, CourTimeT=@CourTimeT  
where ROrdNum=@RordNum 

else
begin
INSERT INTO AgOrders (
ORGCity,
ORG, 
CName,
[Address],
ContName,
ContPhone,
ContMail,
OrgRems,
DESTCity,
DEST,
DName,
DAdr,
DContName,
DContPhone,
DContMail,
DESTRems,
[Type],
Packs,
Wt,
VolWt,
CourDate,
CourTimeF,
CourTimeT,
Payr,
PCACC,
[Status],
FrmID,
UserIn,
CurId


 )VALUES (
@ORG, 
(select c.Code from N_City c where c.id=@ORG),
@CName,
@Address,
@ContName,
@ContPhone,
@ContMail,
@OrgRems,
@DEST,
(select c.Code from N_City c where c.id=@DEST),
@DName,
@DAdr,
@DContName,
@DContPhone,
@DContMail,
@DESTRems,
@Type,
@Packs,
@Wt,
@VolWt,
@CourDate,
@CourTimeF,
@CourTimeT,
1,
@Payr,
0,
4,
@UserIn,
0
       )
       
declare @StrBody varchar(max), @StrSub varchar(max)
select @StrSub='Принят новый заказ №'+convert(varchar,ROrdNum), 
@StrBody='Город отправления: ' +(select s.RusName from N_City s where s.id=ORGCity)+
char(13)+ 'Город получения: ' +(select s.RusName from N_City s where s.id=DESTCity)+
char(13)+ 'Внесено агентом: ' + (select p.PartName from Partinf p where p.PartCode=PCACC)


from AgOrders
where ROrdNum=SCOPE_IDENTITY()

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Test',
    @recipients = 'davisx13@gmail.com',
    @body = @strBody,
    @exclude_query_output = 1,
    @subject = @StrSub;


end


print 'Operation completed successfully'
GO
/****** Object:  StoredProcedure [dbo].[wwwGetCity]    Script Date: 12/22/2011 12:58:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[wwwGetCity]
	@pName varchar(50) = ''
as

--if @pName is null set @pName = ''

select Code=ct.id
, fname = ct.RusName + ', ' + cn.RusName + case when st.RusName is null then '' else ', ' + st.RusName end
--, rp.*
from N_City ct
	left join N_Country cn on ct.CCode =cn.CCode
	left join N_State st on st.SCode = ct.SCode and ct.CCode = st.CCode
	--left join RaidPlan rp on ct.Code = rp.DEST and rp.firmid = 4 and PlanNo=1 and rp.PreST=1
where (cn.CCode <> 'UA' or ( cn.CCode = 'UA' and ct.type=4 ))
 and 
(ct.RusName + ', ' + cn.RusName + case when st.RusName is null then '' else ', ' + st.RusName end) like @pName + '%'
order by ct.RusName
GO
/****** Object:  StoredProcedure [dbo].[wwwGetAgOrders]    Script Date: 12/22/2011 12:58:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[wwwGetAgOrders]
@period varchar(10), @agentID int
AS

--if ISNULL(ltrim(rtrim(@period)), '') = '' or @agentID is null return

if @agentID is null return
if ISNULL(ltrim(rtrim(@period)), '') = '' set @period = left(CONVERT(varchar(50), GETDATE(), 112), 6) + '01'

declare @bDate date, @eDate date, @agID int

set @agID = @agentID -- 54
set @bDate = /*@period */'20111116'
set @eDate = dateadd(d, -1, DATEADD(m,1,@bDate))

if @agID = -1 
SELECT [ROrdNum]
      ,[ORG]
      ,ORGCity=(select N_City.RusName from  N_City where N_City.id=ORGCity)
     -- ,[CACC]
      ,[CName]
      ,[Address]
      ,[ContName]
      ,[ContPhone]
      ,[ContFax]
      ,[ContMail]
      ,[OrgRems]
      --,[Payr]
      --,[PCACC]
      --,[PayType]
      ,[Type]
      ,[Packs]
      ,[Wt]
      ,[VolWt]
      ,[Amt]
     -- ,[CurId]
     -- ,[CourDate]
     -- ,[CourTimeF]
     -- ,[CourTimeT]
      ,[DEST]
      ,DESTCity=(select N_City.RusName from  N_City where N_City.id=DESTCity)
    --  ,[DCACC]
      ,[DName]
      ,[DAdr]
      ,[DContName]
      ,[DContPhone]
      ,[DContFax]
      ,[DContMail]
      ,[DESTRems]
      ,[DateIn]=convert(varchar,[DateIn],104)
    --  ,[UserIn]
    --  ,[DateEd]
    --  ,[UserEd]
    ,[status]= case
        when AgOrders.NeedDel = 1 then 'Отменен'
        when (select COUNT(1) from MnfBdy where Wb_no = AgOrders.Wb_no) <> 0 then 'на комплектовке'
        when AgOrders.Wb_no is NULL and (AgOrders.NeedDel is NULL or AgOrders.NeedDel=0) and DATEDIFF(dd, dbo.addWDays(courDate, 2), getDate())>0 then 'Просрочено'
        when AgOrders.Status = 0  then 'заявлен'
        when AgOrders.Status = 1  then 'передан агенту'
        when AgOrders.Status = 2  then 'принят агентом'
        when AgOrders.Status = 4  then 'присвоен № нак.'
        when AgOrders.Status = 3  then 'отказ клиента'
        end
     ,[Wb_no]
    --  ,[needDel]
  FROM [ALERT_F].[dbo].[AgOrders]
  order by ROrdNum desc
else
SELECT [ROrdNum]
      ,[ORG]
      ,ORGCity=(select N_City.RusName from  N_City where N_City.id=ORGCity)
     -- ,[CACC]
      ,[CName]
      ,[Address]
      ,[ContName]
      ,[ContPhone]
      ,[ContFax]
      ,[ContMail]
      ,[OrgRems]
      --,[Payr]
      --,[PCACC]
      --,[PayType]
      ,[Type]
      ,[Packs]
      ,[Wt]
      ,[VolWt]
      ,[Amt]
     -- ,[CurId]
     -- ,[CourDate]
     -- ,[CourTimeF]
     -- ,[CourTimeT]
      ,[DEST]
      ,DESTCity=(select N_City.RusName from  N_City where N_City.id=DESTCity)
    --  ,[DCACC]
      ,[DName]
      ,[DAdr]
      ,[DContName]
      ,[DContPhone]
      ,[DContFax]
      ,[DContMail]
      ,[DESTRems]
      ,[DateIn]=convert(varchar,[DateIn],104)
    --  ,[UserIn]
    --  ,[DateEd]
    --  ,[UserEd]
    ,[status]= case
        when AgOrders.NeedDel = 1 then 'Отменен'
        when (select COUNT(1) from MnfBdy where Wb_no = AgOrders.Wb_no) <> 0 then 'на комплектовке'
        when AgOrders.Wb_no is NULL and (AgOrders.NeedDel is NULL or AgOrders.NeedDel=0) and DATEDIFF(dd, dbo.addWDays(courDate, 2), getDate())>0 then 'Просрочено'
        when AgOrders.Status = 0  then 'заявлен'
        when AgOrders.Status = 1  then 'передан агенту'
        when AgOrders.Status = 2  then 'принят агентом'
        when AgOrders.Status = 4  then 'присвоен № нак.'
        when AgOrders.Status = 3  then 'отказ клиента'
        end
      ,[Wb_no]
    --  ,[needDel]
  FROM [ALERT_F].[dbo].[AgOrders]
  where PCACC=@agID
  or (AgentORG = @agID or AgentDEST = @agID)
  order by ROrdNum desc
GO
/****** Object:  StoredProcedure [dbo].[wwwEditAgOrders]    Script Date: 12/22/2011 12:58:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[wwwEditAgOrders]
@id int
AS

if @id is null return

SELECT [rordnum]
      ,orgcode=ORGCity
      ,org=(select N_City.RusName from  N_City where N_City.id=ORGCity)
  
      ,[cname]
      ,[address]
      ,[contname]
      ,[contphone]

      ,[contmail]
      ,[orgrems]

      ,[paytype]
      ,[type]
      ,[packs]
      ,[wt]
      ,[volwt]
      ,[amt]
      ,[curid]

      ,destcode=DESTCity
      ,dest=(select N_City.RusName from  N_City where N_City.id=DESTCity)
 
      ,[dname]
      ,[dadr]
      ,[dcontname]
      ,[dcontphone]

      ,[dcontmail]
      ,[destrems]
      ,[datein]=convert(varchar,[DateIn],104)
	  ,courdate=convert(varchar,courdate,104)
	  ,courtimef=left(convert(varchar,courtimef,108),5)
	  ,courtimet=left(convert(varchar,courtimet,108),5)
  FROM [ALERT_F].[dbo].[AgOrders]
  where [ROrdNum]=@id --and [Status]=0
GO
GRANT EXECUTE ON [dbo].[wwwSaveAgOrders] TO [pod] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[wwwGetCity] TO [pod] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[wwwGetAgOrders] TO [pod] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[wwwEditAgOrders] TO [pod] AS [dbo]
GO
