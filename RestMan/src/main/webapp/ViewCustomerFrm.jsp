<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thống kê khách hàng theo doanh thu</title>
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
        .form-row { 
            display: flex; 
            flex-wrap: wrap; 
            gap: 20px; 
            align-items: end; 
            justify-content: center;
        }
        .form-group { 
            min-width: 200px; 
            flex: 1;
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
        .data-table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 20px; 
            overflow-x: auto;
        }
        .table-container {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }
        .data-table th { 
            background: linear-gradient(135deg, #5a67d8 0%, #667eea 100%); 
            color: white; 
            padding: 15px 12px; 
            text-align: left; 
            font-weight: 600; 
            border: none; 
            font-size: 0.9em;
        }
        .data-table th:first-child { 
            border-radius: 10px 0 0 0; 
        }
        .data-table th:last-child { 
            border-radius: 0 10px 0 0; 
        }
        .data-table td { 
            padding: 12px; 
            border-bottom: 1px solid #e2e8f0; 
            transition: background-color 0.2s; 
            font-size: 0.9em;
        }
        .data-table tbody tr:hover { 
            background-color: #f7fafc; 
        }
        .data-table tbody tr:last-child td { 
            border-bottom: none; 
        }
        .revenue-amount { 
            font-weight: 600; 
            color: #38a169; 
            font-size: 1em; 
        }
        .bill-btn { 
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%); 
            color: white; 
            border: none; 
            padding: 6px 12px; 
            border-radius: 6px; 
            font-size: 0.85em; 
            cursor: pointer; 
            transition: all 0.3s ease; 
        }
        .bill-btn:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 6px 20px rgba(72, 187, 120, 0.3); 
        }
        .no-data { 
            text-align: center; 
            color: #718096; 
            font-style: italic; 
            padding: 40px; 
            font-size: 1.1em;
        }
        .error-message {
            background: linear-gradient(135deg, #fc8181 0%, #e53e3e 100%);
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
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
        
        @media (max-width: 768px) {
            .container { padding: 20px 10px; }
            .form-row { flex-direction: column; }
            .form-group { min-width: 100%; }
            .data-table th, .data-table td { 
                padding: 8px 6px; 
                font-size: 0.8em; 
            }
            .header h1 { font-size: 1.8em; }
        }
        
        @media (max-width: 480px) {
            .data-table th, .data-table td { 
                padding: 6px 4px; 
                font-size: 0.75em; 
            }
            .search-btn, .back-btn { 
                padding: 10px 20px; 
                font-size: 0.9em; 
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>📊 Thống kê khách hàng theo doanh thu</h1>
    </div>
    
    <div class="container">
        <div class="search-card">
            <form action="${pageContext.request.contextPath}/statistics/customer" method="get">
                <div class="form-row">
                    <div class="form-group">
                        <label for="startDate">📅 Từ ngày:</label>
                        <input type="date" id="startDate" name="startDate" required value="${param.startDate}" />
                    </div>
                    <div class="form-group">
                        <label for="endDate">📅 Đến ngày:</label>
                        <input type="date" id="endDate" name="endDate" required value="${param.endDate}" />
                    </div>
                    <div class="form-group">
                        <input type="hidden" name="searched" value="1" />
                        <button type="submit" class="search-btn">🔍 Tìm kiếm</button>
                    </div>
                </div>
            </form>
        </div>
        
        <c:if test="${not empty error}">
            <div class="error-message">⚠️ ${error}</div>
        </c:if>
        
        <c:if test="${param.searched == '1'}">
            <div class="results-card">
                <c:choose>
                    <c:when test="${not empty listCustomerRevenue && fn:length(listCustomerRevenue) > 0}">
                        <div class="table-container">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Mã KH</th>
                                        <th>👤 Họ tên</th>
                                        <th> Số ĐT</th>
                                        <th>💰 Doanh thu</th>
                                        <th>🔧 Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="totalRevenue" value="0" />
                                    <c:forEach var="stat" items="${listCustomerRevenue}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>K00${stat.id}</td>
                                            <td>${stat.fullname}</td>
                                            <td>${stat.phone}</td>
                                            <td class="revenue-amount">
                                                <fmt:formatNumber value="${stat.totalRevenue}" pattern="#,###" />₫
                                            </td>
                                            <td>
                                                <!-- Bước 19: ViewCustomerFrm.jsp gọi ViewHistoryBillFrm.jsp -->
                                                <a href="${pageContext.request.contextPath}/history-bill?customerId=${stat.id}&customerName=${stat.fullname}&startDate=${param.startDate}&endDate=${param.endDate}" 
                                                   class="bill-btn" style="display: inline-block; text-decoration: none;">📋 Xem hóa đơn</a>
                                            </td>
                                        </tr>
                                        <c:set var="totalRevenue" value="${totalRevenue + stat.totalRevenue}" />
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr style="background: linear-gradient(135deg, #5a67d8 0%, #667eea 100%); color: white; font-weight: 700;">
                                        <td colspan="4" style="text-align: right; padding: 15px 20px; font-size: 1.1em;">
                                            💰 <strong>Tổng doanh thu:</strong>
                                        </td>
                                        <td style="padding: 15px 20px; font-size: 1.2em; color: #ffeb3b;">
                                            <fmt:formatNumber value="${totalRevenue}" pattern="#,###" />₫
                                        </td>
                                        <td style="padding: 15px 20px;"></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">
                            📭 Không tìm thấy khách hàng nào trong khoảng thời gian này
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        
        <div class="center">
            <div class="button-row">
                <a href="${pageContext.request.contextPath}/ViewStatisticsFrm.jsp" class="back-btn">⬅️ Quay lại chọn loại thống kê</a>
            </div>
        </div>
    </div>
</body>
</html>
