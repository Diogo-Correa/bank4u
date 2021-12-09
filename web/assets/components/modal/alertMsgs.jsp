<%-- 
    Document   : alertMsgs
    Created on : 08/12/2021, 22:33:52
    Author     : Diogo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(request.getSession().getAttribute("error") != null) {
%>
        <script>
            sweetAlert("Oops! :(", `${error}`, "error");
        </script>
<%
        request.getSession().removeAttribute("error");
    }

    if(request.getSession().getAttribute("success") != null) {
%>
        <script>
            sweetAlert("Yeep! :D", `${success}`, "success");
        </script>
<%
        request.getSession().removeAttribute("success");
    }
%>
