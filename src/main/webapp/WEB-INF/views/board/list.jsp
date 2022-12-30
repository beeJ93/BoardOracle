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
<link href="${path}/resources/css/boardList.css" rel="stylesheet"/> 
<style type="text/css">
.pageInfo{
      list-style : none;
      display: inline-block;
    margin: 50px 0 0 100px;      
  }
  .pageInfo li{
      float: left;
    font-size: 20px;
    margin-left: 18px;
    padding: 7px;
    font-weight: 500;
  }
 a:link {color:black; text-decoration: none;}
 a:visited {color:black; text-decoration: none;}
 a:hover {color:black; text-decoration: underline;}
</style>	
</head>
<body>
	<h1>목록페이지입니다.</h1>
	<a href="/board/enroll">게시판 등록</a>
	<table>
		<thead>
			<tr>
				<th class="bno_width">번호</th>
				<th class="title_width">제목</th>
				<th class="writer_width">작성자</th>
				<th class="regdate_width">작성일</th>
				<th class="updatedate_width">수정일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="list">
	            <tr>
	                <td><c:out value="${list.bno}"/></td>
	                <td>
	                	<a class="move" href='<c:out value="${list.bno}"/>'>
	                        <c:out value="${list.title}"/>
	                    </a>
	                </td>
	                <td><c:out value="${list.writer}"/></td>
	                <td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.regdate}"/></td>
                	<td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.updateDate}"/></td>
	            </tr>
	        </c:forEach>
		</tbody>
	</table>
	<div class="pageInfo_wrap" >
        <div class="pageInfo_area">
        	 <ul id="pageInfo" class="pageInfo">
				<c:if test="${pageMaker.prev}">
					<li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage}"
					end="${pageMaker.endPage}">
					<li class="pageInfo_btn"><a href="${num}">${num}</a></li>
				</c:forEach>
				<c:if test="${pageMaker.next}">
					<li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
				</c:if>
			</ul>
        </div>
    </div>
	<form id="moveForm" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
    </form>
	<script>
	    $(document).ready(function(){	    
	    	let result = '<c:out value="${result}"/>';
	    	checkAlert(result);
	    	function checkAlert(result){
	    		if(result === ''){
	    			return;
	    		}
	    		if(result === "enroll success"){
	    			alert("등록이 완료되었습니다.");
	    		}
	    		if(result === "modify success"){
	                alert("수정이 완료되었습니다.");
	            }
	    		if(result === "delete success"){
	                alert("삭제가 완료되었습니다.");
	            }
	    	}
	    });
	    
	    let moveForm = $("#moveForm");
	    $(".move").on("click", function(e){
	    	e.preventDefault();
	    	moveForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
	    	moveForm.attr("action", "/board/get");
	    	moveForm.submit();
	    })
	    $(".pageInfo a").on("click", function(e){
	    	e.preventDefault();
	    	moveForm.find("input[name='pageNum']").val($(this).attr("href"));
	    	moveForm.attr("action", "/board/list");
	    	moveForm.submit();
	    });
	</script>
</body>
</html>