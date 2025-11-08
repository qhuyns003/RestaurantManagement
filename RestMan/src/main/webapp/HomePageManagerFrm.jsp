<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang quản lý - Nhà hàng</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            min-height: 100vh; 
        }
        .header { 
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px); 
            color: #333; 
            text-align: center; 
            padding: 30px 0; 
            box-shadow: 0 4px 20px rgba(0,0,0,0.1); 
        }
        .header h1 { 
            font-size: 2.5em; 
            font-weight: 300; 
            color: #5a67d8; 
        }
        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 40px 20px; 
        }
        .welcome-card { 
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px); 
            padding: 25px 35px; 
            border-radius: 15px; 
            margin-bottom: 40px; 
            text-align: center; 
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); 
            border: 1px solid rgba(255, 255, 255, 0.2); 
        }
        .welcome-card .greeting { 
            font-size: 1.3em; 
            color: #4a5568; 
            line-height: 1.6; 
        }
        .welcome-card .user-name { 
            color: #5a67d8; 
            font-weight: 600; 
        }
        .menu-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); 
            gap: 25px; 
            margin-top: 30px; 
            justify-items: center;
        }
        .menu-card { 
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px); 
            border-radius: 15px; 
            padding: 30px 25px; 
            text-align: center; 
            text-decoration: none; 
            color: #4a5568; 
            transition: all 0.3s ease; 
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); 
            border: 1px solid rgba(255, 255, 255, 0.2); 
            position: relative; 
            overflow: hidden; 
            width: 100%;
            max-width: 300px;
        }
        .menu-card::before { 
            content: ''; 
            position: absolute; 
            top: 0; 
            left: -100%; 
            width: 100%; 
            height: 100%; 
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent); 
            transition: left 0.5s; 
        }
        .menu-card:hover::before { 
            left: 100%; 
        }
        .menu-card:hover { 
            transform: translateY(-8px); 
            box-shadow: 0 15px 45px rgba(0,0,0,0.2); 
            color: #5a67d8; 
        }
        .menu-card .icon { 
            font-size: 3em; 
            margin-bottom: 20px; 
            display: block; 
        }
        .menu-card .title { 
            font-size: 1.2em; 
            font-weight: 600; 
            margin-bottom: 10px; 
        }
        .menu-card .description { 
            font-size: 0.9em; 
            color: #718096; 
            line-height: 1.5; 
        }
        .logout-card { 
            background: linear-gradient(135deg, #fd79a8 0%, #fdcb6e 100%); 
        }
        .logout-card:hover { 
            background: linear-gradient(135deg, #e84393 0%, #f39c12 100%); 
            color: white; 
        }
        .stats-card { 
            background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%); 
            color: white; 
        }
        .stats-card:hover { 
            background: linear-gradient(135deg, #0984e3 0%, #74b9ff 100%); 
        }
        .combo-card { 
            background: linear-gradient(135deg, #fd79a8 0%, #e84393 100%); 
            color: white; 
        }
        .combo-card:hover { 
            background: linear-gradient(135deg, #e84393 0%, #fd79a8 100%); 
        }
        .dish-card { 
            background: linear-gradient(135deg, #00b894 0%, #00cec9 100%); 
            color: white; 
        }
        .dish-card:hover { 
            background: linear-gradient(135deg, #00cec9 0%, #00b894 100%); 
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .container { padding: 20px 10px; }
            .menu-grid { 
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); 
                gap: 20px; 
            }
            .header h1 { font-size: 1.8em; }
            .menu-card { padding: 25px 20px; }
        }
        
        @media (max-width: 480px) {
            .menu-grid { 
                grid-template-columns: 1fr; 
                gap: 15px; 
            }
            .menu-card { 
                padding: 20px 15px; 
                max-width: 100%; 
            }
            .menu-card .icon { font-size: 2.5em; }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🍽️ Restaurant Management System</h1>
    </div>
    
    <div class="container">
        <div class="welcome-card">
            <div class="greeting">
                <c:choose>
                    <c:when test="${not empty staffName}">
                        Xin chào, <span class="user-name">${staffName}</span>!<br>
                        Chúc bạn có một ngày làm việc hiệu quả và thành công 🌟
                    </c:when>
                    <c:otherwise>
                        Xin chào, <span class="user-name">Admin</span>!<br>
                        Chúc bạn có một ngày làm việc hiệu quả và thành công 🌟
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="menu-grid">

            
            <%-- Bước 2: HomePageManagerFrm.jsp gọi ViewStatisticsFrm.jsp --%>
            <a href="${pageContext.request.contextPath}/ViewStatisticsFrm.jsp" class="menu-card stats-card">
                <span class="icon">📊</span>
                <div class="title">Thống kê khách hàng</div>
                <div class="description">Xem báo cáo doanh thu theo khách hàng</div>
            </a>
            
            <a href="#" class="menu-card combo-card">
                <span class="icon">🍱</span>
                <div class="title">Quản lý Combo</div>
                <div class="description">Thêm, sửa, xóa các combo món ăn</div>
            </a>
            
            <a href="#" class="menu-card dish-card">
                <span class="icon">🍜</span>
                <div class="title">Quản lý Món ăn</div>
                <div class="description">Cập nhật thông tin các món ăn</div>
            </a>

                <a href="${pageContext.request.contextPath}/home" class="menu-card logout-card">
                    <span class="icon">🏠</span>
                    <div class="title">Đăng xuất</div>
                    <div class="description">Quay lại giao diện khách hàng</div>
                </a>
        </div>
    </div>
</body>
</html>
