<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Questions to Quiz</title>
    <link rel="stylesheet" type="text/css" href="/css/style2.css">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
        }

        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 690px;
            max-height: 80vh; 
            overflow-y: auto; 
            margin: auto;
            margin-top: 30px;
            margin-bottom: 30px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .question-block {
            background-color: #f9f9f9;
            padding: 15px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .question-block h4 {
            color: #007bff;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
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
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        @media (max-width: 600px) {
            .form-container {
                padding: 15px;
            }

            button {
                padding: 10px;
            }
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
        <h2>Add Questions for Quiz: ${quiz.title}</h2>
        <!-- Form for adding questions -->
        <form:form action="/quiz/${quiz.id}/add-question" method="POST" modelAttribute="quiz">
            <c:forEach begin="1" end="${quiz.numQuestions}" var="i">
                <div class="question-block">
                    <h4>Question ${i}</h4>

                    <!-- Question Content -->
                    <div class="form-group">
                        <form:label path="questions[${i - 1}].content">Question:</form:label>
                        <form:input path="questions[${i - 1}].content" value="${questions[i - 1].content}" required="true" />
                    </div>

                    <!-- Option A -->
                    <div class="form-group">
                        <form:label path="questions[${i - 1}].optionA">Option A:</form:label>
                        <form:input path="questions[${i - 1}].optionA" value="${questions[i - 1].optionA}" required="true" />
                    </div>

                    <!-- Option B -->
                    <div class="form-group">
                        <form:label path="questions[${i - 1}].optionB">Option B:</form:label>
                        <form:input path="questions[${i - 1}].optionB" value="${questions[i - 1].optionB}" required="true" />
                    </div>

                    <!-- Option C -->
                    <div class="form-group">
                        <form:label path="questions[${i - 1}].optionC">Option C:</form:label>
                        <form:input path="questions[${i - 1}].optionC" value="${questions[i - 1].optionC}" />
                    </div>

                    <!-- Option D -->
                    <div class="form-group">
                        <form:label path="questions[${i - 1}].optionD">Option D:</form:label>
                        <form:input path="questions[${i - 1}].optionD" value="${questions[i - 1].optionD}" />
                    </div>

                    <!-- Correct Answer -->
                    <div class="form-group">
                        <form:label path="questions[${i - 1}].correctAnswer">Correct Answer:</form:label>
                        <form:input path="questions[${i - 1}].correctAnswer" value="${questions[i - 1].correctAnswer}" required="true" />
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                </div>
            </c:forEach>

            <button type="submit">Submit Questions</button>
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

