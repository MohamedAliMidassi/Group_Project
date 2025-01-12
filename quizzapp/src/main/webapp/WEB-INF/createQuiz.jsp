<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Quiz</title>
    <link rel="stylesheet" type="text/css" href="/css/style2.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            margin: 0;
        }

        .form-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 540px;
            margin: auto;
            margin-top: 30px;
    		margin-bottom: 30px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
        }

        .error {
            color: red;
            font-size: 0.875em;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1em;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .form-group:last-child {
            margin-bottom: 0;
        }
    </style>
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


    <div class="form-container">
        <h2>Create a New Quiz</h2>
        <form:form method="POST" action="/quiz/create" modelAttribute="newQuiz">

            <div class="form-group">
                <label for="quizName">Quiz Name:</label>
                <form:input path="title" id="quizName" type="text" />
                <form:errors path="title" cssClass="error"/>
            </div>

            <div class="form-group">
                <label>Difficulty:</label>
                <form:select path="difficulty">
                    <form:option value="easy">Easy</form:option>
                    <form:option value="medium">Medium</form:option>
                    <form:option value="hard">Hard</form:option>
                    <form:option value="challenge">Challenge</form:option>
                </form:select>
                <form:errors path="difficulty" cssClass="error"/>
            </div>

            <div class="form-group">
                <label>Privacy:</label>
                <form:select path="isPrivate">
                    <form:option value="false">Public</form:option>
                    <form:option value="true">Private</form:option>
                </form:select>
                <form:errors path="isPrivate" cssClass="error"/>
            </div>

            <div class="form-group">
                <label for="category">Category:</label>
                <form:select path="category.id">
                    <form:options items="${categories}" itemValue="id" itemLabel="name" />
                </form:select>
                <form:errors path="category" cssClass="error"/>
            </div>

            <div class="form-group">
                <label for="languages">Language:</label>
                <form:select path="language">
                    <form:option value="EN">English</form:option>
                    <form:option value="FR">French</form:option>
                    <form:option value="AR">Arabic</form:option>
                </form:select>
                <form:errors path="language" cssClass="error"/>
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <form:textarea path="description" id="description" rows="4" cols="50"></form:textarea>
                <form:errors path="description" cssClass="error"/>
            </div>

            <div>
                <button type="submit" class="btn btn-primary">Create Quiz</button>
            </div>

        </form:form>
    </div>
    <footer class="bg-dark text-white text-center py-3">
        <p>&copy; 2024 QuizMaster. All Rights Reserved.</p>
        <p>
            <a href="#" class="text-white text-decoration-underline">Terms of Service</a> |
            <a href="#" class="text-white text-decoration-underline">Privacy Policy</a>
        </p>
    </footer>

</body>
</html>
