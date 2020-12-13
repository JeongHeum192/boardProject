<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="utf-8"> 
<script src="https://code.jquery.com/jquery-3.5.1.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> 
<title>게시판 글쓰기</title> 
</head> 

<body> 
<form action="write" method="post" enctype="multipart/form-data"> 
<table class="table table-striped" style="width: 60%;"> 
	<div align="center" style="width: 60%;">
		<h3><b>글쓰기</b></h3>
		<div align="left"><b style="color:red;">작성자, 제목은 필수값입니다.</b></div>
	</div> 
	<colgroup>
		<col style="width:10%">
		<col style="width:90%">
	</colgroup>
	<tr> 
		<th>작성자</th> 
		<td> <input type="text" name="writer" id="writer" class="form-control input-sm"> </td> 
	</tr> 
	<tr> 
		<th>제목</th> 
		<td> <input type="text" name="title" id="title" class="form-control input-sm" > </td> 
	</tr> 
	<tr> 
		<th>첨부파일</th> 
		<td> <input type="file" name="photo" id="photo" class="form-control input-sm" > </td> 
	</tr> 
	<tr> 
		<td colspan="2"> <textarea style="height: 150px;" name="content" class="form-control"> </textarea> </td> 
	</tr> 
	<tr> 
		<td colspan="2" align="right"> 
			<button type="submit" onclick="return fnWrite();" class="btn btn-info">저장</button> 
			<input type="button" value="취소" onclick="javascript:history.back();" class="btn btn-info">
		</td>
	</tr> 
</table> 
</form> 
</body> 
<script language="javascript" type="text/javascript"> 
	function fnWrite() {
		if(validate()) {
			var confirmflag = confirm("저장하시겠습니까?");
			if(confirmflag){
				return true;
			}
			else {
				return false;
			}
		}
		return false;
	}
	
	function validate() {
		if($("#writer").val() == "") {
			alert("작성자를 입력하세요.");
			return false;
		}
		
		if($("#title").val() == "") {
			alert("제목을 입력하세요.");
			return false;
		}
		return true;
	}
</script>
</html>