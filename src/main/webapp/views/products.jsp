<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: This MC
  Date: 26/12/2023
  Time: 7:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="<%=request.getContextPath()%>/resources/css/userStyle.css" rel="stylesheet"/>
    <title>List Product</title>
</head>
<body>
<div class="container">
    <header class="header">
        <h1>Product Manager</h1>
    </header>
    <div class="main-content">
        <div class="left sidebar">
            <ul>
                <li><a href="<%=request.getContextPath()%>/dashboardController">Dashboard</a></li>
                <li><a href="<%=request.getContextPath()%>/categoryController/findAll">Category Management</a></li>
                <li><a href="<%=request.getContextPath()%>/productController/findAll">Product Management</a></li>
                <li><a href="<%=request.getContextPath()%>/customerAccountController/findAll">Customer Management</a>
                </li>
                <li><a href="<%=request.getContextPath()%>/orderController/findAll">Order Management</a></li>
            </ul>
        </div>
        <div class="content">
            <%--            Tìm kiếm và sắp xếp--%>
            <div class="table-controls">
                <div class="search-container">
                    <form action="<%=request.getContextPath()%>/productController/search" method="get">
                        <input type="text" id="searchInput" name="searchInput" placeholder="Enter product name">
                        <button class="btn btn-search">Search</button>
                    </form>
                </div>
                <div class="sort-container">
                    <form action="<%=request.getContextPath()%>/productController/sortByName" method="get">
                        <select id="sortSelect" name="sortSelect">
                            <option value="asc">Ascending</option>
                            <option value="desc">Descending</option>
                        </select>
                        <button class="btn btn-sort">Sort</button>
                    </form>
                </div>
            </div>

            <%--             Bảng--%>
            <table border="1">
                <thead>
                <tr>
                    <th>Product Id</th>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Avatar</th>
                    <th>Other Images</th>
                    <th>Description</th>
                    <th>Category</th>
                    <th>Unit</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${productList}" var="product">
                    <tr>
                        <td>${product.id}</td>
                        <td>${product.productName}</td>
                        <td>${product.price}</td>
                        <td><img src="${product.avatarImage}" alt="${product.productName}" height="50" width="50"/></td>
                        <td>
                            <c:forEach items="${product.listImages}" var="image">
                                <img src="${image.imageLink}" alt="${product.productName}" height="50" width="50"/>
                            </c:forEach>
                        </td>
                        <td>${product.description}</td>
                        <td>${product.category.categoryName}</td>
                        <td>${product.unit}</td>
                        <td>${product.status?"Active":"Inactive"}</td>
                        <td>
                            <div class="btn-container">
                                <a href="<%=request.getContextPath()%>/productController/initUpdate/${product.id}"
                                   class="btn btn-update">Update</a>
                                <a href="<%=request.getContextPath()%>/productController/delete/${product.id}"
                                   class="btn btn-delete">Delete</a>
                            </div>

                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="button-container">
                <a href="<%=request.getContextPath()%>/productController/newProduct">
                    <button class="btn btn-create">Create New Product</button>
                </a>
            </div>
            <%--            <a href="<%=request.getContextPath()%>/productController/newProduct">Create New Product</a>--%>
        </div>
    </div>

</div>
</body>
</html>