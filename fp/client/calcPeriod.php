<?php
$frmId = $_REQUEST["frmid"] ? $_REQUEST["frmid"] : 4; 
?>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251" />
	<title>��������� ������</title>
<style>
body {font-family: verdana; font-size: 10pt; margin: 0;}

.tblData {border-collapse: collapse; font-family: verdana; font-size: 8pt; cursor: default;}
.tblData td { padding-left: 5px; padding-right: 5px;}
.tblData th, .header {background-color: #2F4E77; color: white; padding: 3px; cursor: pointer;}
.tblData tr.even {background-color: #DEEDFF;}
.tblData tr.cur {background-color: gray; color: white;}
.splash {position: absolute; left:0; top: 0;  width: 100%; height: 100%; background-color: gray; filter: alpha(opacity=50); opacity:0.5; z-index: 1001;}
.dia {position: absolute; left:700px; top: 400px; background-color: #DEEDFF; z-index: 1010; font-size: 10pt;  cursor: default;}
</style>

    <script type="text/javascript" src="../spry/includes_packed/SpryUtils.js"></script>
    <script type="text/javascript" src="../spry/includes_packed/xpath.js"></script>
    <script type="text/javascript" src="../spry/includes_packed/SpryData.js"></script>    

    <link href="../spry/includes/SpryValidationTextField.css" rel="stylesheet" type="text/css" /> 
    <script src="../spry/includes/SpryValidationTextField.js" type="text/javascript"></script> 
    
    <link href="../spry/includes/SpryValidationTextarea.css" rel="stylesheet" type="text/css" /> 
    <script src="../spry/includes/SpryValidationTextarea.js" type="text/javascript"></script> 
    
    <script language="JavaScript" type="text/javascript" src="../spry/includes/SpryAutoSuggest.js"></script>
    <link href="../spry/includes/SpryAutoSuggest.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
var dsCity = new Spry.Data.XMLDataSet("getCityList.php", "data/row", {useCache: false});
var dsTarif = new Spry.Data.XMLDataSet("getTarif.php", "data/row", {useCache: false});

function fCalc(){
    var frm = document.getElementById('frmCalc')
    var wt = 0.1 //frm.wt.value  
    var code
    var frmid = frm.frmid.value
    
    var firstMatchingRow = dsCity.findRowsWithColumnValues({ "@fname": asDest.textElement.value}, true);

    if (firstMatchingRow != null){
      code = firstMatchingRow["@code"]
      }
  
    if(!code){
        alert("�������� ���.����� �� ������");
        //asDest.textElement.focus();
        asDest.textElement.select();
        
        return;
    }
    
    if(!wt){
        alert("������� ���");
        frm.wt.select();
        return;
    }
        
    dsTarif.setURL("getTarif.php?code=" + code + "&wt=" + wt + "&frmid=" + frmid)
    dsTarif.loadData();
    }


</script>    
    
</head>

<body>
<div>
<!--
<h1>������ ���������</h1>

<p> ���� ���������� ��������� �������� ����� �� ������ � ����� ����� ����.<br /> ��� �����:<br /> 
1. � ������ ���������� �������� ���� �� ������ ��� ����� ������� ������ � �������� ������ ����� �� ������������ ������<br /> 
2. ��������� ��� ����� � ��<br /> 
3. ������� ������ ���������� - ��������� ������!<br />
--> 
<!--div spry:region="dsCity"> <span>{ds_CurrentRowID}</span> = <span>{ds_CurrentRowNumber}</span></div-->
</div>
<form id="frmCalc" action="getTarif.php">
<table class="tblData">
    <tr>
        <th>����� ����������</th>
        <!--th>���, ��</th-->
        <th>���� ��������, ����*</th>
        <!--th>���������, ��� *</th-->
     </tr>
    <tr>
        <td><!-- ���������� ������ ���.�������-->
            <span spry:region="dsCity"> <input type="hidden" name="code" value="{@code}" size="5" readonly1="true"/></span>
            <span id="dest">
            	<input type="text" id="destName" size="50"/> 
            	<div id="destCodes" spry:region="dsCity" style="position: absolute;">
        		<table class="tblData">
        			<tr spry:repeat="dsCity" spry:suggest="{@fname}" 1spry:setrow="{ds_rowID}">
        				<!--td><div>{@code}</div></td-->
        				<td><div>{@fname}</div></td>
        				<!--td><div>{@city}</div></td>
        				<td><div>{@country}</div></td>
        				<td><div>{@state}</div></td-->
        			</tr>
        		</table>
            	</div>
            </span>
            <script type="text/javascript">
        	var asDest = new Spry.Widget.AutoSuggest("dest", "destCodes", "dsCity", '@fname', {minCharsType: 2, loadFromServer: true, urlParam: "pName"});
        	//var asDest = new Spry.Widget.AutoSuggest("dest", "destCodes", "dsCity", '@fname');
            </script>
       
        </td>
        
        <!--td><input name="wt" size="7"/></td-->
        <td style="text-align: right;"><span spry:region="dsTarif">{@del}</span></td>
        <!--td style="text-align: right;"><span spry:region="dsTarif">{@price}</span></td-->
    </tr>
</table>
<input type="button" value="����������" onclick="fCalc()"/>
<input type="hidden" name="frmid" value="<?php	echo $frmId; ?>"/>
</form>

<!--p> <span title="<?php	echo $frmId; ?>">*</span> - ��������� ������� ��� ���<br /-->
<p> <span>*</span> - ���� �������� ������ � ������� ����, ��� ����� ��� ������ �����������<br />


</body>

</html>