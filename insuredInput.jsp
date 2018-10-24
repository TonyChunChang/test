<%--  
	- Description:  
	- System     : TA                                   
	- History                                                        
	- Date	  	   Developer	 SR_NO.	    	Remarks                        
  -----------------------------------------------------------------------------
	- 2008/11/05	Cecile 		AP08186			 一般客戶投保修正畫面
	- 2009/01/12	Cecile		AG09T007		修改單位名稱
	- 2009/02/06	Cecile		AG09T002                     修改隱私權條款
	- 2009/06/30	Cecile		AG09T097-1  	增加受益人關係:增加「祖父母」項目，代碼：G-祖父母
	- 2009/12/30	Cecile		AG09T180		增加國籍
	- 2010/02/09	Cecile		AG11T016		修改行政單位名稱
	- 2011/09/13	Cecile		UW11005TA		修改行政單位名稱
	- 2013/08/28	Cecile		UW13100TA		修改受益人
	- 2014/02/07	Cecile		UW14007TA		加入性別
	- 2014/03/18	Cecile		CST14005		增加保戶資料網頁
	- 2015/02/03	Peter		CST15006		增加浮動說明框與拉寬表格白框
	- 2015/03/04	Peter		CST15028		增加與被保人關係選項
	- 2015/03/05	Peter		CST15028		footer flush attribute
	- 2015/03/27	Peter Chiu	MIS14239		移除難字反向tag
	- 2015/06/09	Peter Chiu	CST15087		wording調整
	- 2018/06/11	Eric Tsai	UW18304			配合保險法修正案詢問被保險人受有監護宣告問項事宜，新增提醒訊息及表格下載。
	- 2018/06/28	Eric Tsai	UW18317			被保險人新增「受有監護宣告」欄位及調整「被保險人監護宣告詢問事項」表單
--%>
<%@ page import="java.util.List" %>
<%@ page import="com.nanshan.eservice.ta.data.TimeData"%>
<%@ page import="tw.com.nanshanlife.ta.bean.*" %>
<%@ page import="tw.com.nanshanlife.ta.util.*" %>
<%@ page import="tw.com.nanshanlife.epolicy.log.*" %>
<%
	LogX logx = new LogX();
	logx.ui("",request.getServletPath());

	String webapp_root = request.getContextPath() ;
	TimeData tdate = new TimeData();

	int iYear=Integer.parseInt(tdate.getStrYear("yy"));
	Utility util = new Utility();

	int listSize = 10;
	PolicyDataBean data = (PolicyDataBean)session.getAttribute("PolicyData");
	if(data == null){
		response.sendRedirect(webapp_root + "/page/layout/error.jsp?err=noObjPolicy");
	}
	String detailSize = (String)session.getAttribute("DetailSize");
	System.out.println("session detailSize ==" + detailSize);
	if(detailSize != null){
		listSize = Integer.parseInt(detailSize);
	}else{
		session.setAttribute("DetailSize", "10");
	}
	List insuredList = data.getInsuredList();
	System.out.println("insuredList size ==" + insuredList.size());
	
	String errMsg = (String)session.getAttribute("ErrorMsg");
	if(errMsg == null) errMsg = "";
	
	String checkproxyID = data.getproxyHasPassport();
	System.out.println("checkproxyID ==" + checkproxyID);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.01 transitional//EN" "http://www.w3.org/tr/html4/loose.dtd">
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="<%=webapp_root%>/css/body.css" type="text/css">
<script language="JavaScript" type="text/javascript" src="<%=webapp_root%>/js/dateselector.js"></script>
<script language="JavaScript" type="text/javascript" src="<%=webapp_root%>/js/common_modules.js"></script>
<script language="JavaScript" type="text/javascript" src="<%=webapp_root%>/js/validation.js"></script>
<script language="JavaScript" type="text/javascript" src="/ta/js/tooltip.js"></script>
<title>旅行平安險-線上投保</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="GENERATOR" content="Rational Software Architect">
</head>
<script language="JavaScript">
history.forward();

var initTime = new Date();
var outOfTime = 25;
var microsecond = 1000;
var secondms = 60 * 1000;
var thirtySec = new Date(initTime.getTime()+(outOfTime*secondms+microsecond+1*microsecond));

function TimeWatch() {
	var time = new Date();
	var dd = new Date(thirtySec-time);
	min=dd.getMinutes();
	sec=dd.getSeconds();

    if (sec.length < 2) {sec = "0" + sec;}
    if (min.length < 2) {min = "0" + min;}
	document.all.min.value = min;
	document.all.sec.value = sec;
	var h = 100;
	var w = 410;
	var wLeft = (screen.width - 400) / 2;
	var wTop = (screen.height - 100) / 2;

	if(min ==00 && sec ==00 || time > thirtySec ){
		document.all.min.value = '00';
		document.all.sec.value = '00';
	   	//alert("很抱歉，系統連線已中斷，若要繼續使用請重新登錄南山人園地，謝謝!");
	   		//window.open("timeOut.jsp",'_blank','height=1,width=1,top='+screen.height+',left='+screen.width+',toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	   		//timeout.location = "timeOut.jsp";
	   		//location.reload();
	}else if(min >=0 && sec >=0 ){
		if(min ==02 && sec ==0){
			document.all.min.value = '02';
			document.all.sec.value = '00';	      	
	   		window.open("<%=webapp_root%>/page/taA1/timeOutMessage.jsp",'_blank','height='+h+',width='+w+',top='+wLeft+',left='+wTop+',titlebar=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		}
		if (sec !=00) {
			sec = sec -1 ;
		    if (sec < 10) {sec = "0" + sec; }
		    if (min < 10) {min = "0" + min;}
		    document.all.sec.value = sec;
		    document.all.min.value = min;
		}else{
			sec = 59;
		    min = min -1;
		    if (min < 10) {min = "0" + min;}
		    document.all.sec.value = sec;
		    document.all.min.value = min;
		      
		}
		setTimeout("TimeWatch()",1000);   //1000 = 1秒
	}
}
function timeRestart(){
	initTime = new Date();
	thirtySec = new Date(initTime.getTime()+(outOfTime*secondms+microsecond+1*microsecond));
	timeout.location.reload();
}
function addInsured(){
	document.insuredForm.method.value="addInsured";
	var insuredList = document.getElementsByName("insuredId");
	for(i=0; i<insuredList.length; i++){
		document.insuredForm.nationality[i].disabled = false;
	}
	document.insuredForm.submit();
}
function updateValue(){
	var newValue = document.insuredForm.updateAssured.value;
	if(newValue == ""){
		return;
	}
	var msg = "被保險人每人投保金額更新為" + newValue + "萬元";
	if(confirm(msg)){
	var assuredList = document.getElementsByName("sumAssured");
	for(i=0; i<assuredList.length; i++){
		var name = document.insuredForm.insuredName[i].value;
		var id = document.insuredForm.insuredId[i].value;
		if(name != "" || id != ""){
			document.insuredForm.sumAssured[i].value = newValue;
		}
	}
	}
}
function gotoNextPage() {
	if(validate_insured_list(document)){
		var insuredList = document.getElementsByName("insuredId");
		for(i=0; i<insuredList.length; i++){
			document.insuredForm.nationality[i].disabled = false;
		}
		//document.insuredForm.submit();
	}
}
function goBack() {
	document.insuredForm.method.value="backPolicyInput";
	var insuredList = document.getElementsByName("insuredId");
	for(i=0; i<insuredList.length; i++){
		document.insuredForm.nationality[i].disabled = false;
	}
	document.insuredForm.submit();
}
function showMsg() {
	var msg = "<%=errMsg%>";
	if(msg != ""){
		alert(msg);
	}
	resizeToFulleWindow();
	TimeWatch();
}
function resetField(i) {
	if(confirm("是否刪除資料?")){
	var index = i;
	document.insuredForm.insuredName[index].value="";
	document.insuredForm.insuredId[index].value="";
	document.insuredForm.birthYear[index].selectedIndex=0;
	document.insuredForm.birthMonth[index].selectedIndex=0;
	document.insuredForm.birthDay[index].selectedIndex=0;
	document.insuredForm.passport[index].checked = false;
	document.insuredForm.relationship[index].value = 'N';
	document.insuredForm.beneficiaryName[index].value = "";
	document.insuredForm.beneficiaryName[index].readOnly = true;
	document.insuredForm.otherCount[index].value="";
	document.insuredForm.otherSumAssured[index].value="";
	document.insuredForm.nationality[index].value="";
	document.insuredForm.nationality[index].disabled = true;
	eval("document.insuredForm.insuredSex" + index +"[0]").checked = false;
	eval("document.insuredForm.insuredSex" + index +"[1]").checked = false;
	
	eval("document.insuredForm.insuredGuardianDeclaration" + index +"[0]").checked = false;
	eval("document.insuredForm.insuredGuardianDeclaration" + index +"[1]").checked = false;
	
	var insuredList = document.getElementsByName("insuredId");
	for(i=0; i<insuredList.length; i++){
		document.insuredForm.nationality[i].disabled = false;
	}
	document.insuredForm.item.value = index;
	document.insuredForm.method.value="deleteInsured";
	document.insuredForm.submit();
	
	}
}
function changeRelationship(i) {
	var index = i;
	
	if (document.insuredForm.relationship[index].value == 'N') {
		document.insuredForm.beneficiaryName[index].value = "";
		document.insuredForm.beneficiaryName[index].readOnly = true;
	}else if (document.insuredForm.relationship[index].value == 'L') {
		document.insuredForm.beneficiaryName[index].value = "法定繼承人";
		document.insuredForm.beneficiaryName[index].readOnly = true;
	} else {
		document.insuredForm.beneficiaryName[index].value = "";
		document.insuredForm.beneficiaryName[index].readOnly = false;
	}
}

function checkPassPort(i){
	var index = i;
	if (document.insuredForm.passport[index].checked == true){
		alert("如被保險人、受益人為外籍人士時，須於要保書上註明國籍、英文全名(同護照)、出生年月日、護照號碼。");
		document.insuredForm.nationality[index].disabled = false;
	}else{
		document.insuredForm.nationality[index].value = "";
		document.insuredForm.nationality[index].disabled = true;
	}
}
function selectGender(i, v){
	var index = i;
	document.insuredForm.insuredGender[index].value = v;
}

function selectGuardianDeclaration(i, v){
	var index = i;
	document.insuredForm.insuredGuardianDeclaration[index].value = v;
}

function showInfo(){
	var tip = "<table border='1' cellspacing='0' cellpadding='0' width='400'>"+
		"<tr bgcolor='#0099FF'><td class='body'><font color='white'>若同一被保險人指定多位身故受益人，請於【與被保險人關係】欄位中選擇符合所有受益人之關係選項，並於受益人之【姓名】欄位中輸入個別姓名逐一以〝、〞區隔，謝謝。<\/font><\/td><\/tr>"+
		"<\/table>";
	
	tooltip(tip);
}
MM_reloadPage(true);
</script>
<body onload="showMsg()">
<table WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="0" 
		ALIGN="CENTER" bordercolorlight="#6699ff" bordercolordark="#FFFFFF">
	<tr>
		<td>
			<form name="insuredForm" method="post" action="<%=webapp_root%>/PolicyServlet">
			<input type="hidden" name="method" value="insuredInput" />
			<input type="hidden" name="item" value="" />
			<input type="hidden" name="effectiveDate" value="<%=data.getEffectiveDate().getFormatDate()%>" />
			<input type="hidden" name="checkproxyID" value="<%=checkproxyID%>" />
			<table WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
				<tr bgcolor="#E0ECFE"><td align="center" COLSPAN="2"><IMG SRC="<%=webapp_root%>/images/top.jpg" HEIGHT="81" WIDTH="768"></td></tr>
				<tr bgcolor="#E0ECFE"><td align="center" COLSPAN="2"><IMG SRC="<%=webapp_root%>/images/step1.jpg" HEIGHT="81" WIDTH="768"></td></tr>

				<table WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="1" CLASS="body" ALIGN="center" bgcolor="#FFFFFF">
	
					<tr bgcolor="#E0ECFE">
						<td COLSPAN="2" HEIGHT="40" ALIGN="CENTER">
						<div CLASS="head01">◎輸入被保險人資料◎</div>
						<FONT COLOR="blue">(出發地點以台、澎、金、馬地區為限，若投保時已身在台、澎、金、馬以外地區者，無法投保本公司旅行險)</FONT>
						</td>
					</tr>
					<tr>
						<td COLSPAN="2" HEIGHT="35" CLASS="body" bgcolor="#0099FF">
						<font COLOR="#FFFFFF">
						◎本系統不受理全體被保險人之總投保金額大於新台幣4億元，若有投保需求請於保期生效前7天與南山人壽旅行險連絡，須以書面要保文件提出投保。<br>
						◎<span style="background-color: white"><font COLOR="red">【被保險人旅行險投保家數(含南山人壽)，不得超過二家保險公司，或合計總保額不得超過新台幣4,000萬元】</font></span><br>
						　敬請協助於要保書上保險期間生效前三個工作日完成要保文件簽署後遞送，<br>
						　以利盡速通報投保及索引同業通報資料，確認保額未逾本公司可承保額度。
						</font>
						</td>
					</tr>
				</table>
				<table WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="3" CLASS="body" ALIGN="center" bgcolor="#FFFFFF">
				<tr bgcolor="#E0ECFE">
					<td COLSPAN="15">更新全部被保險人每人投保金額
						<select name="updateAssured">
						<option VALUE=""></option>
						<option VALUE="60">60</option>
						<option VALUE="100">100</option>
						<option VALUE="200">200</option>
						<option VALUE="300">300</option>
						<option VALUE="400">400</option>
						<option VALUE="500">500</option>
						<option VALUE="600">600</option>
						<option VALUE="800">800</option>
						<option VALUE="1000">1000</option>
						<option VALUE="1200">1200</option>
						<option VALUE="1500">1500</option>
						<option VALUE="1800">1800</option>
						<option VALUE="2000">2000</option></select>
						 萬元，輸入後請按更新投保金額
						<input type="button" value="更新投保金額" onclick="updateValue()"/>
					</td>
				</tr>
				<tr bgcolor="#E0ECFE">
					<td COLSPAN="12" align="center">
					<input type="button" value="新增被保險人欄位" onclick="addInsured()"/>
					</td>
					<td COLSPAN="3">
					<table>
					<tr>
						<td>
							<input type="text" name="min" size="2"
							style="font-size: 12pt;color:blue; border-width: 0; vertical-align:middle; text-align:center;" readonly>
							：				
							<input type="text" name="sec" size="2"
							style="font-size: 12pt;color:blue; border-width: 0; vertical-align:middle; text-align:center;" readonly>
						</td>
						<td align="center"><input type='button' value='重新計時' onclick='timeRestart()'></td>
					</tr>
					</table>
					</td>
				</tr>
				<tr bgcolor="#E0ECFE">
					<td COLSPAN="15" align="right">保額單位：新台幣萬元</td>
				</tr>
				<tr bgcolor="#E0ECFE">
					<td ROWSPAN="2" align="center">編<br>號</td>				
					<td ROWSPAN="2" align="center">被保險人<br>姓　　名</td>
					<td width="100" ROWSPAN="2" align="center">身分證統一編號<br>
					(外國人填護照號碼)</td>
					<td ROWSPAN="2" align="center">外國<br>護照</td>
					<td ROWSPAN="2" align="center">國籍</td>
					<td width="50" ROWSPAN="2" align="center">性別</td>
					<td width="180" ROWSPAN="2" align="center">出生年月日</td>
					<td width="50" ROWSPAN="2" align="center">受有<br>監護宣告</td>
					<td ROWSPAN="2" align="center">主約投保保額</td>
					<td width="200" colspan="2" align="center">身故受益人<br><a href="#" onmouseover="showInfo();" onmouseout="exit();"><font color="blue">輸入說明</font></a></td>
					<td colspan="2" align="center">已投保其他公司<br>旅行平安保險</td>
					<td width="100" ROWSPAN="2" align="center">核保訊息</td>
					<td ROWSPAN="2" align="center"></td> 
				</tr>
				<tr bgcolor="#E0ECFE">
					<td width="100" align="center">與被保險人關係</td>
					<td align="center">姓名</td>
					<td width = "30" align="center">家數</td>
					<td width = "45" align="center">總保額</td>
				</tr>
	
	<% 	
		String dest = data.getDestination();
		String defaultSumAssured = "500";
		if(!"1".equals(dest)) defaultSumAssured = "1000";
		
		for(int i=0; i<listSize; i++){
			InsuredDataBean insured = null;
			if(insuredList.size() > i){ 
				insured = (InsuredDataBean)insuredList.get(i);
			}else{
				insured = new InsuredDataBean();
			}
			String passPort = insured.getUsingPassport();
			String nationality = insured.getNationality();
			if(nationality == null) nationality = "";
			String sumAssured = insured.getStrSumAssured();
			if("0".equals(sumAssured)) sumAssured = defaultSumAssured;
			String relationship = insured.getRelationship();
			String benName = insured.getBeneficiary();
			if("".equals(relationship)){
				benName = "";
				relationship = "N";
			}
			String otherCount = "";
			String otherSumAssured = "";
			otherCount = insured.getStrOtherCount();
			otherSumAssured = insured.getStrOtherSumAssured();
			
			int yearSelectIndex = -1;
			int monthSelectIndex = -1;
			if(insured.getBirthYear() != null && !"".equals(insured.getBirthYear())){
				yearSelectIndex = Integer.parseInt(insured.getBirthYear())-1;
			}
			if(insured.getBirthMonth() != null && !"".equals(insured.getBirthMonth())){
				monthSelectIndex = Integer.parseInt(insured.getBirthMonth())-1;
			}
			String yearOption = util.createOption(1,iYear,yearSelectIndex);
			String monthOption = util.createOption(1,12,monthSelectIndex,2);
			
			String returnMsg = insured.getReturnMsg();
			
			boolean benNameReadOnly = false;
			if("N".equals(relationship) || "L".equals(relationship)){
				benNameReadOnly = true;
			}
			int seqNo = i+1;
			String filedName = "insuredSex" + i;
			
			String guardianDeclarationName = "insuredGuardianDeclaration" + i;
	%>		
				<tr bgcolor="#E0ECFE">
					<td align="center"><%=seqNo%></td>
					<td align="center"><input type="text" name="insuredName" value="<%=insured.getName()%>" size="8" /></td>
					<td align="center"><input type="text" name="insuredId" value="<%=insured.getID()%>" size="10" maxlength="10" ONKEYUP="return_UpperCase(this)"/></td>
					<td align="center"><input type="checkbox" name="passport" value="<%=i%>" onclick="checkPassPort(<%=i%>)" <%="F".equals(passPort)?"checked":""%>/></td>
					<td align="center"><input type="text" name="nationality" value="<%=nationality%>" size="3" maxlength="30" <%="F".equals(passPort)?"":"disabled"%> /></td>
					<td width="50" align="center">
						<input TYPE="radio" NAME="<%=filedName%>" value="M" <%="M".equals(insured.getSex())?"checked":""%> onclick="selectGender('<%=i%>','M')">男性
						<br>
						<input TYPE="radio" NAME="<%=filedName%>" value="F" <%="F".equals(insured.getSex())?"checked":""%> onclick="selectGender('<%=i%>','F')">女性
						<input type="hidden" name="insuredGender" value="<%=insured.getSex()==null?"":insured.getSex()%>">
					</td>
					<td align="center">
						<select name="birthYear" onmousedown="selectYear(this.form, 'birth','<%=i%>')"><option value="">&nbsp;&nbsp;</option><%=yearOption%></select>年
						<select name="birthMonth" onmousedown="selectMonth(this.form, 'birth', '<%=i%>')" onchange="changeDay(this.form, 'birth','<%=i%>')"><option value="">&nbsp;&nbsp;</option><%=monthOption%></select>月
						<select name="birthDay" onmousedown="selectDay(this.form, 'birth', '<%=i%>')"><option value="">&nbsp;&nbsp;</option></select>日
					</td>
					<td width="60" align="center">
						<input TYPE="radio" NAME="<%=guardianDeclarationName%>" value="Y" <%="Y".equals(insured.getGuardianDeclaration())?"checked":""%> onclick="selectGuardianDeclaration('<%=i%>','Y')">是<br>
						<input TYPE="radio" NAME="<%=guardianDeclarationName%>" value="N" <%="N".equals(insured.getGuardianDeclaration())?"checked":""%> onclick="selectGuardianDeclaration('<%=i%>','N')">否<input type="hidden" name="insuredGuardianDeclaration" value="<%=insured.getGuardianDeclaration()==null?"":insured.getGuardianDeclaration()%>">
					</td>
					<td align="center">
						<select name="sumAssured">
							<option VALUE="60" <%="60".equals(sumAssured)?"selected":""%>>60</option>
							<option VALUE="100" <%="100".equals(sumAssured)?"selected":""%>>100</option>
							<option VALUE="200" <%="200".equals(sumAssured)?"selected":""%>>200</option>
							<option VALUE="300" <%="300".equals(sumAssured)?"selected":""%>>300</option>
							<option VALUE="400" <%="400".equals(sumAssured)?"selected":""%>>400</option>
							<option VALUE="500" <%="500".equals(sumAssured)?"selected":""%>>500</option>
							<option VALUE="600" <%="600".equals(sumAssured)?"selected":""%>>600</option>
							<option VALUE="800" <%="800".equals(sumAssured)?"selected":""%>>800</option>
							<option VALUE="1000" <%="1000".equals(sumAssured)?"selected":""%>>1000</option>
							<option VALUE="1200" <%="1200".equals(sumAssured)?"selected":""%>>1200</option>
							<option VALUE="1500" <%="1500".equals(sumAssured)?"selected":""%>>1500</option>
							<option VALUE="1800" <%="1800".equals(sumAssured)?"selected":""%>>1800</option>
							<option VALUE="2000" <%="2000".equals(sumAssured)?"selected":""%>>2000</option>
						</select>
					</td>
					<td align="center">
						<select name="relationship" onchange="changeRelationship(<%=i%>)">
							<option VALUE="N" selected>請選擇</option>
							<option VALUE="L" <%="L".equals(relationship)?"selected":""%>>法定繼承人</option> 
							<option VALUE="S" <%="S".equals(relationship)?"selected":""%>>配偶</option> 
							<option VALUE="C" <%="C".equals(relationship)?"selected":""%>>子女</option> 
							<option VALUE="P" <%="P".equals(relationship)?"selected":""%>>父母</option>
							<option VALUE="Q" <%="Q".equals(relationship)?"selected":""%>>配偶及子女</option>
							<option VALUE="W" <%="W".equals(relationship)?"selected":""%>>配偶及父母</option>
							<option VALUE="E" <%="E".equals(relationship)?"selected":""%>>子女及父母</option>
							<option VALUE="H" <%="H".equals(relationship)?"selected":""%>>配偶、子女及父母</option>
							<option VALUE="G" <%="G".equals(relationship)?"selected":""%>>祖父母</option>
						</select>
					</td>
					<td align="center"><input type="text" name="beneficiaryName" value="<%=benName%>" size="10" <%=benNameReadOnly?"readonly":""%> /></td>
					<td align="center"><input type="text" name="otherCount" value="<%=otherCount%>" size="2" maxlength="1"/></td>
					<td align="center"><input type="text" name="otherSumAssured" value="<%=otherSumAssured%>" size="4" maxlength="4"/></td>
					<td width="100"><%=returnMsg%></td>
					<td align="center"><input type="button" name="delete" value="刪除" onclick="resetField(<%=i%>)"></td>
				</tr>
		<%	} %>
				<tr bgcolor="#E0ECFE">
				<td COLSPAN="15">
				被保險人資料超過10位時，若欲新增請按上方『新增被保險人欄位』功能按鈕</td>
				</tr>
				<tr bgcolor="#E0ECFE">
					<td COLSPAN="15" ALIGN="CENTER"><IMG
					SRC="<%=webapp_root%>/images/button_next_a.jpg" NAME="Image1"
					ONMOUSEOUT="MM_swapImgRestore()"
					ONMOUSEOVER="MM_swapImage('Image1','','<%=webapp_root%>/images/button_next_b.jpg',1)"
					ONCLICK="return gotoNextPage();"> <IMG
					SRC="<%=webapp_root%>/images/button_goback_a.jpg" NAME="Image2"
					ONMOUSEOUT="MM_swapImgRestore()"
					ONMOUSEOVER="MM_swapImage('Image2','','<%=webapp_root%>/images/button_goback_b.jpg',1)"
					ONCLICK="goBack();"></td>
				</tr>
			</table>
		</table>
		</form>
		</td>
	</tr>
</table>
<table width="98%" align="center">
	<jsp:include page="../layout/footer.html" flush="true"/>
</table>
<iframe name="timeout" style="display:none" src="<%=webapp_root%>/time.html"></iframe>
</body>
</html>
<script language="JavaScript">
	var fname = document.insuredForm;
	<%
	for(int i=0; i<listSize; i++){
		int daySelectIndex = -1;
		InsuredDataBean insured = null;
		if(insuredList.size() > i){ 
			insured = (InsuredDataBean)insuredList.get(i);
		}else{
			insured = new InsuredDataBean();
		}
		
		if(insured.getBirthDay() != null && !"".equals(insured.getBirthDay())){
			daySelectIndex = Integer.parseInt(insured.getBirthDay())-1;
		}
		if(daySelectIndex > -1){
	%>
    	changeDay(fname, 'birth', '<%=i%>');
    	fname.birthDay[<%=i%>].value = "<%=insured.getBirthDay()%>";
    <%
    	}
    }
    %>	
</script>
