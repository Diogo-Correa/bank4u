<%-- 
    Document   : showCategoria
    Created on : 27/12/2021, 19:21:05
    Author     : Diogo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color: #efefef !important;">
    <head>
        <jsp:include page="../../assets/includes/head.html" />
        <title>4U - Show ${nome}</title>
    </head>
    <body style="background-color: #efefef !important;" class="text-dark">
        
        <jsp:include page="../../assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="../../assets/components/header/header.jsp" />
        
        <div class="container">
            <div class="card text-dark border-0 mb-3 bg-body rounded shadow-sm">
                <div class="card-header bg-primary">
                    <h5 class="card-title text-light py-2">
                        <i class="fas fa-tag"></i>
                        ${nome}
                    </h5>
                </div>
            </div>
        </div>
                            
        <jsp:include page="../../assets/components/modal/novoUser.html" />
        <jsp:include page="../../assets/components/modal/novaCategoria.html" />
        
        <jsp:include page="../../assets/components/modal/confirmaAction.html" />
        
        <jsp:include page="../../assets/includes/scripts.html" />
    </body>
</html>
