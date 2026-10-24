<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.studentapp.Student" %>
<%
    String keyword = (String) request.getAttribute("keyword");
    if (keyword == null) keyword = "";
    List<Student> students = (List<Student>) request.getAttribute("students");
    int count = (students != null) ? students.size() : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enrolled Students | College Portal</title>
    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --danger: #ef4444;
            --danger-hover: #dc2626;
            --edit: #0284c7;
            --edit-hover: #0369a1;
            --bg: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border: #e2e8f0;
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
            padding: 40px 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .container {
            width: 100%;
            max-width: 900px;
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #4f46e5 0%, #3730a3 100%);
            color: #ffffff;
            padding: 28px 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
        }

        .header-title h1 {
            font-size: 1.4rem;
            font-weight: 700;
            letter-spacing: -0.01em;
        }

        .header-title p {
            font-size: 0.85rem;
            color: #c7d2fe;
            margin-top: 4px;
        }

        .btn-add {
            background-color: #ffffff;
            color: var(--primary);
            font-weight: 600;
            font-size: 0.875rem;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.2s ease;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-add:hover {
            background-color: #f1f5f9;
            transform: translateY(-1px);
        }

        /* Search Bar Toolbar */
        .toolbar {
            padding: 16px 28px;
            background: #ffffff;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        .search-form {
            display: flex;
            align-items: center;
            gap: 8px;
            flex: 1;
            max-width: 420px;
        }

        .search-input {
            flex: 1;
            padding: 9px 14px;
            border: 1.5px solid var(--border);
            border-radius: 8px;
            font-size: 0.9rem;
            outline: none;
            transition: border-color 0.15s ease;
        }

        .search-input:focus {
            border-color: var(--primary);
        }

        .btn-search {
            background: var(--primary);
            color: #ffffff;
            border: none;
            padding: 9px 16px;
            border-radius: 8px;
            font-size: 0.875rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.15s ease;
        }

        .btn-search:hover {
            background: var(--primary-hover);
        }

        .btn-reset {
            color: var(--text-muted);
            font-size: 0.85rem;
            text-decoration: none;
            padding: 4px 8px;
        }

        .btn-reset:hover {
            color: var(--danger);
            text-decoration: underline;
        }

        .table-responsive {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        thead th {
            background-color: #f8fafc;
            color: #475569;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 14px 24px;
            border-bottom: 1.5px solid var(--border);
        }

        tbody td {
            padding: 14px 24px;
            font-size: 0.95rem;
            color: var(--text-main);
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background-color: #f8fafc;
        }

        .badge-regno {
            font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
            font-weight: 600;
            background: #ede9fe;
            color: #6d28d9;
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 0.85rem;
            display: inline-block;
        }

        .cgpa-value {
            font-weight: 700;
            color: #047857;
            background: #ecfdf5;
            padding: 4px 10px;
            border-radius: 9999px;
            font-size: 0.875rem;
            display: inline-block;
        }

        /* Action Buttons */
        .actions-cell {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .btn-action {
            display: inline-block;
            font-size: 0.8rem;
            font-weight: 600;
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            transition: all 0.15s ease;
        }

        .btn-edit {
            background-color: #e0f2fe;
            color: #0369a1;
            border: 1px solid #bae6fd;
        }

        .btn-edit:hover {
            background-color: #0284c7;
            color: #ffffff;
        }

        .btn-delete {
            background-color: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        .btn-delete:hover {
            background-color: #ef4444;
            color: #ffffff;
        }

        .empty-state {
            padding: 48px 24px;
            text-align: center;
            color: var(--text-muted);
        }

        .empty-state p {
            font-size: 1rem;
            margin-bottom: 16px;
        }

        .footer {
            padding: 16px 24px;
            background-color: #f8fafc;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.85rem;
            color: var(--text-muted);
            flex-wrap: wrap;
            gap: 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-title">
                <h1>Registered Students</h1>
                <p>PostgreSQL Database &bull; Schema: college.student</p>
            </div>
            <a href="/" class="btn-add">+ Register New Student</a>
        </div>

        <!-- Search Toolbar -->
        <div class="toolbar">
            <form class="search-form" action="/students" method="get">
                <input type="text" name="keyword" class="search-input"
                       placeholder="Search by Register No or Name..."
                       value="<%= keyword %>">
                <button type="submit" class="btn-search">Search</button>
                <% if (!keyword.isEmpty()) { %>
                    <a href="/students" class="btn-reset">Clear Filter</a>
                <% } %>
            </form>
            <div>
                <span style="font-size: 0.85rem; color: var(--text-muted);">
                    Showing <strong><%= count %></strong> record(s)
                </span>
            </div>
        </div>

        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th style="width: 20%;">Register No</th>
                        <th style="width: 35%;">Student Name</th>
                        <th style="width: 20%;">CGPA</th>
                        <th style="width: 25%; text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (students != null && !students.isEmpty()) {
                            for (Student s : students) {
                    %>
                    <tr>
                        <td><span class="badge-regno"><%= s.getRegno() %></span></td>
                        <td><strong><%= s.getName() %></strong></td>
                        <td><span class="cgpa-value"><%= String.format("%.2f", s.getCgpa()) %></span></td>
                        <td style="text-align: center;">
                            <div class="actions-cell" style="justify-content: center;">
                                <a href="/editStudent/<%= s.getRegno() %>" class="btn-action btn-edit">Edit</a>
                                <a href="/deleteStudent/<%= s.getRegno() %>" class="btn-action btn-delete"
                                   onclick="return confirm('Are you sure you want to delete <%= s.getName() %> (RegNo: <%= s.getRegno() %>)?');">
                                   Delete
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4">
                            <div class="empty-state">
                                <p>
                                    <%= !keyword.isEmpty() ? "No students matching '" + keyword + "'." : "No student records found in database." %>
                                </p>
                                <a href="/" class="btn-add">+ Add Student</a>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <div class="footer">
            <span>Total Enrolled: <strong><%= count %></strong></span>
            <span>CRUD: Create &bull; Read &bull; Update &bull; Delete &bull; Search</span>
        </div>
    </div>
</body>
</html>
