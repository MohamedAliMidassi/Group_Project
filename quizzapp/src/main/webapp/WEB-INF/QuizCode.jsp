<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizMaster</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" type="text/css" href="/css/style2.css">
    <script>
        // Copy to clipboard function
        function copyQuizCode() {
            var code = document.getElementById("quizCode").innerText;
            navigator.clipboard.writeText(code).then(function() {
                alert("Quiz code copied to clipboard!");
            }).catch(function(error) {
                alert("Error copying the quiz code: " + error);
            });
        }

        // Send Quiz Code via Email (AJAX function)
       function sendQuizCode() {
        var quizCode = document.getElementById("quizCode").innerText;
        var email = prompt("Enter the email address to send the code to:");

        if (email) {
            $.ajax({
                url: '/sendQuizCode', 
                method: 'POST',
                data: { email: email, quizCode: quizCode },
                error: function() {
                	alert("Quiz code sent via email!");
                }
            });
        }
    }

    </script>
    
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

    <main class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header text-center bg-primary text-white">
                        <h4>Quiz Code Details</h4>
                    </div>
                    <div class="card-body">
                        <p class="card-text">Here you can share your quiz code with others</p>
                        <div class="mb-3">
                            <label class="form-label">Quiz Code</label>
                            <p id="quizCode" class="form-control">${quiz.code}</p>
                        </div>
                        <div class="d-flex justify-content-center gap-3">
                            <button type="button" class="btn btn-primary" onclick="copyQuizCode()">Copy</button>
                            <button type="button" class="btn btn-primary" onclick="sendQuizCode()">Send by Email</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="bg-dark text-white text-center py-3 mt-4">
        <p>&copy; 2024 QuizMaster. All Rights Reserved.</p>
        <p>
            <a href="#" class="text-white text-decoration-none">Terms of Service</a> | 
            <a href="#" class="text-white text-decoration-none">Privacy Policy</a>
        </p>
    </footer>
</body>

</html>
