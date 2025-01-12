<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
<head>
    <title>User Dashboard</title>
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

    <div class="mt-4">
            <h3>Enter Code for Private Quiz</h3>
            <form action="/quiz/access" method="get">
                <div class="form-group">
                    <label for="quizCode">Quiz Code</label>
                    <input type="text" class="form-control" id="quizCode" name="code" placeholder="Enter the quiz code" required />
                </div>
                <button type="submit" class="btn btn-secondary">Access Quiz</button>
            </form>
        </div>
	<footer class="bg-dark text-white text-center py-3 mt-4">
        <p>&copy; 2024 QuizMaster. All Rights Reserved.</p>
        <p>
            <a href="#" class="text-white text-decoration-underline">Terms of Service</a> |
            <a href="#" class="text-white text-decoration-underline">Privacy Policy</a>
        </p>
    </footer>
</body>
</html>
    