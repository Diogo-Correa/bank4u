<%-- 
    Document   : profile
    Created on : 18/01/2022, 13:17:53
    Author     : Diogo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color: #efefef !important;">
    <head>
        <jsp:include page="./assets/includes/head.html" />
        <title>4U - Settings</title>
    </head>
    <body style="background-color: #efefef !important;" class="text-dark">
        
        <jsp:include page="./assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="./assets/components/header/header.jsp" />
        
        <div class="container">
            
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb bg-white p-3 rounded shadow-sm">
                    <li class="breadcrumb-item active" aria-current="page"><i class="fas fa-th-large"></i></li>
                </ol>
            </nav>
            
        <h1>Hello World!</h1>
        
        <jsp:include page="./assets/includes/scripts.html" />
    </body>
</html>
