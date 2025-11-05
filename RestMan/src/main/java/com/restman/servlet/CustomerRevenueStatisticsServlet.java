package com.restman.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CustomerRevenueStatisticsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String startDate = req.getParameter("startDate");
        String endDate = req.getParameter("endDate");
        java.util.List<com.restman.model.CustomerRevenueStatistics> list = java.util.Collections.emptyList();
        if (startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty()) {
            try {
                java.time.LocalDateTime start = java.time.LocalDate.parse(startDate).atStartOfDay();
                java.time.LocalDateTime end = java.time.LocalDate.parse(endDate).atTime(23,59,59);
                com.restman.dao.CustomerRevenueStatisticsDAO dao = new com.restman.dao.CustomerRevenueStatisticsDAO();
                list = dao.getRevenueCustomer(start, end);
            } catch (Exception e) {
                req.setAttribute("error", "Ngày không hợp lệ!");
            }
        }
        req.setAttribute("listCustomerRevenue", list);
        req.getRequestDispatcher("/ViewCustomerFrm.jsp").forward(req, resp);
    }
}
