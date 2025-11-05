


package com.restman;

import com.restman.servlet.ManagerServlet;
import com.restman.servlet.DetailDishBillServlet;
import com.restman.servlet.DetailComboBillServlet;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import com.restman.servlet.CustomerRevenueStatisticsServlet;
import com.restman.servlet.BillServlet;
import com.restman.servlet.DishServlet;
import com.restman.servlet.StaffServlet;

@SpringBootApplication
public class RestManApplication extends SpringBootServletInitializer implements WebMvcConfigurer {
    public static void main(String[] args) {
        SpringApplication.run(RestManApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(RestManApplication.class);
    }
    
    @Bean
    public ServletRegistrationBean<DishServlet> dishServletRegistration() {
        ServletRegistrationBean<DishServlet> registration = new ServletRegistrationBean<>(
                new DishServlet(), "/dish/*", "/", "/home");
        registration.setName("dishServlet");
        registration.setLoadOnStartup(1);
        return registration;
    }
    @Bean
    public ServletRegistrationBean<CustomerRevenueStatisticsServlet> customerRevenueStatisticsServletRegistration() {
        ServletRegistrationBean<CustomerRevenueStatisticsServlet> registration = new ServletRegistrationBean<>(
                new CustomerRevenueStatisticsServlet(), "/statistics/customer");
        registration.setName("customerRevenueStatisticsServlet");
        registration.setLoadOnStartup(1);
        return registration;
    }

    @Bean
    public ServletRegistrationBean<StaffServlet> staffServletRegistration() {
        ServletRegistrationBean<StaffServlet> registration = new ServletRegistrationBean<>(
                new StaffServlet(), "/staff-login");
        registration.setName("staffServlet");
        registration.setLoadOnStartup(1);
        return registration;
    }

    @Bean
    public ServletRegistrationBean<ManagerServlet> managerServletRegistration() {
        ServletRegistrationBean<ManagerServlet> registration = new ServletRegistrationBean<>(
                new ManagerServlet(), "/manager");
        registration.setName("managerServlet");
        registration.setLoadOnStartup(1);
        return registration;
    }

    @Bean
    public ServletRegistrationBean<BillServlet> billServletRegistration() {
        ServletRegistrationBean<BillServlet> registration = new ServletRegistrationBean<>(
                new BillServlet(), "/history-bill", "/bill-detail");
        registration.setName("billServlet");
        registration.setLoadOnStartup(1);
        return registration;
    }

    @Bean
    public ServletRegistrationBean<DetailDishBillServlet> detailDishBillServletRegistration() {
        ServletRegistrationBean<DetailDishBillServlet> registration = new ServletRegistrationBean<>(
                new DetailDishBillServlet(), "/detail-dish-bill");
        registration.setName("detailDishBillServlet");
        registration.setLoadOnStartup(1);
        return registration;
    }

    @Bean
    public ServletRegistrationBean<DetailComboBillServlet> detailComboBillServletRegistration() {
        ServletRegistrationBean<DetailComboBillServlet> registration = new ServletRegistrationBean<>(
                new DetailComboBillServlet(), "/detail-combo-bill");
        registration.setName("detailComboBillServlet");
        registration.setLoadOnStartup(1);
        return registration;
    }
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/META-INF/resources/css/", "classpath:/static/css/", 
                                     "classpath:/resources/css/", "classpath:/public/css/",
                                     "/WEB-INF/css/", "/css/", "classpath:/META-INF/resources/");
    }
}
