<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${quiz.title} - Quiz App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/css/style2.css">
    
    <style>
        .quiz-container {
            max-width: 800px;
            margin: 0 auto;
            padding-top: 20px;
        }
        .quiz-header {
            margin-bottom: 30px;
        }
        .form-check-label {
            font-size: 1.1rem;
        }
        .form-check-input {
            margin-right: 10px;
        }
        .submit-btn {
            width: 100%;
            padding: 10px;
            font-size: 1.2rem;
        }
    </style>
</head>
<body class="bg-light">
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
    <div class="container quiz-container">
        <div class="card shadow-sm">
            <div class="card-body">
                <h2 class="quiz-header text-center">${quiz.title}</h2>
                <form action="/quiz/${quiz.id}/submit" method="POST">
                    <c:forEach var="question" items="${quiz.questions}">
                        <div class="mb-4">
                            <label class="form-label h5">${question.content}</label>
                            
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="question-${question.id}" value="A" required>
                                <label class="form-check-label">${question.optionA}</label>
                            </div>
                            

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="question-${question.id}" value="B">
                                <label class="form-check-label">${question.optionB}</label>
                            </div>
                            
                            <c:if test="${not empty question.optionC}">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="question-${question.id}" value="C">
                                    <label class="form-check-label">${question.optionC}</label>
                                </div>
                            </c:if>
                            
                            
                            <c:if test="${not empty question.optionD}">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="question-${question.id}" value="D">
                                    <label class="form-check-label">${question.optionD}</label>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                   
                    <button type="submit" class="btn btn-primary submit-btn">Submit Quiz</button>
                </form>
            </div>
        </div>
    </div>
    <footer class="bg-dark text-white text-center py-3">
        <p>&copy; 2024 QuizMaster. All Rights Reserved.</p>
        <p>
            <a href="#" class="text-white text-decoration-underline">Terms of Service</a> |
            <a href="#" class="text-white text-decoration-underline">Privacy Policy</a>
        </p>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


    