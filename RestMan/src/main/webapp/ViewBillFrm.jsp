<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết hóa đơn</title>
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
            max-width: 1000px; 
            margin: 0 auto; 
            padding: 40px 20px; 
        }
        .bill-info { 
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px); 
            padding: 30px; 
            border-radius: 15px; 
            margin-bottom: 30px; 
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); 
            border: 1px solid rgba(255, 255, 255, 0.2); 
        }
        .bill-info table { 
            width: 100%; 
            border-collapse: collapse; 
        }
        .bill-info table td { 
            padding: 12px 0; 
            border-bottom: 1px solid #e2e8f0;
        }
        .bill-info table td:first-child { 
            font-weight: 600; 
            width: 25%; 
            color: #2d3748;
        }
        .bill-info table td:nth-child(2) { 
            width: 25%; 
            color: #4a5568;
        }
        .bill-info table td:nth-child(3) { 
            font-weight: 600; 
            width: 25%; 
            color: #2d3748;
        }
        .bill-info table td:nth-child(4) { 
            width: 25%; 
            color: #4a5568;
        }
        .section-title { 
            background: linear-gradient(135deg, #5a67d8 0%, #667eea 100%); 
            color: white; 
            padding: 15px 25px; 
            border-radius: 10px; 
            margin: 30px 0 20px 0; 
            font-size: 1.2em; 
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(90, 103, 216, 0.3);
        }
        .items-card { 
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px); 
            border-radius: 15px; 
            overflow: hidden; 
            margin-bottom: 20px; 
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); 
            border: 1px solid rgba(255, 255, 255, 0.2); 
        }
        table.items { 
            width: 100%; 
            border-collapse: collapse; 
        }
        .table-container {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }
        table.items th { 
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%); 
            color: white; 
            padding: 15px 20px; 
            text-align: left; 
            font-weight: 600; 
        }
        table.items td { 
            padding: 15px 20px; 
            border-bottom: 1px solid #e2e8f0; 
            transition: background-color 0.2s;
        }
        table.items tbody tr:hover { 
            background-color: #f7fafc; 
        }
        table.items tbody tr:last-child td { 
            border-bottom: none; 
        }
        .price { 
            font-weight: 600; 
            color: #38a169; 
        }
        .total-section { 
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px); 
            padding: 25px; 
            border-radius: 15px; 
            margin-top: 30px; 
            text-align: right; 
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); 
            border: 1px solid rgba(255, 255, 255, 0.2); 
        }
        .total-section .total { 
            font-size: 1.4em; 
            font-weight: 700; 
            margin-top: 10px; 
            color: #e53e3e;
            padding: 15px 0;
            border-top: 2px solid #e2e8f0;
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
            background: rgba(255, 255, 255, 0.95); 
            border-radius: 10px;
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
            .info-grid { grid-template-columns: 1fr; }
            table.items th, table.items td { 
                padding: 8px 6px; 
                font-size: 0.8em; 
            }
            .header h1 { font-size: 1.8em; }
            .bill-info table td { padding: 8px 0; }
        }
        
        @media (max-width: 480px) {
            table.items th, table.items td { 
                padding: 6px 4px; 
                font-size: 0.75em; 
            }
            .back-btn { 
                padding: 10px 20px; 
                font-size: 0.9em; 
            }
            .total-section .total { font-size: 1.2em; }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🧾 Chi tiết hóa đơn</h1>
    </div>
    
    <div class="container">
        <div id="billInfoContainer">
            <div class="no-data">⏳ Đang tải thông tin hóa đơn...</div>
        </div>
        
        <div id="billDetailsContainer" style="display: none;">
            <h2 class="section-title">🍜 Danh sách món ăn</h2>
            <div class="items-card">
                <div id="dishListContainer">
                    <div class="no-data">⏳ Đang tải danh sách món ăn...</div>
                </div>
            </div>
            
            <h2 class="section-title">🍱 Danh sách combo</h2>
            <div class="items-card">
                <div id="comboListContainer">
                    <div class="no-data">⏳ Đang tải danh sách combo...</div>
                </div>
            </div>
            
            <div class="total-section">
                <div class="total" id="subtotalAmount">💵 Tạm tính: <span id="subtotalValue">0</span>₫</div>
                <div class="total" id="discountAmount">🎟️ Giảm giá: <span id="discountValue">0</span>₫</div>
                <div class="total" id="totalAmount">💰 Tổng tiền: <span id="totalValue">0</span>₫</div>
            </div>
            
            <div class="center">
                <div class="button-row">
                    <a href="#" id="backButton" class="back-btn">⬅️ Quay lại danh sách hóa đơn</a>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        const contextPath = '${pageContext.request.contextPath}';

        let billData = null;
        let dishTotal = 0;
        let comboTotal = 0;
        let discountAmount = 0;

        function formatNumber(num) {
            return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        }

        function formatDateTime(dateTimeStr) {
            if (!dateTimeStr) return '';
            try {
                let fullDateTimeStr = dateTimeStr;
                if (dateTimeStr.length === 16) { 
                    fullDateTimeStr = dateTimeStr + ':00';
                }
                
                const date = new Date(fullDateTimeStr);
                
                if (isNaN(date.getTime())) {
                    return dateTimeStr;
                }
                
                const day = String(date.getDate()).padStart(2, '0');
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const year = date.getFullYear();
                const hours = String(date.getHours()).padStart(2, '0');
                const minutes = String(date.getMinutes()).padStart(2, '0');
                return day + '/' + month + '/' + year + ' ' + hours + ':' + minutes;
            } catch (e) {
                return dateTimeStr;
            }
        }

        function updateTotalAmount() {
            const subtotal = dishTotal + comboTotal;
            const total = subtotal - discountAmount;
            document.getElementById('subtotalValue').textContent = formatNumber(subtotal);
            document.getElementById('discountValue').textContent = formatNumber(discountAmount);
            document.getElementById('totalValue').textContent = formatNumber(total);
        }

        function loadBillInfo(billId) {
            console.log('Loading bill info for billId:', billId);
            
            fetch(contextPath + '/bill-detail?billId=' + billId, {
                headers: {
                    'Accept': 'application/json'
                }
            })
                .then(response => {
                    console.log('Bill response status:', response.status);
                    if (!response.ok) {
                        throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                    }
                    return response.json();
                })
                .then(bill => {
                    console.log('Bill data:', bill);
                    billData = bill;
                    discountAmount = bill.discount || 0;
                    
                    // Hiển thị thông tin hóa đơn
                    let billInfoHTML = '<div class="bill-info"><table>';
                    billInfoHTML += '<tr>';
                    billInfoHTML += '<td>📄 Mã hóa đơn:</td>';
                    billInfoHTML += '<td>' + (bill.code || bill.id) + '</td>';
                    billInfoHTML += '<td>📅 Ngày tạo:</td>';
                    billInfoHTML += '<td>' + formatDateTime(bill.dateTime) + '</td>';
                    billInfoHTML += '</tr>';
                    billInfoHTML += '<tr>';
                    billInfoHTML += '<td>👤 Khách hàng:</td>';
                    billInfoHTML += '<td>' + (bill.customer ? bill.customer.fullname : 'N/A') + '</td>';
                    billInfoHTML += '<td>🪑 Bàn:</td>';
                    billInfoHTML += '<td>' + (bill.table ? (bill.table.name || 'Bàn ' + bill.table.number) : 'N/A') + '</td>';
                    billInfoHTML += '</tr>';
                    billInfoHTML += '</table></div>';
                    
                    document.getElementById('billInfoContainer').innerHTML = billInfoHTML;
                    document.getElementById('billDetailsContainer').style.display = 'block';

                    if (bill.customer && bill.customer.id) {
                        const backBtn = document.getElementById('backButton');
                        backBtn.href = contextPath + '/ViewHistoryBillFrm.jsp?customerId=' + bill.customer.id + 
                                      '&customerName=' + encodeURIComponent(bill.customer.fullname || '');
                    }

                    loadDishList(billId);
                    loadComboList(billId);
                })
                .catch(error => {
                    console.error('Error loading bill info:', error);
                    document.getElementById('billInfoContainer').innerHTML = 
                        '<div class="no-data">❌ Lỗi khi tải thông tin hóa đơn: ' + error.message + '</div>';
                });
        }

        function loadDishList(billId) {
            console.log('Loading dishes for billId:', billId);
            
            fetch(contextPath + '/detail-dish-bill?billId=' + billId, {
                headers: {
                    'Accept': 'application/json'
                }
            })
                .then(response => {
                    console.log('Dish response status:', response.status);
                    if (!response.ok) {
                        throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                    }
                    return response.json();
                })
                .then(dishList => {
                    console.log('Dish list:', dishList);
                    const container = document.getElementById('dishListContainer');
                    dishTotal = 0; 
                    
                    if (dishList.length === 0) {
                        container.innerHTML = '<div class="no-data">📭 Không có món ăn nào trong hóa đơn này</div>';
                    } else {
                        let html = '<div class="table-container"><table class="items">';
                        html += '<thead><tr><th>STT</th><th>Tên món</th><th>Số lượng</th><th>Đơn giá</th><th>Thành tiền</th></tr></thead>';
                        html += '<tbody>';
                        dishList.forEach((dish, index) => {
                            const subtotal = dish.quantity * dish.price;
                            dishTotal += subtotal; 
                            html += '<tr>';
                            html += '<td>' + (index + 1) + '</td>';
                            html += '<td>' + (dish.dish ? dish.dish.name : 'N/A') + '</td>';
                            html += '<td>' + dish.quantity + '</td>';
                            html += '<td class="price">' + formatNumber(dish.price) + '₫</td>';
                            html += '<td class="price">' + formatNumber(subtotal) + '₫</td>';
                            html += '</tr>';
                        });
                        html += '</tbody></table></div>';
                        container.innerHTML = html;
                    }
                    updateTotalAmount(); 
                })
                .catch(error => {
                    console.error('Error loading dish list:', error);
                    document.getElementById('dishListContainer').innerHTML = 
                        '<div class="no-data">❌ Lỗi: ' + error.message + '</div>';
                });
        }

        function loadComboList(billId) {
            console.log('Loading combos for billId:', billId);
            
            fetch(contextPath + '/detail-combo-bill?billId=' + billId, {
                headers: {
                    'Accept': 'application/json'
                }
            })
                .then(response => {
                    console.log('Combo response status:', response.status);
                    if (!response.ok) {
                        throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                    }
                    return response.json();
                })
                .then(comboList => {
                    console.log('Combo list:', comboList);
                    const container = document.getElementById('comboListContainer');
                    comboTotal = 0; 
                    
                    if (comboList.length === 0) {
                        container.innerHTML = '<div class="no-data">📭 Không có combo nào trong hóa đơn này</div>';
                    } else {
                        let html = '<div class="table-container"><table class="items">';
                        html += '<thead><tr><th>STT</th><th>Tên combo</th><th>Số lượng</th><th>Đơn giá</th><th>Thành tiền</th></tr></thead>';
                        html += '<tbody>';
                        comboList.forEach((combo, index) => {
                            const subtotal = combo.quantity * combo.price;
                            comboTotal += subtotal; 
                            html += '<tr>';
                            html += '<td>' + (index + 1) + '</td>';
                            html += '<td>' + (combo.combo ? combo.combo.name : 'N/A') + '</td>';
                            html += '<td>' + combo.quantity + '</td>';
                            html += '<td class="price">' + formatNumber(combo.price) + '₫</td>';
                            html += '<td class="price">' + formatNumber(subtotal) + '₫</td>';
                            html += '</tr>';
                        });
                        html += '</tbody></table></div>';
                        container.innerHTML = html;
                    }
                    updateTotalAmount(); 
                })
                .catch(error => {
                    console.error('Error loading combo list:', error);
                    document.getElementById('comboListContainer').innerHTML = 
                        '<div class="no-data">❌ Lỗi: ' + error.message + '</div>';
                });
        }

        window.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const billId = urlParams.get('billId');
            
            if (billId) {
                loadBillInfo(billId);
            } else {
                document.getElementById('billInfoContainer').innerHTML = 
                    '<div class="no-data">❌ Không tìm thấy mã hóa đơn trong URL</div>';
            }
        });
    </script>
</body>
</html>