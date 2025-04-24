<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .error-box { border: 1px solid #ff0000; padding: 20px; background: #ffeeee; }
    </style>
</head>
<body>
    <div class="error-box">
        <h2>Error Occurred</h2>
        <p>${errorMessage}</p>
        <a href="index.jsp">Return to Home</a>
    </div>
</body>
</html>