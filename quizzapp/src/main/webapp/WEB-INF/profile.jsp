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
<h1 style="
    place-self: center;
">Welcome, ${user.username}!</h1>
<a href="/account/edit" style="place-self: center;">Edit Your Information</a>
<div id="card" style="width: 60%; margin: auto;">
    <!-- Created Quizzes Section -->
    <h2>Created Quizzes</h2>
    <table class="table">
        <thead>
            <tr>
                <th>Quiz Title</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="quiz" items="${quizzList}">
                <tr>
                    <td>${quiz.title}</td>
                    <td>${quiz.createdAt}</td>
                    <td style="display:flex;">
                    	<a href="/quizzes/${quiz.id}/details" class="btn btn-primary btn-sm" style="height: fit-content;">View</a>
                    	<form action="/quizzes/delete/${quiz.id}" method="post" onsubmit="return confirm('Are you sure?');">
    					<button type="submit" class="btn btn-danger btn-sm">Delete</button>
						</form>
                    	
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- Pagination for Created Quizzes -->
    <div class="card-footer d-flex justify-content-between align-items-center">
        <c:if test="${totalPages > 1}">
            <nav>
                <ul class="pagination mb-0">
                    <!-- Previous Button -->
                    <li class="page-item <c:if test='${currentPage == 0}'>disabled</c:if>'">
                        <a class="page-link" href="/profile?page=${currentPage - 1}&size=3">Previous</a>
                    </li>
                    <!-- Page Numbers -->
                    <c:forEach begin="0" end="${totalPages - 1}" var="pageNum">
                        <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                            <a class="page-link" href="/profile?page=${pageNum}&size=3">${pageNum + 1}</a>
                        </li>
                    </c:forEach>
                    <!-- Next Button -->
                    <li class="page-item <c:if test='${currentPage == totalPages - 1}'>disabled</c:if>'">
                        <a class="page-link" href="/profile?page=${currentPage + 1}&size=2">Next</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>

    <!-- Quiz Results Section -->
    <h2>Your Quiz Results</h2>
    <table class="table">
            <thead>
                <tr>
                    <th>Quiz Title</th>
                    <th>Creator</th>
                    <th>Max Score</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="result" items="${results}">
                    <tr>
                        <td>${result.quiz.title}</td>
                        <td>${result.quiz.creator.username}</td>
                        <td>${maxScores[result.quiz]}/${result.quiz.numQuestions}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    <!-- Pagination for Quiz Results -->
    <div class="card-footer d-flex justify-content-between align-items-center">
    <c:if test="${resultsTotalPages > 1}">
        <nav>
            <ul class="pagination mb-0">
                <!-- Previous Button -->
                <li class="page-item ${resultsCurrentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link" href="/profile?resultsPage=${resultsCurrentPage - 1}&resultsSize=3">Previous</a>
                </li>
                <!-- Page Numbers -->
                <c:forEach begin="0" end="${resultsTotalPages - 1}" var="pageNum">
                    <li class="page-item ${pageNum == resultsCurrentPage ? 'active' : ''}">
                        <a class="page-link" href="/profile?resultsPage=${pageNum}&resultsSize=3">${pageNum + 1}</a>
                    </li>
                </c:forEach>
                <!-- Next Button -->
                <li class="page-item ${resultsCurrentPage == resultsTotalPages - 1 ? 'disabled' : ''}">
                    <a class="page-link" href="/profile?resultsPage=${resultsCurrentPage + 1}&resultsSize=3">Next</a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>
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
