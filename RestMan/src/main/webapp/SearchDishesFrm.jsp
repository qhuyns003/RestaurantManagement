<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tìm kiếm món ăn</title>
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
        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 40px 20px; 
        }
        .search-card { 
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px); 
            padding: 30px; 
            border-radius: 15px; 
            margin-bottom: 30px; 
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); 
            border: 1px solid rgba(255, 255, 255, 0.2); 
        }
        .search-form { 
            display: flex; 
            flex-wrap: wrap; 
            gap: 20px; 
            align-items: end; 
            justify-content: center;
        }
        .form-group { 
            min-width: 250px; 
            flex: 1;
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
        .search-btn { 
            background: linear-gradient(135deg, #5a67d8 0%, #667eea 100%); 
            color: white; 
            border: none; 
            padding: 12px 30px; 
            border-radius: 8px; 
            font-size: 1em; 
            font-weight: 600; 
            cursor: pointer; 
            transition: all 0.3s ease; 
            min-height: 48px;
            min-width: 120px;
            flex-shrink: 0;
        }
        .search-btn:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 8px 25px rgba(90, 103, 216, 0.3); 
        }
        .results-card { 
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px); 
            padding: 30px; 
            border-radius: 15px; 
            margin-bottom: 30px; 
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); 
            border: 1px solid rgba(255, 255, 255, 0.2); 
        }
        .dish-item { 
            background: rgba(255, 255, 255, 0.9); 
            border-radius: 12px; 
            padding: 25px 30px; 
            margin-bottom: 20px; 
            display: flex; 
            align-items: center; 
            justify-content: space-between; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1); 
            transition: all 0.3s ease;
            border: 1px solid rgba(90, 103, 216, 0.1);
        }
        .dish-item:hover { 
            transform: translateY(-3px); 
            box-shadow: 0 8px 25px rgba(0,0,0,0.15); 
        }
        .dish-name { 
            font-size: 1.3em; 
            font-weight: 600; 
            color: #2d3748; 
            flex: 1;
        }
        .detail-btn { 
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%); 
            color: white; 
            border: none; 
            padding: 10px 25px; 
            border-radius: 8px; 
            font-size: 1em; 
            font-weight: 600; 
            cursor: pointer; 
            text-decoration: none; 
            transition: all 0.3s ease; 
        }
        .detail-btn:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 6px 20px rgba(72, 187, 120, 0.3); 
        }
        .no-results { 
            text-align: center; 
            color: #718096; 
            font-style: italic; 
            padding: 40px; 
            font-size: 1.1em;
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
            .search-form { flex-direction: column; }
            .form-group { min-width: 100%; }
            .dish-item { flex-direction: column; gap: 15px; text-align: center; }
            .header h1 { font-size: 1.8em; }
        }
        
        @media (max-width: 480px) {
            .dish-item { padding: 20px; }
            .search-btn, .back-btn, .detail-btn { 
                padding: 10px 20px; 
                font-size: 0.9em; 
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🔍 Tìm kiếm món ăn</h1>
    </div>
    
    <div class="container">
        <div class="search-card">
            <form action="/dish" method="get" class="search-form">
                <div class="form-group">
                    <label for="dishName">🍜 Tên món ăn:</label>
                    <input id="dishName" name="dishName" value="${searchKey}" placeholder="Nhập tên món ăn cần tìm..." />
                </div>
                <div class="form-group">
                    <input type="hidden" name="action" value="search" />
                    <button type="submit" class="search-btn">🔍 Tìm kiếm</button>
                </div>
            </form>
        </div>

        <c:if test="${not empty searchKey}">
            <div class="results-card">
                <c:choose>
                    <c:when test="${not empty listDish}">
                        <c:forEach var="d" items="${listDish}">
                            <div class="dish-item">
                                <span class="dish-name">🍽️ ${d.name}</span>
                                <%-- Bước 16: SearchDishesFrm.jsp gọi DetailDishInfoFrm.jsp --%>
                                <a href="/DetailDishInfoFrm.jsp?dishId=${d.id}" class="detail-btn">👁️ Xem chi tiết</a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-results">
                            📭 Không tìm thấy món ăn nào có tên '<c:out value="${searchKey}"/>'
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        
        <div class="center">
            <div class="button-row">
                <a href="/" class="back-btn">⬅️ Quay lại trang chủ</a>
            </div>
        </div>
    </div>
</body>
</html>