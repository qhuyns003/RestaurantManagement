<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hệ thống Quản lý Nhà hàng</title>
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
        .welcome-card h2 { 
            color: #5a67d8; 
            margin-bottom: 15px; 
            font-size: 2.2em; 
            font-weight: 600; 
        }
        .welcome-card p { 
            color: #718096; 
            font-size: 1.2em; 
            line-height: 1.6; 
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
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .container { padding: 20px 10px; }
            .header h1 { font-size: 2em; }
            .welcome-card h2 { font-size: 1.8em; }
            .welcome-card p { font-size: 1em; }
        }
        
        @media (max-width: 480px) {
            .header h1 { font-size: 1.6em; }
            .welcome-card h2 { font-size: 1.5em; }
            .menu-card { padding: 20px 15px; max-width: 100%; }
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
            <h2>Chào mừng đến với nhà hàng</h2>
            <p>Khám phá thực đơn đa dạng và trải nghiệm dịch vụ tuyệt vời của chúng tôi</p>
        </div>
        
        <div class="menu-grid">
            <%-- Bước 2: HomePageFrm.jsp gọi SearchDishesFrm.jsp --%>
            <a href="/SearchDishesFrm.jsp" class="menu-card">
                <span class="icon">🔍</span>
                <div class="title">Tìm kiếm món ăn</div>
                <div class="description">Khám phá thực đơn phong phú với nhiều món ngon</div>
            </a>
            
            <a href="#" class="menu-card">
                <span class="icon">🪑</span>
                <div class="title">Đặt bàn</div>
                <div class="description">Đặt bàn trước để có trải nghiệm tốt nhất</div>
            </a>
            
            <a href="/staff-login" class="menu-card">
                <span class="icon">👨‍💼</span>
                <div class="title">Đăng nhập nhân viên</div>
                <div class="description">Dành cho nhân viên quản lý hệ thống</div>
            </a>
            
            <a href="#" class="menu-card">
                <span class="icon">📝</span>
                <div class="title">Đặt món</div>
                <div class="description">Gọi món yêu thích trực tuyến</div>
            </a>
        </div>
    </div>
</body>
</html>