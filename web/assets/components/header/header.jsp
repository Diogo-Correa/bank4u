<%-- 
    Document   : header
    Created on : 08/12/2021, 22:43:56
    Author     : Diogo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="py-2 bg-light border-bottom">
  <div class="container d-flex flex-wrap">
    <ul class="nav me-auto">
      <li class="nav-item"><a href="home" class="nav-link link-dark px-2 active" aria-current="page"><i class="fas ${isAdmin ? 'fa-th-large' : 'fa-home'}"></i></a></li>
      <c:if test="${isAdmin}">
        <li class="nav-item"><a href="user" class="nav-link link-dark px-2 active" aria-current="page"><i class="fas fa-user"></i></a></li>
        <li class="nav-item"><a href="category" class="nav-link link-dark px-2 active" aria-current="page"><i class="fas fa-tags"></i></a></li>
        <li class="nav-item"><a href="charts" class="nav-link link-dark px-2 active" aria-current="page"><i class="fas fa-chart-bar"></i></a></li>
      </c:if>
    </ul>
    <ul class="nav">
      <li class="nav-item"><a href="profile" class="nav-link link-dark px-2 active" aria-current="page"><i class="fas fa-user-circle"></i></a></li>
      <li class="nav-item"><a href="logout" class="nav-link link-dark px-2"><i class="fas fa-sign-out-alt"></i></a></li>
    </ul>
  </div>
</nav>

<header class="py-3 mb-4 border-bottom" style="background-color: white;">
  <div class="container d-flex flex-wrap justify-content-center">
    <a href="/" class="d-flex align-items-center mb-lg-0 me-lg-auto text-dark text-decoration-none">
      <i class="fab fa-btc text-success" style="font-size: 2rem; margin-right: 10px;"></i>
      <span class="fs-4 d-none d-lg-block">4U</span>
    </a>
  </div>
</header>
