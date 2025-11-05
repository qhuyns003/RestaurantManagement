<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch sử hóa đơn khách hàng</title>
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
        .customer-info { 
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px); 
            padding: 25px 35px; 
            border-radius: 15px; 
            margin-bottom: 30px; 
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); 
            border: 1px solid rgba(255, 255, 255, 0.2); 
        }
        .customer-info h2 { 
            color: #5a67d8; 
            margin-bottom: 15px; 
            font-size: 1.5em; 
            font-weight: 600; 
        }
        .customer-info .info-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); 
            gap: 15px; 
        }
        .customer-info .info-item { 
            color: #4a5568; 
            font-size: 1em; 
        }
        .customer-info .info-label { 
            font-weight: 600; 
            color: #2d3748; 
        }
        .bills-card { 
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px); 
            padding: 30px; 
            border-radius: 15px; 
            margin-bottom: 30px; 
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); 
            border: 1px solid rgba(255, 255, 255, 0.2); 
        }
        .bills-table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 20px; 
        }
        .table-container {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }
        .bills-table th { 
            background: linear-gradient(135deg, #5a67d8 0%, #667eea 100%); 
            color: white; 
            padding: 15px 12px; 
            text-align: left; 
            font-weight: 600; 
            border: none; 
            font-size: 0.9em;
        }
        .bills-table th:first-child { 
            border-radius: 10px 0 0 0; 
        }
        .bills-table th:last-child { 
            border-radius: 0 10px 0 0; 
        }
        .bills-table td { 
            padding: 12px; 
            border-bottom: 1px solid #e2e8f0; 
            transition: background-color 0.2s; 
            font-size: 0.9em;
        }
        .bills-table tbody tr:hover { 
            background-color: #f7fafc; 
        }
        .bills-table tbody tr:last-child td { 
            border-bottom: none; 
        }
        .total-amount { 
            font-weight: 600; 
            color: #38a169; 
            font-size: 1em; 
        }
        .detail-btn { 
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%); 
            color: white; 
            border: none; 
            padding: 6px 12px; 
            border-radius: 6px; 
            font-size: 0.85em; 
            cursor: pointer; 
            transition: all 0.3s ease; 
        }
        .detail-btn:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 6px 20px rgba(72, 187, 120, 0.3); 
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
        }
        .bill-date { 
            color: #4a5568; 
        }
        .bill-id { 
            font-weight: 600; 
            color: #2d3748; 
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
            .bills-table th, .bills-table td { 
                padding: 8px 6px; 
                font-size: 0.8em; 
            }
            .header h1 { font-size: 1.8em; }
            .customer-info .info-grid { 
                grid-template-columns: 1fr; 
            }
        }
        
        @media (max-width: 480px) {
            .bills-table th, .bills-table td { 
                padding: 6px 4px; 
                font-size: 0.75em; 
            }
            .detail-btn, .back-btn { 
                padding: 8px 16px; 
                font-size: 0.8em; 
            }
        }
        .status-active { 
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%); 
            color: white; 
            padding: 4px 8px; 
            border-radius: 4px; 
            font-size: 0.8em; 
            font-weight: 600; 
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>📋 Lịch sử hóa đơn khách hàng</h1>
    </div>
    
    <div class="container">
        <c:if test="${not empty param.customerName}">
            <div class="customer-info">
                <h2>👤 Thông tin thống kê</h2>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Khách hàng:</span> ${param.customerName}
                    </div>
                    <c:if test="${not empty param.startDate && not empty param.endDate}">
                        <div class="info-item">
                            <span class="info-label">📅 Thời gian:</span> ${param.startDate} đến ${param.endDate}
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>
        
        <div class="bills-card">
            <div id="billsContent">
                <div class="no-data">⏳ Đang tải dữ liệu...</div>
            </div>
        </div>
        
        <script>
        // Bước 20: ViewHistoryBillFrm.jsp gọi BillServlet để lấy danh sách hóa đơn
        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const customerId = urlParams.get('customerId');
            const startDate = urlParams.get('startDate');
            const endDate = urlParams.get('endDate');
            
            if (customerId) {
                let url = '/history-bill?customerId=' + encodeURIComponent(customerId);
                if (startDate && endDate) {
                    url += '&startDate=' + encodeURIComponent(startDate) + '&endDate=' + encodeURIComponent(endDate);
                }
                
                fetch(url, {
                    headers: {
                        'Accept': 'application/json'
                    }
                })
                    .then(response => {
                        if (!response.ok) {
                            return response.text().then(text => {
                                throw new Error('Server error: ' + response.status + ' - ' + text);
                            });
                        }
                        return response.json();
                    })
                    .then(data => {
                        const billsContent = document.getElementById('billsContent');
                        
                        if (!data || data.length === 0) {
                            billsContent.innerHTML = '<div class="no-data">📭 Không có hóa đơn nào cho khách hàng này</div>';
                            return;
                        }
                        
                        let totalRevenue = 0;
                        let tableHTML = `
                            <div class="table-container">
                                <table class="bills-table">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>📄 Mã hóa đơn</th>
                                            <th>📅 Ngày lập</th>
                                            <th>💰 Tổng tiền</th>
                                            <th>🪑 Bàn</th>
                                            <th>🔧 Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>`;
                        
                        data.forEach((bill, index) => {
                            totalRevenue += bill.total || 0;
                            const formattedTotal = formatCurrency(bill.total);
                            const formattedDate = formatDateTime(bill.dateTime);
                            const tableName = bill.table && bill.table.number ? 'Bàn ' + bill.table.number : '';
                            const billCode = bill.code || bill.id; // Lấy mã HD từ trường code
                            
                            tableHTML += '<tr>';
                            tableHTML += '<td>' + (index + 1) + '</td>';
                            tableHTML += '<td class="bill-id">' + billCode + '</td>';
                            tableHTML += '<td class="bill-date">' + formattedDate + '</td>';
                            tableHTML += '<td class="total-amount">' + formattedTotal + '₫</td>';
                            tableHTML += '<td>' + tableName + '</td>';
                            tableHTML += '<td>';
                            tableHTML += '<form action="/bill-detail" method="get" style="margin:0;">';
                            tableHTML += '<input type="hidden" name="billId" value="' + bill.id + '" />';
                            tableHTML += '<button type="submit" class="detail-btn">🔍 Xem chi tiết</button>';
                            tableHTML += '</form>';
                            tableHTML += '</td>';
                            tableHTML += '</tr>';
                        });
                        
                        const formattedTotalRevenue = formatCurrency(totalRevenue);
                        tableHTML += `
                                    </tbody>
                                    <tfoot>
                                        <tr style="background: linear-gradient(135deg, #5a67d8 0%, #667eea 100%); color: white; font-weight: 700;">
                                            <td colspan="3" style="text-align: right; padding: 15px 20px; font-size: 1.1em;">
                                                💰 <strong>Tổng doanh thu:</strong>
                                            </td>
                                            <td style="padding: 15px 20px; font-size: 1.2em; color: #ffeb3b;">
                                                ` + formattedTotalRevenue + `₫
                                            </td>
                                            <td colspan="2" style="padding: 15px 20px;"></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>`;
                        
                        billsContent.innerHTML = tableHTML;
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        document.getElementById('billsContent').innerHTML = 
                            '<div class="no-data">⚠️ Lỗi khi tải dữ liệu: ' + error.message + '</div>';
                    });
            }
        });
        
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN').format(amount || 0);
        }
        
        function formatDateTime(dateTimeStr) {
            if (!dateTimeStr) return '';
            try {
                // dateTimeStr format: "2025-11-02T00:00" hoặc "2025-11-02T00:00:00"
                // Thêm :00 nếu thiếu giây
                let fullDateTimeStr = dateTimeStr;
                if (dateTimeStr.length === 16) { // Format: "2025-11-02T00:00"
                    fullDateTimeStr = dateTimeStr + ':00';
                }
                
                const date = new Date(fullDateTimeStr);
                
                // Kiểm tra date hợp lệ
                if (isNaN(date.getTime())) {
                    console.error('Invalid date:', dateTimeStr);
                    return dateTimeStr;
                }
                
                const day = String(date.getDate()).padStart(2, '0');
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const year = date.getFullYear();
                const hours = String(date.getHours()).padStart(2, '0');
                const minutes = String(date.getMinutes()).padStart(2, '0');
                return day + '/' + month + '/' + year + ' ' + hours + ':' + minutes;
            } catch (e) {
                console.error('Error formatting date:', e, dateTimeStr);
                return dateTimeStr;
            }
        }
        </script>
        
        <div class="center">
            <div class="button-row">
                <a href="/ViewCustomerFrm.jsp" class="back-btn">⬅️ Quay lại</a>
            </div>
        </div>
    </div>
</body>
</html>
