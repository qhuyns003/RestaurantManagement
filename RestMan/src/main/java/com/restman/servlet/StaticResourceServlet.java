package com.restman.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet("/css/*")
public class StaticResourceServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Remove leading slash
        String resourcePath = pathInfo.substring(1);
        
        // First try webapp path
        Path webappPath = Paths.get(getServletContext().getRealPath("/css"), resourcePath);
        
        if (Files.exists(webappPath)) {
            // Set content type based on file extension
            String contentType = getServletContext().getMimeType(resourcePath);
            response.setContentType(contentType != null ? contentType : "application/octet-stream");
            
            // Copy file to response
            try (OutputStream out = response.getOutputStream()) {
                Files.copy(webappPath, out);
            }
            return;
        }
        
        // Try classpath resources
        try (InputStream is = getServletContext().getResourceAsStream("/css/" + resourcePath)) {
            if (is != null) {
                // Set content type based on file extension
                String contentType = getServletContext().getMimeType(resourcePath);
                response.setContentType(contentType != null ? contentType : "application/octet-stream");
                
                // Copy stream to response
                try (OutputStream out = response.getOutputStream()) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = is.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                }
                return;
            }
        }
        
        // Resource not found
        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }
}