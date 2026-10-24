<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.studentapp.Student" %>
<%
    Student student = (Student) request.getAttribute("student");
    Boolean isEditObj = (Boolean) request.getAttribute("isEdit");
    boolean isEdit = (isEditObj != null && isEditObj) && (student != null && student.getRegno() > 0);

    String formTitle = isEdit ? "Update Student Details" : "Student Registration";
    String formSubtitle = isEdit ? "Modifying existing student in PostgreSQL" : "Spring Boot + PostgreSQL Database Management";
    String btnText = isEdit ? "Update Student" : "Register Student";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= formTitle %> | College Portal</title>
    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --bg: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --focus-ring: rgba(79, 70, 229, 0.2);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
        }

        body {
            background-color: var(--bg);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        .container {
            width: 100%;
            max-width: 480px;
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.02);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #4f46e5 0%, #3730a3 100%);
            color: #ffffff;
            padding: 32px 28px 24px;
            text-align: center;
        }

        .header h1 {
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: -0.02em;
            margin-bottom: 6px;
        }

        .header p {
            font-size: 0.875rem;
            color: #c7d2fe;
        }

        .form-content {
            padding: 32px 28px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 0.875rem;
            font-weight: 600;
            color: #334155;
            margin-bottom: 8px;
        }

        .required-star {
            color: #ef4444;
            margin-left: 2px;
        }

        input[type="number"],
        input[type="text"] {
            width: 100%;
            padding: 12px 14px;
            border: 1.5px solid var(--border);
            border-radius: 8px;
            font-size: 0.95rem;
            color: var(--text-main);
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
            outline: none;
        }

        input[readonly] {
            background-color: #f1f5f9;
            color: #64748b;
            cursor: not-allowed;
        }

        input[type="number"]:focus:not([readonly]),
        input[type="text"]:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--focus-ring);
        }

        .helper-text {
            font-size: 0.775rem;
            color: var(--text-muted);
            margin-top: 4px;
        }

        .btn-submit {
            width: 100%;
            padding: 13px;
            background: var(--primary);
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.1s ease;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.25);
            margin-top: 8px;
        }

        .btn-submit:hover {
            background: var(--primary-hover);
        }

        .btn-submit:active {
            transform: scale(0.99);
        }

        .footer-links {
            margin-top: 24px;
            text-align: center;
            border-top: 1px solid var(--border);
            padding-top: 18px;
            display: flex;
            justify-content: center;
            gap: 16px;
        }

        .footer-links a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><%= formTitle %></h1>
            <p><%= formSubtitle %></p>
        </div>

        <form class="form-content" action="/saveStudent" method="post">
            <div class="form-group">
                <label for="regno">Register Number <span class="required-star">*</span></label>
                <input type="number" id="regno" name="regno" required min="1"
                       value="<%= (student != null && student.getRegno() > 0) ? student.getRegno() : "" %>"
                       <%= isEdit ? "readonly" : "" %>
                       placeholder="e.g. 1121">
                <div class="helper-text">
                    <%= isEdit ? "Register Number is fixed (Primary Key)" : "Unique student identifier (Primary Key)" %>
                </div>
            </div>

            <div class="form-group">
                <label for="name">Student Name <span class="required-star">*</span></label>
                <input type="text" id="name" name="name" required
                       value="<%= (student != null && student.getName() != null) ? student.getName() : "" %>"
                       placeholder="e.g. Deepak Krishnan S U">
                <div class="helper-text">Full name of the student</div>
            </div>

            <div class="form-group">
                <label for="cgpa">CGPA <span class="required-star">*</span></label>
                <input type="number" id="cgpa" name="cgpa" step="0.01" min="0.00" max="10.00" required
                       value="<%= (student != null && student.getCgpa() > 0) ? student.getCgpa() : "" %>"
                       placeholder="e.g. 7.72">
                <div class="helper-text">Cumulative Grade Point Average (0.00 - 10.00)</div>
            </div>

            <button type="submit" class="btn-submit"><%= btnText %></button>

            <div class="footer-links">
                <a href="/students">&larr; View All Students</a>
                <% if (isEdit) { %>
                    <a href="/">&plus; Register New</a>
                <% } %>
            </div>
        </form>
    </div>
</body>
</html>
