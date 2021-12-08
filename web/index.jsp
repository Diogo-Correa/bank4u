<%-- 
    Document   : index
    Created on : 15/11/2021, 20:54:17
    Author     : Diogo

    ----- Casos de Usos - Admin -----
    RF1: OK
    RF2: OK
    RF3: OK
    RF4:
    RF5: OK

    ----- Casos de Usos - Usuario -----
    RF6:
    RF7:
    RF8:
    RF9:

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
    
    <%
        try {
            if(request.getSession().getAttribute("error") != null) {
    %>
    <script>
        sweetAlert("Oops! :(", "Credenciais invalidas!", "error");
    </script>
    <%
            request.getSession().removeAttribute("error");
            }
        } catch(Exception e) {
            System.out.println("Error attribute not found.");
        }
    %>
    
    <jsp:include page="./assets/includes/content.html" />

    <jsp:include page="./assets/includes/scripts.html" />
</body>
</html>
