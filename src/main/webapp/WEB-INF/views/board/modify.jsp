<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<link href="${path}/resources/css/board.css" rel="stylesheet"/> 	
</head>
<body>
	<h1>수정 페이지</h1>
	<form id="modifyForm" action="/board/modify" method="post">
		<div class="input_wrap">
			<label>게시판 번호</label>
			<input name="bno" readonly="readonly" value="<c:out value="${pageInfo.bno}" />">
		</div>
		<div class="input_wrap">
			<label>Title</label>
			<input name="title" value="<c:out value="${pageInfo.title}" />">
		</div>
		<div class="input_wrap">
			<label>Content</label>
			<textarea rows="3" name="content"><c:out value="${pageInfo.content}" /></textarea>
		</div>
	    <div class="input_wrap">
	        <label>Writer</label>
	        <input name="writer" value="<c:out value="${pageInfo.writer}" />">
	    </div>
	    <div class="input_wrap">
	        <label>등록일</label>
	        <input name="regdate" readonly="readonly" value="<fmt:formatDate pattern="yyyy/MM/dd" value="${pageInfo.regdate}"/>">
	    </div>
	    <div class="input_wrap">
	        <label>수정일</label>
	        <input name="updateDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy/MM/dd" value="${pageInfo.updateDate}"/>">
	    </div>
	    <div class="btn_wrap">
	        <a class="btn" id="list_btn">목록 페이지</a>
	        <a class="btn" id="modify_btn">수정 완료</a>
	        <a class="btn" id="delete_btn">삭제</a>
	        <a class="btn" id="cancel_btn">수정 취소</a>
	    </div>	    	
	</form>	
	<form id="infoForm" method="get" action="/board/modify">
		<input type="hidden" id="bno" name="bno" value="<c:out value="${pageInfo.bno}" />">
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
		<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
		<input type="hidden" name="keyword" value="${cri.keyword}">    
    </form>
	<script>
	    let form = $("#infoForm");
	    let mFrom = $("#modifyForm");
	    
	    //목록페이지로 이동
	    $("#list_btn").on("click", function(e){
	    	form.find("#bno").remove();
	    	form.attr("action", "/board/list");
	    	form.submit();
	    })
	    
	    //수정하기
	    $("#modify_btn").on("click", function(e){
	    	mFrom.submit();
	    })
	    
	    //취소
	    $("#cancel_btn").on("click", function(e){
	    	form.attr("action", "/board/get");
	    	form.submit();
	    })
	     //삭제
	    $("#delete_btn").on("click", function(e){
	    	form.attr("action", "/board/delete");
	    	form.attr("method", "post");
	    	form.submit();
	    })
	</script>
</body>
</html>