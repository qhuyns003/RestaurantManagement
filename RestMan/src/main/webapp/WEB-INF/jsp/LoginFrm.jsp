<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập nhân viên</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            min-height: 100vh; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            padding: 20px;
        }
        .login-container { 
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px); 
            padding: 40px 35px; 
            border-radius: 15px; 
            max-width: 450px; 
            width: 100%;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); 
            border: 1px solid rgba(255, 255, 255, 0.2); 
        }
        .login-title { 
            color: #5a67d8; 
            font-size: 2.2em; 
            font-weight: 600; 
            margin-bottom: 30px; 
            text-align: center;
        }
        .form-group { 
            margin-bottom: 20px; 
            text-align: left;
        }
        .form-group label { 
            display: block; 
            font-weight: 600; 
            color: #4a5568; 
            margin-bottom: 8px; 
        }
        .form-group input { 
            width: 100%; 
            padding: 12px 15px; 
            border: 2px solid #e2e8f0; 
            border-radius: 8px; 
            font-size: 1em; 
            transition: border-color 0.2s; 
        }
        .form-group input:focus { 
            outline: none; 
            border-color: #5a67d8; 
        }
        .btn-container {
            text-align: center;
            margin-top: 25px;
        }
        .login-btn { 
            background: linear-gradient(135deg, #5a67d8 0%, #667eea 100%); 
            color: white; 
            border: none; 
            padding: 12px 40px; 
            border-radius: 8px; 
            font-size: 1.1em; 
            font-weight: 600; 
            cursor: pointer; 
            transition: all 0.3s ease; 
            width: 100%;
            max-width: 200px;
        }
        .login-btn:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 8px 25px rgba(90, 103, 216, 0.4); 
        }
        .error { 
            color: #e53e3e; 
            background: rgba(229, 62, 62, 0.1);
            padding: 10px 15px;
            border-radius: 6px;
            margin-bottom: 16px; 
            text-align: center;
            border: 1px solid rgba(229, 62, 62, 0.2);
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .login-container { 
                padding: 30px 25px; 
                margin: 20px; 
                max-width: 400px; 
            }
            .login-title { font-size: 1.8em; }
        }
        
        @media (max-width: 480px) {
            .login-container { 
                padding: 25px 20px; 
                margin: 15px; 
            }
            .login-title { font-size: 1.5em; }
            .login-btn { 
                padding: 10px 30px; 
                font-size: 1em; 
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-title">🔐 Đăng nhập nhân viên</div>
        <form action="/staff-login" method="post">
            <div class="form-group">
                <label for="username">👤 Tên đăng nhập:</label>
                <input type="text" id="username" name="username" required />
            </div>
            <div class="form-group">
                <label for="password">🔒 Mật khẩu:</label>
                <input type="password" id="password" name="password" required />
            </div>
            <c:if test="${not empty error}">
                <div class="error">⚠️ ${error}</div>
            </c:if>
            <div class="btn-container">
                <button type="submit" class="login-btn">🚀 Đăng nhập</button>
            </div>
        </form>
    </div>
</body>
</html>
