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
        <jsp:include page="./assets/includes/head.html" />
        <title>4U - Settings</title>
    </head>
    <body style="background-color: #efefef !important;" class="text-dark">
        
        <jsp:include page="./assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="./assets/components/header/header.jsp" />
        
        <div class="container">
            <div class="card text-dark border-0 mb-3 bg-body rounded shadow-sm">
                <div class="card-header bg-dark">
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
                            
        <jsp:include page="./assets/components/modal/novoUser.html" />
        <jsp:include page="./assets/components/modal/novaCategoria.html" />
        
        <jsp:include page="./assets/components/modal/confirmaAction.html" />
        
        <jsp:include page="./assets/includes/scripts.html" />
    </body>
</html>
