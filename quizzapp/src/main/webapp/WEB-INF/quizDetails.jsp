<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Quiz</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/style2.css">

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.9/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script>
        function copyQuizCode() {
            const code = document.getElementById("quizCode").innerText;
            navigator.clipboard.writeText(code).then(() => {
                alert("Quiz code copied to clipboard!");
            }).catch(error => {
                alert("Error copying the quiz code: " + error);
            });
        }

        function sendQuizCode() {
            const quizCode = document.getElementById("quizCode").innerText;
            const email = prompt("Enter the email address to send the code to:");
            if (email) {
                $.ajax({
                    url: '/sendQuizCode',
                    method: 'POST',
                    data: { email: email, quizCode: quizCode },
                    success: () => alert("Quiz code sent via email!"),
                    error: () => alert("Error sending the quiz code via email!"),
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

<div class="container mt-5">
    <h2 class="mb-4">Edit Quiz</h2>
    <form:form method="post" action="/quizzes/${quiz.id}/update" modelAttribute="quiz" class="needs-validation">
        <div class="row">
            <div class="col-md-6 form-group">
                <label for="quizName" class="font-weight-bold">Quiz Name:</label>
                <form:input path="title" id="quizName" class="form-control" />
                <form:errors path="title" cssClass="text-danger small" />
            </div>
            <div class="col-md-6 form-group">
                <label for="isPrivate" class="font-weight-bold">Privacy:</label>
                <form:select path="isPrivate" id="isPrivate" class="form-control">
                    <form:option value="false">Public</form:option>
                    <form:option value="true">Private</form:option>
                </form:select>
                <form:errors path="isPrivate" cssClass="text-danger small" />
            </div>
        </div>

        <div class="form-group">
            <label for="category" class="font-weight-bold">Category:</label>
            <form:select path="category.id" id="category" class="form-control">
                <form:options items="${categories}" itemValue="id" itemLabel="name" />
            </form:select>
            <form:errors path="category.id" cssClass="text-danger small" />
        </div>

        <div class="form-group">
            <label for="description" class="font-weight-bold">Description:</label>
            <form:textarea path="description" id="description" rows="4" class="form-control"></form:textarea>
            <form:errors path="description" cssClass="text-danger small" />
        </div>

        <div class="form-group">
            <label for="language" class="font-weight-bold">Language:</label>
            <form:input path="language" id="language" class="form-control" placeholder="e.g., English" />
            <form:errors path="language" cssClass="text-danger small" />
        </div>

        <div class="form-group">
            <label class="font-weight-bold">Quiz Code:</label>
            <a class="btn btn-warning" href="/quizzes/${quiz.id}/viewCode" role="button">Link</a>
        </div>

        <h3 class="mt-4">Questions:</h3>
        <c:forEach var="question" items="${quiz.questions}">
            <div class="mb-4 p-3 border rounded">
                <h5>${question.content}</h5>
                <div class="form-check">
                    <input class="form-check-input" type="radio" disabled>
                    <label class="form-check-label">${question.optionA}</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" disabled>
                    <label class="form-check-label">${question.optionB}</label>
                </div>
                <c:if test="${not empty question.optionC}">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" disabled>
                        <label class="form-check-label">${question.optionC}</label>
                    </div>
                </c:if>
                <c:if test="${not empty question.optionD}">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" disabled>
                        <label class="form-check-label">${question.optionD}</label>
                    </div>
                </c:if>
                <label class="form-check-label">Correct Answer: ${question.correctAnswer}</label>
            </div>
        </c:forEach>

        <button type="submit" class="btn btn-primary">Update Quiz</button>
    </form:form>
</div>

<footer class="bg-dark text-white text-center py-3 mt-5">
    <p>&copy; 2024 QuizMaster. All Rights Reserved.</p>
    <p>
        <a href="#" class="text-white text-decoration-none">Terms of Service</a> | 
        <a href="#" class="text-white text-decoration-none">Privacy Policy</a>
    </p>
</footer>
</body>
</html>



