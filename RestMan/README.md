# Restaurant Management System - Dish Module

This project implements a Dish search module for a restaurant management system, following the flow diagram provided.

## Project Structure

- `src/main/java/com/restman/model/Dish.java`: Dish entity class with id, name, description, and price
- `src/main/java/com/restman/dao/DishDAO.java`: Data access object with in-memory data and search methods
- `src/main/java/com/restman/servlet/DishServlet.java`: Servlet that handles dish search and detail requests
- `src/main/webapp/WEB-INF/jsp/*.jsp`: JSP view templates for user interface

## How to Build and Run

### Prerequisites
- Java 8 or higher
- Maven 3.6 or higher

### Build Instructions
```
mvn clean package
```

### Run Instructions
```
java -jar target/restman-dish-module-1.0-SNAPSHOT.jar
```

### Access the Application
- Open your browser and go to: http://localhost:8080/
- Click on "Search Dishes" to access the search form
- Enter a search term and click "Search" to find dishes
- Click on "View" for a dish to see its details

## Features
1. Home page with navigation links
2. Dish search functionality by name
3. Detailed dish information display

## Implementation Notes
- Uses Spring Boot with embedded Tomcat for easy deployment
- JSP views for rendering UI components
- Servlet-based implementation according to the flow diagram
- In-memory data store for demonstration purposes