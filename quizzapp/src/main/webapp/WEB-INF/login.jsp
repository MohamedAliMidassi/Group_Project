<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<title>Login and Registration</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/style2.css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Protest+Revolution&family=Rubik+Gemstones&family=Sevillana&display=swap');
</style>
</head>
<body>
		<header>
        <h1>QuizMaster</h1>
        <nav>
            <a href="/">Home</a>
            <a href="/register">Register</a>
        </nav>
    </header>


<form:form action="/login" method="post" modelAttribute="newLogin">

	<table>
		<thead>
	    	<tr>
	            <td colspan="2">Log In</td>
	        </tr>
	    </thead>
	    <thead>
	        <tr>
	            <td class="float-left">Email:</td>
	            <td class="float-left">
	            	<form:errors path="email" class="error"/>
					<form:input class="input" path="email"/>
	            </td>
	        </tr>
	        <tr>
	            <td class="float-left">Password:</td>
	            <td class="float-left">
	            	<form:errors path="password" class="error"/>
					<form:input class="input" path="password" type="password"/>
	            </td>
	        </tr>
	        <tr>
	        	<td colspan=2><input class="input" type="submit" value="Submit" id="button"/></td>
	        </tr>
	    </thead>
	</table>
</form:form>
<footer class="bg-dark text-white text-center py-3 mt-4">
        <p>&copy; 2024 QuizMaster. All Rights Reserved.</p>
        <p>
            <a href="#" class="text-white text-decoration-underline">Terms of Service</a> |
            <a href="#" class="text-white text-decoration-underline">Privacy Policy</a>
        </p>
    </footer>
</body>
</html>