<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster - Update Account</title>
    <link rel="stylesheet" type="text/css" href="/css/style2.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

    <main>
        <div class="container d-flex justify-content-center py-5">
            <div class="col-md-6 mb-4">
                <h2 class="mb-3 text-center">Account Info</h2>
                
                <!-- Use Spring form tag -->
                <form:form method="post" action="/account/updateAccount" modelAttribute="user">
    <div class="mb-3">
        <form:input type="hidden" path="id" value="${user.id}" />
        <form:input type="hidden" path="password" value="${user.password}" /> <!-- Pass the current password as hidden -->
        <label for="username" class="form-label">Username:</label>
        <form:input class="form-control" id="username" path="username" />
        <form:errors path="username" class="error"/>
    </div>

    <div class="mb-3">
        <label for="email" class="form-label">Email:</label>
        <form:input class="form-control" id="email" path="email" />
        <form:errors path="email" class="error"/>
    </div>

    <button type="submit" class="btn btn-primary w-100">Update</button>
</form:form>
                
            </div>
        </div>
    </main>

    <footer class="bg-dark text-white text-center py-3 mt-4">
        <p>&copy; 2024 QuizMaster. All Rights Reserved.</p>
        <p>
            <a href="#" class="text-white text-decoration-underline">Terms of Service</a> |
            <a href="#" class="text-white text-decoration-underline">Privacy Policy</a>
        </p>
    </footer>
</body>
</html>


    