<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>QuizMaster</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/style2.css">
    <link rel="stylesheet" type="text/css" href="/css/NFstyle.css"> <!-- You can include the same style as on home -->
            <style>

    </style>
</head>

<body>
    <!-- Header and Navigation -->
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

    <main class="card">
        <div class="card-header text-center bg-primary text-white">
            <h3>Take a Quiz and Test Your Knowledge</h3>
        </div>
        <div class="card-body">
            <p class="card-text">
                Dive into our Take Quiz section, where a world of exciting categories awaits! Explore a variety of
                topics, each filled with multiple quizzes designed to challenge and entertain. Whether you’re passionate
                about science, history, pop culture, or any other subject, there's something here for everyone.
            </p>
            <p class="card-text">
                Each quiz is tailored to your preferred difficulty level—Easy, Hard, or Challenge—providing a
                personalized experience for every participant. After completing a quiz, your score will be shown
                instantly, giving you the opportunity to track your progress and strive for an even higher score.
            </p>
            <div class="d-flex justify-content-center gap-2">
                <a href="/all-quizzes" class="btn btn-primary" style="margin-right: 20px;">See all quizzes</a>
                 <br>
                <a href="/private" class="btn btn-primary">Take private Quizz</a>
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