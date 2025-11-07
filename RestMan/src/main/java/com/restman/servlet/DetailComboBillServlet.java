package com.restman.servlet;

import com.restman.dao.DetailComboBillDAO;
import com.restman.model.DetailComboBill;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class DetailComboBillServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String billId = request.getParameter("billId");
        
        if (billId == null || billId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Bill ID is required");
            return;
        }
        
        try {
            DetailComboBillDAO detailComboBillDAO = new DetailComboBillDAO();
            List<DetailComboBill> comboList = detailComboBillDAO.getDetailComboBill(billId);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            PrintWriter out = response.getWriter();
            
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < comboList.size(); i++) {
                DetailComboBill item = comboList.get(i);
                if (i > 0) json.append(",");
                json.append("{");
                json.append("\"id\":\"").append(item.getId()).append("\",");
                json.append("\"quantity\":").append(item.getQuantity()).append(",");
                json.append("\"price\":").append(item.getPrice()).append(",");
                json.append("\"combo\":{");
                json.append("\"id\":\"").append(item.getCombo().getId()).append("\",");
                json.append("\"name\":\"").append(escapeJson(item.getCombo().getName())).append("\",");
                json.append("\"price\":").append(item.getCombo().getPrice());
                json.append("}");
                json.append("}");
            }
            json.append("]");
            
            out.print(json.toString());
            out.flush();
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                             "Error retrieving combo details: " + e.getMessage());
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
