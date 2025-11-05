package com.restman.servlet;

import com.restman.model.Staff;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ManagerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy tên staff từ URL parameter
        String staffName = req.getParameter("staffName");
        
        // Truyền thông tin staff sang JSP
        if (staffName != null && !staffName.trim().isEmpty()) {
            req.setAttribute("staffName", staffName);
        }
        
        req.getRequestDispatcher("/HomePageManagerFrm.jsp").forward(req, resp);
    }
}
