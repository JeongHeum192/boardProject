<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
<meta charset="utf-8"> 
<script src="https://code.jquery.com/jquery-3.5.1.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> 
<title>게시판 조회</title> 
</head>
<body>

<input type="hidden" name="bNo" value="${content.bNo}">
<div id="divImg">
<table class="table table-striped" style="width: 60%;"> 
	<div align="center" style="width: 60%;"><h3><b>게시글 조회</b></h3></div> 
		<colgroup>
			<col style="width:40%">
			<col style="width:10%">
			<col style="width:50%">
		</colgroup>
		<tr > 
			<td rowspan='3'><img src="../save/${content.photoname}" id="imgContent" title="${content.photoname}" style="width:400px; height:300px"></td>
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
				<button onclick="javascript:history.back();" class="btn btn-info">취소</button>
			</td>
		</tr> 
</table> 
</div>

<div id="divImgNot">
<table class="table table-striped" style="width: 60%;"> 
	<div align="center" style="width: 60%;"><h3><b>게시글 조회</b></h3></div> 
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
				<button onclick="javascript:history.back();" class="btn btn-info">취소</button>
			</td>
		</tr> 
</table> 
</div>
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
			    	//alert("수정 실패하였습니다.");
			    	alert(request + status + error);
			    }
			 });
		 }
	}
</script>
</html>