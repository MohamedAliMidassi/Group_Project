<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to QuizMaster</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <style>
@import url('https://fonts.googleapis.com/css2?family=Protest+Revolution&family=Rubik+Gemstones&family=Sevillana&display=swap');
</style>
</head>
<body>
    <h1 class='rubik-gemstones-regular' style='color: midnightblue;
    font-family: "Rubik Gemstones", system-ui;
    font-weight: 400;
    font-style: normal;
    font-size: 65px;'>QuizMaster</h1>
    <p style="justify-self: center; font-style: italic; font-size: larger; background-color: azure; border-radius: 100px; font-family: cursive;">
        💡📚 Create. Share. Conquer. 📚💡
    </p>

    <div style="margin: 20px; padding: 20px;background-color: aliceblue; border-radius: 10px; font-family: Arial, sans-serif;">
        <h2 style="color: navy;">About Us</h2>
        <p style="font-size: larger;">
            Welcome to <strong>QuizMaster</strong>! We’re thrilled to have you on board. 
            With QuizMaster, you have the power to create exciting quizzes and bring engaging challenges to your audience.
            Whether you're crafting questions for a fun team-building activity or hosting a trivia competition, 
            we've got the tools to make it easy and enjoyable.
        </p>
        <h3 style="color: darkcyan;">Explore quizzes across three difficulty levels:</h3>
        <ul style="font-size: larger;">
            <li><strong>Easy:</strong> For lighthearted fun and learning.</li>
            <li><strong>Hard:</strong> For those who enjoy a tougher test of wits.</li>
            <li><strong>Challenge:</strong> For the ultimate showdown of knowledge.</li>
        </ul>
        <p style="font-size: larger; margin-bottom:55px">Create your own quizzes, share them with friends, and see who reigns supreme. Let the fun begin!</p>

    <div style="text-align: center;margin-bottom: 15px;">
        <a href="/login" style="text-decoration: none; padding: 10px 20px; background-color: lightblue; border-radius: 5px; color: black; font-weight: bold;">Login</a>
        <a href="/register" style="text-decoration: none; padding: 10px 20px; background-color: lightgreen; border-radius: 5px; color: black; font-weight: bold;margin-left: 46px;">Register</a>
    </div>
    </div>
</body>
</html>
