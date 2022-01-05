<%-- 
    Document   : index
    Created on : 15/11/2021, 20:54:17
    Author     : Diogo

    ----- Casos de Usos - Admin -----
    Entrega: 09.01.2022
    RF1: OK
    RF2: OK
    RF3: OK
    RF4: OK
    RF5: OK

    ----- Casos de Usos - Usuario -----
    Entrega: 30.01.2022
    RF6: OK
    RF7:
    RF8:
    RF9: OK

--%>
<%
    try {
        if((boolean) request.getSession().getAttribute("isLoggedIn")) {
            response.sendRedirect("home");
        }
    } catch(Exception e) {
            System.out.println("isLoggedIn attribute not found.");
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
    
    <jsp:include page="./assets/components/modal/alertMsgs.jsp" />
    
    <jsp:include page="./assets/includes/content.html" />

    <jsp:include page="./assets/includes/scripts.html" />
</body>
</html>
