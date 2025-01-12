<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Categories  -->


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- Categories  -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/style2.css">
        <link rel="stylesheet" type="text/css" href="/css/NF.css"> <!-- You can include the same style as on home -->
    
    
    <style>
    @charset "UTF-8";

/* General styles */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    min-height: 100vh; /* Ensure the body takes the full height of the viewport */
}

header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1000;
    background-color: #343a40; /* Dark background for the header */
    color: white;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* Shadow for better visibility */
}

header h1 {
    margin: 0;
}

header nav a {
    color: white;
    text-decoration: none;
    margin-left: 10px;
}

main {
    flex: 1; /* Allow the main content to expand and push the footer down */
    padding-top: 60px; /* Space for the fixed header */
}

footer {
    margin-top: auto; /* Push the footer to the bottom */
    background-color: #343a40;
    color: white;
    text-align: center;
    padding: 15px 0;
}

footer a {
    color: white;
    text-decoration: underline;
}

.slideshow-container {
    position: relative;
    text-align: center;
    max-width: 40%;  
    margin: 0 auto;
}

.slide {
    display: none;
    width: 100%;
    height: 300px; 
    position: relative;
    overflow: hidden;  
}

.slide img {
    display: block;
    margin: 0 auto; 
    max-width: 100%;  
    max-height: 100%;  
}

.slide-btn {
    position: absolute;
    top: 50%;
    z-index: 10;
    background: rgba(0, 0, 0, 0.5);
    color: white;
    border: none;
    padding: 10px;
    cursor: pointer;
    border-radius: 50%;
}

.slide-btn.left {
    left: 10px;
}

.slide-btn.right {
    right: 10px;
}

.caption {
    position: absolute;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    color: white;
    font-size: 20px;
    background-color: rgba(0, 0, 0, 0.5);
    padding: 10px;
    border-radius: 5px;
}
    
        .slideshow-container {
            position: relative;
            text-align: center;
            max-width: 40%;  
            margin: 0 auto;
        }

        .slide {
            display: none;
            width: 100%;
            height: 300px; 
            position: relative;
            overflow: hidden;  
        }

        .slide img {
            display: block;
            margin: 0 auto; 
            max-width: 100%;  
            max-height: 100%;  
        }

        .slide-btn {
            position: absolute;
            top: 50%;
            z-index: 10;
            background: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 50%;
        }

        .slide-btn.left {
            left: 10px;
        }

        .slide-btn.right {
            right: 10px;
        }

        .caption {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            color: white;
            font-size: 20px;
            background-color: rgba(0, 0, 0, 0.5);
            padding: 10px;
            border-radius: 5px;
        }

        #card {
            margin: 10px;
        }

        #container {
            margin-top: 50px;
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
	<div id="card" style="
    place-items: center;
">
    <h1 style="
    place-self: center;
">Welcome, ${user.username}!</h1>
    <div class="slideshow-container">
         <c:forEach var="category" items="${categories}">
        <div class="slide">
            <!-- Link to the category page -->
            <a href="/category/${fn:replace(category.name, ' ', '%20')}" style="text-decoration: none; color: inherit;">
                <img src="${category.image}" alt="${category.name}" class="d-block w-100">
                <div class="caption">${category.name}</div>
            </a>
        </div>
    </c:forEach>

        <button class="slide-btn left" onclick="plusSlides(-1)"><i class="fas fa-arrow-left"></i></button>
        <button class="slide-btn right" onclick="plusSlides(1)"><i class="fas fa-arrow-right"></i></button>
    </div>

        <div>
            <h3 style="
    place-self: center;margin-top: 40px;
">Latest Quizzes</h3>
            <div class="row">
                <c:if test="${empty quizzes}">
                    <p>No public quizzes available at the moment.</p>
                </c:if>

                <c:forEach var="quiz" items="${quizzes}">
                    <div class="col-md-4">
                        <div id="card">
                            <div class="card-body" style="padding: 40px; border: double; border-radius: 30px; justify-items: center;">
                                <h5 class="card-title">${quiz.title}</h5>
                                <a href="/quiz/${quiz.id}" class="btn btn-primary">Take</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-4">
        <p>&copy; 2024 QuizMaster. All Rights Reserved.</p>
        <p>
            <a href="#" class="text-white text-decoration-underline">Terms of Service</a> |
            <a href="#" class="text-white text-decoration-underline">Privacy Policy</a>
        </p>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        let slideIndex = 0;
        function showSlides() {
            let slides = document.querySelectorAll('.slide');
            if (slideIndex >= slides.length) { slideIndex = 0; }
            if (slideIndex < 0) { slideIndex = slides.length - 1; }

            slides.forEach((slide) => {
                slide.style.display = "none";
            });

            slides[slideIndex].style.display = "block";
        }

        function plusSlides(n) {
            slideIndex += n;
            showSlides();
        }

        showSlides();

        setInterval(() => {
            plusSlides(1);
        }, 3000);

    </script>

</body>
</html>
