package com.restman.servlet;

import com.restman.dao.StaffDAO;
import com.restman.model.Staff;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;

public class StaffServlet extends HttpServlet {
    private final StaffDAO staffDAO = new StaffDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/LoginFrm.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        Staff staff = staffDAO.checkLogin(username, password);
        if (staff != null) {
            HttpSession session = req.getSession();
            session.setAttribute("staff", staff);
            // Redirect với tên staff trong URL
            String encodedName = java.net.URLEncoder.encode(staff.getFullname(), "UTF-8");
            resp.sendRedirect("/manager?staffName=" + encodedName);
        } else {
            req.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            req.getRequestDispatcher("/LoginFrm.jsp").forward(req, resp);
        }
    }
}
