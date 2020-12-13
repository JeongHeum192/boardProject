<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html> 
<head> 
<meta charset="utf-8"> 
<script src="https://code.jquery.com/jquery-3.5.1.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> 
<title>게시판 리스트</title> 
</head> 
<body> 
<hr> 
<div class="container"> 
<div align="left">
	<button type="button" class="btn btn-info" onclick="location.href='write'" style="margin-bottom: 1%;">글쓰기</button> 
</div>
<table class="table table-bordered" style="width: 80%;" > 
<style>
	th {
		text-align: center; 
	}
	td {
		text-align: center; 
	}
</style>
	<tr> 
		<th width="5%">번호</th> 
		<th width="30%">제목</th> 
		<th width="15%">작성자</th> 
		<th width="20%">작성일</th> 
		<th width="20%">수정일</th> 
		<th width="10%">작업</th> 
	</tr> 
	<c:forEach items="${list}" var="dto">
	<tr> 	  
		<td>${dto.bNo}</td> 
		<td><a href="content?bNo=${dto.bNo}">${dto.title }</a></td> 
		<td>${dto.writer }</td> 
		<td><fmt:formatDate value="${dto.regDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td> 
		<td><fmt:formatDate value="${dto.updDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td> 
		<td><button type="button" id="btnDelete" class="btn btn-info" onclick="fnDelete(${dto.bNo});">X</button></td>
		<!--<td><button type="button" id="btnDelete" class="btn btn-info" onclick="location.href='delete?bNo=${dto.bNo}'">X</button></td> -->
	</tr> 
	</c:forEach> 
</table> 
<div>
 <c:forEach begin="1" end="${pageNum}" var="num">
    <span>
     <a href="listPage?num=${num}">${num}</a>
  </span>
 </c:forEach>
</div>
</div> 
</body> 

<script language="javascript" type="text/javascript"> 	
	function fnDelete(bno) {
		var confirmflag = confirm("삭제하시겠습니까?");
			
		if(confirmflag){
			$.ajax({
			    url: "delete",
			    type: "POST",
			    cache: false,
			    dataType: "text",
			    data: "bNo=" + bno,
			    success: function(data){
			    	alert("삭제되었습니다.");
			    	location.href= "list";
			    },
			   
			    error: function (request, status, error){     
			    	alert("삭제 실패하였습니다.");
			    }
			  	});		 
		 }
		
	}
</script>
</html>
