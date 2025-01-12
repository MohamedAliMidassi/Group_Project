<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
<title>Login and Registration</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>

<h1 style="color: beige;font-family: serif;font-size: 49px;background-color: lightblue;border-radius: 100px;">Quiz App</h1>
<p style="justify-self: center;font-style: italic; font-size: larger;background-color: beige;border-radius: 100px;font-family: cursive;">💡📚A place for friends to share Quizzes 📚💡</p>
<form:form action="/register" method="post" modelAttribute="newUser">

	<table>
		<thead>
	    	<tr>
	            <td colspan="2">Register</td>
	        </tr>
	    </thead>
	    <thead>
	    	<tr>
	            <td class="float-left"> Username:</td>
	            <td class="float-left">
	            	<form:errors path="username" class="error"/>
					<form:input class="input" path="username"/>
	            </td>
	        </tr>
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
	            <td class="float-left">Confirm PW:</td>
	            <td class="float-left">
	            	<form:errors path="confirm" class="error"/>
					<form:input class="input" path="confirm" type="password"/>
	            </td>
	        </tr>
	        <tr>
	        	<td colspan=2><input class="input" type="submit" value="Submit" id="button"/></td>
	        </tr>
	    </thead>
	</table>
</form:form>
<hr>
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
</body>
</html>