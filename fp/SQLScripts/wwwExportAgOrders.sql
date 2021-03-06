USE [ALERT_F]
GO
/****** Object:  StoredProcedure [dbo].[wwwExportAgOrder]    Script Date: 02/01/2013 12:37:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[wwwExportAgOrder]
	@ordnum int
as      
   
SELECT ro.[rordnum]
      ,ro.[org]
      ,orgcity=(select RusName from N_City where id=ro.ORGCity)
      ,ro.[cacc]
      ,ro.[cname]
      ,ro.[address]
      ,ro.[contname]
      ,ro.[contphone]
      ,ro.[contfax]
      ,ro.[contmail]
      ,ro.[orgrems]
      ,payr=case when ro.[Payr]=1 then 'Отправитель'
			when ro.[Payr]=2 then 'Получатель' 
			when ro.[Payr]=3 then '3-е лицо' end
      --,ro.[pcacc]
      ,pname=(select partname from Partinf where partcode = ro.[PCACC])
      ,paytype= case when ro.[PayType]=1 then 'Наличный'
					when ro.[PayType]=0 then 'Безналичный' end
      ,[type]= case when ro.[Type]=1 then 'Документ'
				               	when ro.[Type]=0 then 'Не документ' 
                       when ro.[Type]=3 then 'Опасный груз' end
                            
      ,ro.[packs]
      ,ro.[wt]
      ,ro.[volwt]
      ,ro.[amt]
      ,curid=(select LongCur FROM Cur_Lst1 where id=ro.CurId)
      ,ro.[courdate]
      ,ro.[courtimef]
      ,ro.[courtimet]
      ,ro.[dest]
      ,destcity=(select RusName from N_City where id=ro.DESTCity)
      ,ro.[dcacc]
      ,ro.[dname]
      ,ro.[dadr]
      ,ro.[dcontname]
      ,ro.[dcontphone]
      ,ro.[dcontfax]
      ,ro.[dcontmail]
      ,ro.[destrems]
      ,ro.[datein]
      ,ro.[userin]
      ,ro.[dateed]
      ,ro.[usered]
      ,[status]= case--
        when ro.NeedDel = 1 then 'отменен'
        when (select COUNT(1) from MnfBdy where Wb_no = ro.Wb_no) <> 0 then 'на комплектовке'
        when ro.Wb_no is NULL and (ro.NeedDel is NULL or ro.NeedDel=0) and DATEDIFF(dd, dbo.addWDays(courDate, 2), getDate())>0 then 'просрочено'
        when ro.Status = 0  then 'заявлен'
        when ro.Status = 1  then 'передан агенту'
        when ro.Status = 2  then 'принят агентом'
        when ro.Status = 4  then 'присвоен № нак.'
        when ro.Status = 3  then 'отказ клиента'
        end
      ,ro.[wb_no]
      ,ro.[needdel]
  FROM AgOrders ro
where ro.ROrdNum= @ordnum

go

GRANT EXECUTE ON [dbo].[wwwExportAgOrder] TO [pod]

