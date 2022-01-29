<%-- 
    Document   : showCategoria
    Created on : 27/12/2021, 19:21:05
    Author     : Diogo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ${applicationDarkTheme ? '' : 'style="background-color: #efefef !important;"'}>
    <head>
        <jsp:include page="../../assets/includes/head.html" />
        <title>4U - Show ${nome}</title>
    </head>
    <body ${applicationDarkTheme ? '' : 'style="background-color: #efefef !important;" class="text-dark"'}>
        
        <jsp:include page="../../assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="../../assets/components/header/header.jsp" />
        
        <div class="container">
            
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb ${applicationDarkTheme ? 'bg-dark' : 'bg-white'} p-3 rounded shadow-sm">
                    <li class="breadcrumb-item"><a href="home"><i class="fas fa-th-large"></i></a></li>
                    <li class="breadcrumb-item"><a href="category"><i class="fas fa-tags"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Visualizar</li>
                    <li class="breadcrumb-item active" aria-current="page">${nome}</li>
                </ol>
            </nav>
                
            <div class="card text-dark border-0 mb-3 ${applicationDarkTheme ? 'bg-dark' : 'bg-body text-dark'} rounded shadow-sm">
                <div class="card-header bg-primary">
                    <h5 class="card-title text-light py-2">
                        <i class="fas fa-tag"></i>
                        ${nome}
                    </h5>
                </div>
            </div>
        </div>
        
        <jsp:include page="../../assets/components/modal/confirmaAction.html" />
        
        <jsp:include page="../../assets/includes/scripts.html" />
    </body>
</html>
