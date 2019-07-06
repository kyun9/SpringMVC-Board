<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.NewsVO, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
h1 {
	text-align: center;
	text-shadow: 6px 2px 2px silver;
}

body {
	margin: 0 auto;
	width: 60%;
}

th {
	border: 2px solid black;
}

td {
	border-bottom: 1px dotted black;
	width: 200px;
	text-align: center;
}

tr:hover {
	background-color: silver;
	font-weight: bold;
}

td:nth-child(2) {
	width: 400px;
	text-align: left;
}

a {
	text-decoration: none;
}

a:visited {
	color: black;
}

</style>
</head>
<body>
	<h1>뉴스 게시판</h1>
	<%
		ArrayList<NewsVO> list = null;
		if (request.getAttribute("search") != null) {
			list = (ArrayList<NewsVO>) request.getAttribute("search");
		}
		if (request.getAttribute("listwriter") != null) {
			list = (ArrayList<NewsVO>) request.getAttribute("listwriter");
		} else if (request.getAttribute("list") != null) {
			list = (ArrayList<NewsVO>) request.getAttribute("list");
		}
		if (!list.isEmpty()) {
	%>
	<hr>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<%
			for (NewsVO vo : list) {
		%>
		<tr>
			<td><%=vo.getId()%></td>
			<td><a href='/springnews/news?action=read&newsid=<%=vo.getId()%>'><%=vo.getTitle()%></a></td>
			<td><a
				href='/springnews/news?action=listwriter&writer=<%=vo.getWriter()%>'><%=vo.getWriter()%></a></td>
			<td><%=vo.getWritedate()%></td>
			<td><%=vo.getCnt()%></td>
		</tr>
		<%
			}
		%>
	</table>
	<%
		} else {
	%>
	<script>
		alert("찾는 내용이 없습니다.");
		document.location.href="/springnews/news";
	</script>
	<%
		}
		if (request.getAttribute("msg") != null) {
	%>
	<script>
		alert("${msg}");
		document.location.href="/springnews/news";
	</script>
	<%
		}
	%>
	<br>
	<div align="center">
		<form method="get" action="/springnews/news">
			<select name="searchType">
				<option value="title">제목</option>
				<option value="id">번호</option>
				<option value="writer">작성자</option>
			</select> <input type="hidden" name="action" value="search"> <input
				type="text" name="key"> <input type="submit" value="뉴스검색">
		</form>
	</div>
	<br>
	<div align="center">
		<button onclick="moveHome()">뉴스 홈으로</button>
		<button onclick="displayDiv(1)">뉴스 작성</button>
	</div>
	<br>
	<script>
		function displayDiv(type){
			if(type==1)
				document.getElementById("write").style.display="block";
			else if(type==2)
				document.getElementById("write").style.display="none";
			else if(type==3)
				document.getElementById("search").style.display="none";
		}
		function deleteNews(id){
			location.href="/springnews/news?action=delete&newsid="+id;
		}
		function moveHome(){
			location.href="/springnews/news";
		}
		
	</script>
	<div id="write" style="display: none" align="center">
		<form method="post" action="/springnews/news">
			<input type="hidden" name="action" value="insert"> <input
				type="text" name="writer" placeholder="작성자명을 입력해주세요." required size=48><br>
			<input type="text" name="title" placeholder="제목을 입력해주세요" required size=48><br>
			<textarea cols="50" rows="8" name="content" required placeholder="내용을 입력해주세요."></textarea>
			<br> <input type="submit" value="저장"> <input
				type="reset" value="재작성"> <input type="button"
				onclick="displayDiv(2); return false;" value="취소">
		</form>
	</div>
	<%
		if (request.getAttribute("listone") != null) {
			NewsVO one = (NewsVO) request.getAttribute("listone");
	%>
	<div id="search" align="center">
		<h2>뉴스 내용</h2>
		<form method="post" action="/springnews/news">
			<input type="hidden" name="action" value="update"> <input
				type="hidden" name="id" value=<%=one.getId()%>> <input
				type="text" name="writer" value=<%=one.getWriter()%> size=48><br>
			<input type="text" name="title" value=<%=one.getTitle()%> size=48><br>
			<textarea cols="50" rows="8" name="content"><%=one.getContent()%></textarea>
			<br> <input type="button" value="확인"
				onclick="displayDiv(3); return false;"> <input type="submit"
				value="수정"> <input type="button"
				onclick="deleteNews(<%=one.getId()%>)" value="삭제">
		</form>
	</div>
	<%
		}
	%>
</body>
</html>