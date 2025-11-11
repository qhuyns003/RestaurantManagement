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
            try {
                java.util.List<com.restman.model.Bill> billList = dao.getHistoryBill(customerId);
                
                if (acceptHeader != null && acceptHeader.contains("application/json")) {
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    
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
                    req.setAttribute("billList", billList);
                    req.getRequestDispatcher("/ViewHistoryBillFrm.jsp").forward(req, resp);
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
            }
        } else if (billId != null) {
            try {
                com.restman.model.Bill bill = dao.getDetailBill(billId);
                
                if (bill != null) {
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    
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
                    
                    String json = gson.toJson(bill);
                    resp.getWriter().write(json);
                } else {
                    resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    resp.getWriter().write("{\"error\": \"Bill not found\"}");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
            }
        } else {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"error\": \"Missing required parameter: customerId or billId\"}");
        }
    }
}
