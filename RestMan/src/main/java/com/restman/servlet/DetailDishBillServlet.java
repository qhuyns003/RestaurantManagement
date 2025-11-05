package com.restman.servlet;

import com.restman.dao.DetailDishBillDAO;
import com.restman.model.DetailDishBill;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Bước 41-49: ViewBillFrm.jsp gọi DetailDishBillServlet để lấy danh sách món ăn
 */
public class DetailDishBillServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String billId = request.getParameter("billId");
        
        if (billId == null || billId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Bill ID is required");
            return;
        }
        
        try {
            // Bước 43-48: doGet() gọi DetailDishBillDAO
            DetailDishBillDAO detailDishBillDAO = new DetailDishBillDAO();
            List<DetailDishBill> dishList = detailDishBillDAO.getDetailDishBill(billId);
            
            // Bước 49: Trả kết quả về cho ViewBillFrm.jsp dưới dạng JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            PrintWriter out = response.getWriter();
            
            // Tạo JSON thủ công để tránh circular reference
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < dishList.size(); i++) {
                DetailDishBill item = dishList.get(i);
                if (i > 0) json.append(",");
                json.append("{");
                json.append("\"id\":\"").append(item.getId()).append("\",");
                json.append("\"quantity\":").append(item.getQuantity()).append(",");
                json.append("\"price\":").append(item.getPrice()).append(",");
                json.append("\"dish\":{");
                json.append("\"id\":\"").append(item.getDish().getId()).append("\",");
                json.append("\"name\":\"").append(escapeJson(item.getDish().getName())).append("\",");
                json.append("\"price\":").append(item.getDish().getPrice());
                json.append("}");
                json.append("}");
            }
            json.append("]");
            
            out.print(json.toString());
            out.flush();
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                             "Error retrieving dish details: " + e.getMessage());
        }
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
