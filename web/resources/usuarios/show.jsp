<%-- 
    Document   : showUser
    Created on : 09/12/2021, 18:50:05
    Author     : Diogo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8" import="app.Administrador"%>
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
            
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb bg-white p-3 rounded shadow-sm">
                    <li class="breadcrumb-item"><a href="home"><i class="fas fa-th-large"></i></a></li>
                    <li class="breadcrumb-item"><a href="user"><i class="fas fa-user"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Visualizar</li>
                    <li class="breadcrumb-item active" aria-current="page">${nome}</li>
                </ol>
            </nav>
                
            <div class="card text-dark border-0 mb-3 bg-body rounded shadow-sm">
                <div class="card-header bg-primary">
                    <h5 class="card-title text-light py-2">
                        <i class="fas fa-user"></i>
                        ${nome}
                    </h5>
                </div>
                <div class="card-body">
                    <div class="d-flex text-muted pt-3">
                      <i class="fas fa-user-shield me-2"></i> 
                      <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                        <div class="d-flex justify-content-between">
                          <strong class="text-gray-dark"> CPF</strong>
                        </div>
                        <span class="d-block">${cpf}</span>
                      </div>
                        <c:if test="${suspenso != null}">
                            <i class="fas fa-user-slash me-2"></i> 
                            <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                              <div class="d-flex justify-content-between">
                                <strong class="text-gray-dark"> Suspenso?</strong>
                              </div>
                              <span class="d-block">${suspenso}</span>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
                            
        <jsp:include page="../../assets/components/modal/novoUser.html" />
        <jsp:include page="../../assets/components/modal/novaCategoria.html" />
        
        <jsp:include page="../../assets/components/modal/confirmaAction.html" />
        
        <jsp:include page="../../assets/includes/scripts.html" />
    </body>
</html>
