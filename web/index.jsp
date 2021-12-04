<%-- 
    Document   : index
    Created on : 15/11/2021, 20:54:17
    Author     : Diogo
--%>

<% 
    if((boolean) request.getSession().getAttribute("isLoggedIn")) { 
        if((boolean) request.getSession().getAttribute("isAdmin")) {
            response.sendRedirect("settings.jsp");
        } else {
            response.sendRedirect("dashboard.jsp");
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <jsp:include page="./assets/includes/head.html" />
    <title>4U - O banco para voce!</title>
</head>
<body>

    <jsp:include page="./assets/includes/content.html" />

    <jsp:include page="./assets/includes/scripts.html" />
</body>
</html>
