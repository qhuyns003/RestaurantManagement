package com.restman.servlet;

import com.restman.dao.DishDAO;
import com.restman.model.Dish;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class DishServlet extends HttpServlet {

    private final DishDAO dishDAO = new DishDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        String action = request.getParameter("action");
        
        if ("/".equals(path) || "/home".equals(path)) {
            // Home page
            request.getRequestDispatcher("/WEB-INF/jsp/HomePageFrm.jsp").forward(request, response);
            return;
        }
        
        if ("/dish".equals(path)) {
            if (action == null) {
                // Không dùng nữa - HomePageFrm gọi trực tiếp SearchDishesFrm.jsp
                request.getRequestDispatcher("/SearchDishesFrm.jsp").forward(request, response);
            } else if ("search".equals(action)) {
                // Bước 5-13: SearchDishesFrm.jsp gọi DishServlet search
                String dishName = request.getParameter("dishName");
                if (dishName != null && !dishName.trim().isEmpty()) {
                    List<Dish> list = dishDAO.searchByName(dishName);
                    request.setAttribute("listDish", list);
                    request.setAttribute("searchKey", dishName);
                }
                request.getRequestDispatcher("/SearchDishesFrm.jsp").forward(request, response);
            } else if ("get-detail-json".equals(action)) {
                // Bước 17-25: DetailDishInfoFrm.jsp gọi servlet lấy JSON
                String dishId = request.getParameter("dishId");
                Dish dish = dishDAO.getDetailDishInfo(dishId);
                
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                
                PrintWriter out = response.getWriter();
                Gson gson = new Gson();
                out.print(gson.toJson(dish));
                out.flush();
            }
        }
    }
}