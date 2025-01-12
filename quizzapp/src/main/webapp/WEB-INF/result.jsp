<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Result</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .result-container {
            max-width: 800px;
            margin: 0 auto;
            padding-top: 30px;
        }
        .score-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .score-btn {
            width: 100%;
            padding: 12px;
            font-size: 1.2rem;
        }
        .progress-bar {
            background-color: #28a745;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container result-container">
        <div class="text-center">
            <h2 class="score-header">${quiz.title} - Result</h2>
            <p>Your score: ${score} out of ${totalQuestions}</p>
            
            <div class="mb-4">
                <div class="progress" style="height: 30px;">
                    <div class="progress-bar" role="progressbar" style="width: ${(score / totalQuestions) * 100}%" aria-valuenow="${score}" aria-valuemin="0" aria-valuemax="${totalQuestions}">
                        ${(score / totalQuestions) * 100}%
                    </div>
                </div>
            </div>
            
            <canvas id="scoreChart"></canvas>
            
            <a href="/home" class="btn btn-primary score-btn">Back to Home</a>
        </div>
    </div>

    <script>
        var ctx = document.getElementById('scoreChart').getContext('2d');
        var scoreChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Correct', 'Missed'],
                datasets: [{
                    label: 'Quiz Performance',
                    data: [${score}, ${totalQuestions - score}],
                    backgroundColor: ['#28a745', '#e0e0e0'],
                    borderColor: ['#28a745', '#e0e0e0'],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
