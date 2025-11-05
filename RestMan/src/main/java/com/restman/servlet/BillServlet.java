package com.restman.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class BillServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String customerId = req.getParameter("customerId");
        String billId = req.getParameter("billId");
        String acceptHeader = req.getHeader("Accept");
        
        com.restman.dao.BillDAO dao = new com.restman.dao.BillDAO();
        
        if (customerId != null) {
            // Bước 20: ViewHistoryBillFrm.jsp gọi BillServlet
            try {
                java.util.List<com.restman.model.Bill> billList = dao.getHistoryBill(customerId);
                
                // Nếu request yêu cầu JSON (từ AJAX), trả về JSON
                if (acceptHeader != null && acceptHeader.contains("application/json")) {
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    
                    // Tạo Gson với TypeAdapter cho LocalDateTime
                    com.google.gson.GsonBuilder gsonBuilder = new com.google.gson.GsonBuilder();
                    gsonBuilder.registerTypeAdapter(java.time.LocalDateTime.class, 
                        new com.google.gson.JsonSerializer<java.time.LocalDateTime>() {
                            @Override
                            public com.google.gson.JsonElement serialize(java.time.LocalDateTime src, 
                                    java.lang.reflect.Type typeOfSrc, 
                                    com.google.gson.JsonSerializationContext context) {
                                return new com.google.gson.JsonPrimitive(src.toString());
                            }
                        });
                    com.google.gson.Gson gson = gsonBuilder.create();
                    
                    String json = gson.toJson(billList);
                    resp.getWriter().write(json);
                } else {
                    // Nếu là request thông thường, forward đến JSP (backward compatibility)
                    req.setAttribute("billList", billList);
                    req.getRequestDispatcher("/WEB-INF/jsp/ViewHistoryBillFrm.jsp").forward(req, resp);
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
            }
        } else if (billId != null) {
            // Bước 32-40: Xử lý bill-detail - CHỈ lấy thông tin Bill
            // ViewBillFrm.jsp sẽ tự gọi DetailDishBillServlet và DetailComboBillServlet
            com.restman.model.Bill bill = dao.getDetailBill(billId);
            
            if (bill != null) {
                req.setAttribute("bill", bill);
                req.getRequestDispatcher("/WEB-INF/jsp/ViewBillFrm.jsp").forward(req, resp);
            } else {
                resp.sendRedirect("/");
            }
        } else {
            resp.sendRedirect("/");
        }
    }
}
