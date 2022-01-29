<%-- 
    Document   : showUser
    Created on : 09/12/2021, 18:50:05
    Author     : Diogo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8" import="app.Administrador"%>
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
                    <li class="breadcrumb-item"><a href="user"><i class="fas fa-user"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Visualizar</li>
                    <li class="breadcrumb-item active" aria-current="page">${nome}</li>
                </ol>
            </nav>
                
            <div class="card border-0 mb-3 ${applicationDarkTheme ? 'bg-dark' : 'bg-body text-dark'} rounded shadow-sm">
                <div class="card-header bg-primary">
                    <h5 class="card-title text-light py-2">
                        <i class="fas fa-user"></i>
                        ${nome}
                    </h5>
                </div>
                <div class="card-body">
                    <div class="d-flex text-muted pt-3">
                      <i class="fas fa-user-shield me-2"></i> 
                      <div class="pb-3 mb-0 small lh-sm border-bottom w-100" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
                        <div class="d-flex justify-content-between">
                          <strong class="text-gray-dark"> CPF</strong>
                        </div>
                        <span class="d-block">${cpf}</span>
                      </div>
                        <c:if test="${suspenso != null}">
                            <i class="fas fa-user-slash me-2"></i> 
                            <div class="pb-3 mb-0 small lh-sm border-bottom w-100" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
                              <div class="d-flex justify-content-between">
                                <strong class="text-gray-dark"> Suspenso?</strong>
                              </div>
                              <span class="d-block">${suspenso}</span>
                            </div>
                        </c:if>
                    </div>
                         <c:if test="${contas != null}">
                            <div class="bg-black text-light p-2 rounded my-4">
                                <strong>
                                    <i class="fas fa-piggy-bank me-2"></i> Contas
                                </strong>
                            </div>
                            <c:choose>
                                <c:when test="${contas.size() > 0}">
                                    <c:forEach var="c" items="${contas}">
                                        <div class="d-flex pt-3">
                                            <div class="pb-3 mb-0 small lh-sm border-bottom w-100" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
                                                <div class="d-flex justify-content-between">
                                                    <span class="d-block pt-3 text-uppercase">
                                                        <i class="fas fa-money-check-alt me-2"></i>
                                                        (${c.getBanco()} - ${c.getBancoNome()}) 
                                                    </span>
                                                    <div class="dropdown">
                                                      <a href="" class="link-secondary" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>

                                                      <ul class="dropdown-menu dropdown-menu-dark mx-0 shadow" style="width: 220px;">
                                                        <li>
                                                          <a class="dropdown-item dropdown-item-danger d-flex gap-2 align-items-center" data-bs-toggle="modal" data-bs-target="#confirmaAction" data-href="entries?action=deleteAll&id=${c.id}" href="#">
                                                            <i class="fas fa-times"></i>
                                                            Apagar lancamentos
                                                          </a>
                                                        </li>
                                                        <li>
                                                          <a class="dropdown-item dropdown-item-danger d-flex gap-2 align-items-center" data-bs-toggle="modal" data-bs-target="#confirmaAction" data-href="wallet?action=delete&id=${c.id}" href="#">
                                                            <i class="fas fa-trash"></i>
                                                            Deletar
                                                          </a>
                                                        </li>
                                                      </ul>
                                                    </div>
                                                </div>
                                                <span class="d-block text-muted p-3">
                                                    <i class="fas fa-signature"></i> ${c.nome}
                                                </span>
                                                <span class="d-block text-muted ps-3">
                                                    <i class="fas fa-university"></i> ${c.agencia}
                                                </span>
                                                <span class="d-block text-muted ps-3">
                                                    <i class="fas fa-wallet"></i> ${c.getConta()}
                                                </span>
                                            </div>
                                        </div>
                                    </c:forEach> 
                                </c:when>    
                                <c:otherwise>
                                    <span class="text-muted">Nenhuma conta encontrada.</span>
                                </c:otherwise>
                            </c:choose>    
                    </c:if>
            </div>
        </div>
        
        <jsp:include page="../../assets/components/modal/confirmaAction.html" />
        
        <jsp:include page="../../assets/includes/scripts.html" />
    </body>
</html>
