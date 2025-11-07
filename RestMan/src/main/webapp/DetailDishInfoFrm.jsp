<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết món ăn</title>
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
            font-size: 2.2em; 
            font-weight: 300; 
            color: #5a67d8; 
            margin-bottom: 10px;
        }
        .header .subtitle { 
            color: #718096; 
            font-size: 1.1em; 
        }
        .container { 
            max-width: 800px; 
            margin: 0 auto; 
            padding: 40px 20px; 
        }
        .dish-card { 
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px); 
            padding: 40px; 
            border-radius: 15px; 
            margin-bottom: 30px; 
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); 
            border: 1px solid rgba(255, 255, 255, 0.2); 
        }
        .dish-name { 
            color: #5a67d8; 
            font-size: 2.5em; 
            font-weight: 600; 
            margin-bottom: 25px; 
            text-align: center;
        }
        .dish-info { 
            display: grid; 
            gap: 20px; 
        }
        .info-item { 
            background: rgba(90, 103, 216, 0.05); 
            padding: 20px; 
            border-radius: 10px; 
            border-left: 4px solid #5a67d8;
        }
        .info-label { 
            font-weight: 600; 
            color: #2d3748; 
            font-size: 1.1em; 
            margin-bottom: 8px;
            display: block;
        }
        .info-value { 
            color: #4a5568; 
            font-size: 1em; 
            line-height: 1.6;
        }
        .price-value { 
            color: #38a169; 
            font-weight: 700; 
            font-size: 1.3em;
        }
        .back-btn { 
            background: linear-gradient(135deg, #ed8936 0%, #dd6b20 100%); 
            color: white; 
            border: none; 
            padding: 12px 30px; 
            border-radius: 8px; 
            font-size: 1em; 
            font-weight: 600; 
            cursor: pointer; 
            text-decoration: none; 
            display: inline-block; 
            transition: all 0.3s ease; 
            margin-top: 20px; 
        }
        .back-btn:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 8px 25px rgba(237, 137, 54, 0.3); 
        }
        .no-data { 
            text-align: center; 
            color: #718096; 
            font-style: italic; 
            padding: 40px; 
            font-size: 1.1em;
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px); 
            border-radius: 15px; 
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); 
        }
        .center { 
            text-align: center; 
            margin-top: 30px;
        }
        .button-row {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .container { padding: 20px 10px; }
            .dish-card { padding: 25px 20px; }
            .dish-name { font-size: 2em; }
            .header h1 { font-size: 1.8em; }
        }
        
        @media (max-width: 480px) {
            .dish-name { font-size: 1.6em; }
            .info-item { padding: 15px; }
            .back-btn { 
                padding: 10px 20px; 
                font-size: 0.9em; 
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🍽️ Chi tiết món ăn</h1>
        <div class="subtitle">Thông tin đầy đủ về món ăn</div>
    </div>
    
    <div class="container">
        <%-- Bước 17-26: DetailDishInfoFrm.jsp gọi DishServlet --%>
        <div id="dishContainer">
            <div class="no-data">⏳ Đang tải thông tin món ăn...</div>
        </div>
        
        <div class="center">
            <div class="button-row">
                <a href="/SearchDishesFrm.jsp" class="back-btn">⬅️ Quay lại tìm kiếm</a>
            </div>
        </div>
    </div>
    
    <script>
        function loadDishDetail() {
            const urlParams = new URLSearchParams(window.location.search);
            const dishId = urlParams.get('dishId');
            
            if (!dishId) {
                document.getElementById('dishContainer').innerHTML = 
                    '<div class="no-data">❌ Không có mã món ăn</div>';
                return;
            }
            
            fetch('/dish?action=get-detail-json&dishId=' + dishId)
                .then(response => response.json())
                .then(dish => {
                    if (dish && dish.id) {
                        let html = '<div class="dish-card">';
                        html += '<div class="dish-name">🍜 ' + dish.name + '</div>';
                        html += '<div class="dish-info">';
                        html += '<div class="info-item">';
                        html += '<span class="info-label">📝 Mô tả món ăn:</span>';
                        html += '<div class="info-value">' + (dish.description || 'Không có mô tả') + '</div>';
                        html += '</div>';
                        html += '<div class="info-item">';
                        html += '<span class="info-label">💰 Giá món ăn:</span>';
                        html += '<div class="info-value price-value">' + formatNumber(dish.price) + '₫</div>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                        document.getElementById('dishContainer').innerHTML = html;
                    } else {
                        document.getElementById('dishContainer').innerHTML = 
                            '<div class="no-data">❌ Không tìm thấy thông tin món ăn</div>';
                    }
                })
                .catch(error => {
                    console.error('Error loading dish detail:', error);
                    document.getElementById('dishContainer').innerHTML = 
                        '<div class="no-data">❌ Lỗi khi tải thông tin món ăn</div>';
                });
        }
        
        function formatNumber(num) {
            return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        }
        
        window.addEventListener('DOMContentLoaded', function() {
            loadDishDetail();
        });
    </script>
</body>
</html>