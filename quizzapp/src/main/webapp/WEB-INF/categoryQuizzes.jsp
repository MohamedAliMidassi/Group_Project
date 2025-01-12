<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
<head>
    <title>${category.name} - Quizzes</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/style2.css">
    
</head>
<body>
  <header>
        <h1>QuizMaster</h1>
	 <nav>
	    <a href="/home">Home</a>
	    <a href="/profile">Profile</a>
	    <a href="/take-quizz">TakeQuizz</a>
	    <a href="/quiz/create">CreateQuizz</a>
	
	    <!-- Categories Dropdown -->
	    <div class="dropdown">
	        <a href="#" class="dropdown-toggle">Categories</a>
	        <ul class="dropdown-menu">
	            <c:forEach var="category" items="${categories}">
	                <li>
	                    <a href="/category/${fn:replace(category.name, ' ', '%20')}">${category.name}</a>
	                </li>
	            </c:forEach>
	        </ul>
	    </div>
	
	    <a href="/logout">Logout</a>
	</nav>

    </header>
    <h1 style="
    align-self: center;
">Category: General Knowledge</h1>

    <div class="container">
        <h2>Quizzes in this Category</h2>
        <c:if test="${empty quizzes}">
            <p>No quizzes found for this category.</p>
        </c:if>
        <c:if test="${!empty quizzes}">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="quiz" items="${quizzes}">
                        <tr>
                            <td>${quiz.title}</td>
                            <td>${quiz.description}</td>
                            <td>${quiz.createdAt}</td>
                            <td>
                                <a href="/quiz/${quiz.id}" class="btn btn-primary">Take</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>

    <footer style="margin-top: auto;">
        <p>&copy; 2024 QuizMaster. All rights reserved.</p>
    </footer>
</body>
</html>
