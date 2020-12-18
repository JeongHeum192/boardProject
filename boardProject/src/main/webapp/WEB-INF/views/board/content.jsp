<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head> 
<meta charset="utf-8"> 
<script src="https://code.jquery.com/jquery-3.5.1.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> 
<title>게시판 조회</title> 
<style>
div.left {
        width: 93%;
        float: left;
        box-sizing: border-box;
    }
div.right {
        width: 7%;
        float: right;
        box-sizing: border-box;
    }
</style>
</head>
<body>

<input type="hidden" name="bNo" value="${content.bNo}">
<div id="divImg">
<table class="table table-striped" style="width: 60%;"> 
	<div align="center" style="width: 60%;"><h3><b>게시글 조회</b></h3></div> 
	<div align="left"><b style="color:red;">제목은 필수값입니다.</b></div>
		<colgroup>
			<col style="width:40%">
			<col style="width:10%">
			<col style="width:50%">
		</colgroup>
		<tr > 
			<td rowspan='3'><img src="../save/${content.photo}" id="imgContent" title="${content.photo}" style="width:400px; height:300px"></td>
			<td>작성자</td> 
			<td> <input type="text" id="writer" name="writer" value="${content.writer}" readonly="readonly" class="form-control input-sm"> </td> 
		</tr> 
		<tr> 
			<td>제목</td> 
			<td> <input type="text" id="titleImg" name="title" value="${content.title}"  class="form-control input-sm" > </td> 
		</tr> 
		<tr> 
			<td>내용</td> 
			<td><textarea style="height: 150px;" id="contentImg" name="content" class="form-control">${content.content}</textarea> </td> 
		</tr> 
		<tr> 
			<td colspan="3" align="right">
				<button id="btnModify" class="btn btn-info" onclick="fnModify();">수정</button>
				<button onclick="location.href='/board/list?num=1'" class="btn btn-info">취소</button>
			</td>
		</tr> 
</table> 
</div>

<div id="divImgNot">
<table class="table table-striped" style="width: 60%;"> 
	<div align="center" style="width: 60%;"><h3><b>게시글 조회</b></h3></div>
	<div align="left"><b style="color:red;">제목은 필수값입니다.</b></div> 
		<colgroup>
			<col style="width:20%">
			<col style="width:80%">
		</colgroup>
		<tr > 
			<td>작성자</td> 
			<td> <input type="text" id="writer" name="writer" value="${content.writer}" readonly="readonly" class="form-control input-sm"> </td> 
		</tr> 
		<tr> 
			<td>제목</td> 
			<td> <input type="text" id="title" name="title" value="${content.title}"  class="form-control input-sm" > </td> 
		</tr> 
		<tr> 
			<td>내용</td> 
			<td><textarea style="height: 150px;" id="content" name="content" class="form-control">${content.content}</textarea> </td> 
		</tr> 
		<tr> 
			<td colspan="3" align="right">
				<button id="btnModify" class="btn btn-info" onclick="fnModify();">수정</button>
				<button onclick="location.href='/board/list?num=1'" class="btn btn-info">취소</button>
			</td>
		</tr> 
</table> 
</div>

<div id="replyDiv" style="width:60%;">
	<input type="hidden" id="replybNo" name="bno"> 
	<input type="hidden" id="replyreNo" name="reno">
	<div class="left" style="margin-bottom:1%;">
		<textarea class="form-control" id="rememo" name="rememo" rows="2" placeholder="댓글을 입력해주세요" maxlength="500"></textarea>
	</div>
	<div class="right">
        <button class="btn btn-outline btn-primary" style="margin-top:34%; margin-left:10%;" onclick="fn_replySave()">저장</button>
	</div>
</div>

<div>	
	<c:forEach var="replylist" items="${replylist}" varStatus="status">
	    <table class="table table-bordered" style="width: 56%; margin-bottom: 1px; margin-top: 5px; margin-left: ${20*replylist.reDepth}px; ">
	    	<tr>
	    		<td colspan="2">
	    			<div align="left" style="width:84%; float:left;" id="reply${replylist.reNo}">${replylist.reMemo}</div>
	    			<div align="right" style="width:16%; float:right;"><fmt:formatDate value="${replylist.regDate }" pattern="yyyy-MM-dd HH:mm:ss" timeZone="KST"/></div>
	    		</td>	
	    	</tr>
	    	<tr>
	    		<td colspan="2">
	    			<div align="right">
		    			<a href="#" onclick="fn_replyReply('${replylist.reNo}')">댓글</a>
		        		<a href="#" onclick="fn_replyDelete('${replylist.reNo}', '${replylist.reParent}')">삭제</a>
	        		</div>
	    		</td>
	    	</tr>
	    	<tr>
	    		<td colspan="2">
					<div id="replyDialog${replylist.reNo}" style="width: 100%; display:none">
						<form name="form3" action="boardReplySave" method="post">
							<input type="hidden" name="bno" value="${replylist.bNo}">
							<input type="hidden" name="reno">
							<input type="hidden" name="reparent" value="${replylist.reParent}">
					
							<textarea name="rememo" class="form-control" rows="2" cols="60" maxlength="500" placeholder="대댓글을 입력해주세요"></textarea>
							<div align="right">
								<a href="#" onclick="fn_replyReplySave('${replylist.reNo}')">저장</a>
								<a href="#" onclick="fn_replyReplyCancel('${replylist.reNo}')">취소</a>
							</div>
						</form>
					</div>				
	    		</td>

	    	</tr>
	    </table>
	</c:forEach>
</div>

<%-- 	<c:forEach var="replylist" items="${replylist}" varStatus="status">
	    <div style="border: 1px solid gray; width: 60%; padding: 5px; margin-top: 5px;
	          margin-left: <c:out value="${20*replylist.reDepth}"/>px; display: inline-block">   
	        <c:out value="${replylist.regDate}"/>
	        <a href="#" onclick="fn_replyReply('<c:out value="${replylist.reNo}"/>')">댓글</a>
	        <a href="#" onclick="fn_replyDelete('<c:out value="${replylist.reNo}"/>')">삭제</a>
	        <br/>
	        <div id="reply<c:out value="${replylist.reNo}"/>"><c:out value="${replylist.reMemo}"/></div>
	        
			<div id="replyDialog<c:out value="${replylist.reNo}"/>" style="width: 60%; display:none">
				<form name="form3" action="boardReplySave" method="post">
					<input type="hidden" name="bno" value="<c:out value="${replylist.bNo}"/>">
					<input type="hidden" name="reno">
					<input type="hidden" name="reparent">
			
					<textarea name="rememo" rows="3" cols="60" maxlength="500"></textarea>
					<a href="#" onclick="fn_replyReplySave('${replylist.reNo}')">저장</a>
					<a href="#" onclick="fn_replyReplyCancel('<c:out value="${replylist.reNo}"/>')">취소</a>
				</form>
			</div>
		        
	    </div><br/>
	   	  
	</c:forEach> --%>
	
</body> 
</html>
</body>
<script language="javascript" type="text/javascript"> 
	$(document).ready(function() {
		var img_title = $("#imgContent").attr('title');
		if(img_title == "") {
 			$("#divImgNot").show();
			$("#divImg").hide();
		}
		else {
			$("#divImgNot").hide();
			$("#divImg").show();
		}
	});

	function fn_replyReply(reno){ 
	    var reply =  $("#reply" +reno);
	    var replyDia = $("#replyDialog" +reno);
	    
	    replyDia.css("display","block");
	 
	    /* if (updateReno) {
	        fn_replyUpdateCancel();
	    } */
	   
	    $("#replyDialog" +reno).find("input[name=reparent]").val(reno);
	    $("#replyDialog" +reno +" textarea[name=rememo]").focus();
	}
	
	function fn_replyReplySave(reno) {
		var replyDia = $("#replyDialog" +reno);
		var rememo = replyDia.find("textarea[name=rememo]");
		var reparent = replyDia.find("input[name=reparent]");
		
		if(rememo.val() == "") {
			alert("대댓글을 입력해주세요.");
			rememo.focus();
	        return;
		}
		
		$.ajax({
		    url: "insertReply",
		    type: "POST",
		    cache: false,
		    dataType: "text",
		    data: "bNo=" + "${content.bNo}" + "&reMemo=" + rememo.val() +"&reParent=" + reparent.val(),
		    success: function(data){
		    	alert("댓글이 작성되었습니다.");
		    	location.href= "content?bNo=${content.bNo}";
		    },
		   
		    error: function (request, status, error){     
		    	alert("댓글 작성이 실패하였습니다.");
		    }
		 });
	}
	
	function fn_replyReplyCancel(reno){
		var div = $("#replyDialog" +reno);
	    div.css("display","none");
	}
	
	function fn_replySave() {
		reno = $("#replyreNo");
		rememo = $("#rememo");
		
		if(rememo.val() == "") {
			alert("대댓글을 입력해주세요.");
			rememo.focus();
	        return;
		}
		
		$.ajax({
		    url: "insertReply",
		    type: "POST",
		    cache: false,
		    dataType: "text",
		    data: "bNo=" + "${content.bNo}" + "&reNo=" + reno.val() +"&reMemo=" + rememo.val(),
		    success: function(data){
		    	alert("댓글이 작성되었습니다.");
		    	location.href= "content?bNo=${content.bNo}";
		    },
		   
		    error: function (request, status, error){     
		    	alert("댓글 작성이 실패하였습니다.");
		    }
		 });
	}
	
	function fn_replyDelete(reno, reparent) {
		$.ajax({
		    url: "deleteReply",
		    type: "POST",
		    cache: false,
		    dataType: "text",
		    data: "bNo=" + "${content.bNo}" + "&reNo=" + reno + "&reParent=" + reparent,
		    success: function(){
		    	alert("댓글이 삭제되었습니다.");
		    	location.href= "content?bNo=${content.bNo}";
		    },
		   
		    error: function (request, status, error){     
		    	alert("댓글 삭제가 실패하였습니다.");
		    }
		 });
	}
	
	function fnModify() {
		var img_title = $("#imgContent").attr('title');
		var title;
		var content;
		
		if(img_title == "") {
			title = $("#title").val();
			content = $("#content").val();
		}
		else {
			title = $("#titleImg").val();
			content = $("#contentImg").val();
		}
		
		if(title == "") {
			alert("제목을 입력하세요.");
			return false;
		}
		
		var confirmflag = confirm("수정하시겠습니까?");
		
		if(confirmflag){
			$.ajax({
			    url: "modify",
			    type: "POST",
			    cache: false,
			    dataType: "text",
			    data: "bNo=" + "${content.bNo}" + "&title=" + title +"&content=" + content,
			    success: function(data){
			    	alert("수정되었습니다.");
			    	location.href= "list?num=1";
			    },
			   
			    error: function (request, status, error){     
			    	alert("수정 실패하였습니다.");
			    }
			 });
		 }
	}
</script>
</html>