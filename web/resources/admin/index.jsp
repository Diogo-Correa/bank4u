<%-- 
    Document   : settings
    Created on : 18/11/2021, 21:14:43
    Author     : Diogo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color: #efefef !important;">
    <head>
        <jsp:include page="../../assets/includes/head.html" />
        <title>4U - Settings</title>
    </head>
    <body style="background-color: #efefef !important;" class="text-dark">
        
        <jsp:include page="../../assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="../../assets/components/header/header.jsp" />
        
        <div class="container">
            
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb bg-white p-3 rounded shadow-sm">
                    <li class="breadcrumb-item active" aria-current="page"><i class="fas fa-th-large"></i></li>
                </ol>
            </nav>
            
            <div class="row">
                <div class="col-lg-6">
                    <div class="card text-dark border-0 mb-3 bg-body rounded shadow-sm">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-crown"></i>
                                Administradores
                                <span class="badge bg-danger">${adminsCount}</span>
                            </h5>
                        </div>
                        <div class="card-body">
                            
                            <c:forEach var="a" items="${admins}">
                                <div class="d-flex text-muted pt-3">
                                  <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#a83242"></rect><text x="50%" y="50%" fill="#007bff" dy=".3em"></text></svg>

                                  <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                                    <div class="d-flex justify-content-between">
                                      <strong class="text-gray-dark"><c:out value="${a.nome}" /></strong>
                                      <div class="dropdown">
                                        <a href="" class="link-secondary" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>

                                        <ul class="dropdown-menu dropdown-menu-dark mx-0 shadow" style="width: 220px;">
                                          <li>
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="user?action=show&admin=true&id=${a.id}">
                                              <i class="fas fa-eye"></i>
                                              Ver
                                            </a>
                                          </li>
                                          <li>
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="user?action=edit&admin=true&id=${a.id}">
                                              <i class="fas fa-pen"></i>
                                              Editar
                                            </a>
                                          </li>
                                          <c:if test="${a.getId() != authUser.getId()}">
                                            <li><hr class="dropdown-divider"></li>
                                            <li>
                                              <a class="dropdown-item dropdown-item-danger d-flex gap-2 align-items-center" data-bs-toggle="modal" data-bs-target="#confirmaAction" data-href="user?action=delete&admin=true&id=${a.id}" href="#">
                                                <i class="fas fa-trash"></i>
                                                Deletar
                                              </a>
                                            </li>
                                          </c:if>
                                        </ul>
                                      </div>
                                    </div>
                                    <span class="d-block"><c:out value="${a.cpf}" /></span>
                                  </div>
                                </div>
                            </c:forEach>
                            <small class="d-block text-end mt-3">
                              <a href="user">Todos os usuarios</a>
                            </small>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card text-dark border-0 mb-3 bg-body rounded shadow-sm">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-user"></i>
                                Usuarios
                                <span class="badge bg-danger">${usersCount}</span>
                            </h5>
                        </div>
                        <div class="card-body">
                            <c:forEach var="u" items="${users}">
                                <div class="d-flex text-muted pt-3">
                                  <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#007bff"></rect><text x="50%" y="50%" fill="#007bff" dy=".3em"></text></svg>

                                  <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                                    <div class="d-flex justify-content-between">
                                      <strong class="text-gray-dark"><c:out value="${u.nome}" /></strong>
                                      <div class="dropdown">
                                        <a href="" class="link-secondary" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>

                                        <ul class="dropdown-menu dropdown-menu-dark mx-0 shadow" style="width: 220px;">
                                          <li>
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="user?action=show&id=${u.id}">
                                              <i class="fas fa-eye"></i>
                                              Ver
                                            </a>
                                          </li>
                                          <li>
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="user?action=edit&id=${u.id}">
                                              <i class="fas fa-pen"></i>
                                              Editar
                                            </a>
                                          </li>
                                          <li><hr class="dropdown-divider"></li>
                                          <li>
                                            <a class="dropdown-item dropdown-item-danger d-flex gap-2 align-items-center" data-bs-toggle="modal" data-bs-target="#confirmaAction" data-href="user?action=suspend&id=${u.id}" href="#">
                                              
                                                <c:choose>
                                                    <c:when test="${u.isSuspenso()}">
                                                        <i class="fas fa-user-check"></i>
                                                        Ativar 
                                                    </c:when>    
                                                    <c:otherwise>
                                                        <i class="fas fa-user-slash"></i>
                                                        Suspender
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                          </li>
                                          <li>
                                            <a class="dropdown-item dropdown-item-danger d-flex gap-2 align-items-center" data-bs-toggle="modal" data-bs-target="#confirmaAction" data-href="user?action=delete&id=${u.id}" href="#">
                                              <i class="fas fa-trash"></i>
                                              Deletar
                                            </a>
                                          </li>
                                        </ul>
                                      </div>
                                    </div>
                                    <span class="d-block"><c:out value="${u.cpf}" /></span>
                                  </div>
                                </div>
                            </c:forEach>
                            <small class="d-block text-end mt-3">
                              <a href="user">Todos os usuarios</a>
                            </small>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card text-dark border-0 mb-3 bg-body rounded shadow-sm">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-tags"></i>
                                Categorias
                                <span class="badge bg-danger">${categoriesCount}</span>
                            </h5>
                        </div>
                        <div class="card-body">
                            <c:forEach var="c" items="${categories}">
                                <div class="d-flex text-muted pt-3">
                                  <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#00ffa6"></rect><text x="50%" y="50%" fill="#00ffa6" dy=".3em"></text></svg>

                                  <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                                    <div class="d-flex justify-content-between">
                                      <strong class="text-gray-dark"><c:out value="${c.descricao}" /></strong>
                                      <div class="dropdown">
                                        <a href="" class="link-secondary" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>

                                        <ul class="dropdown-menu dropdown-menu-dark mx-0 shadow" style="width: 220px;">
                                          <li>
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="category?action=show&id=${c.id}">
                                              <i class="fas fa-eye"></i>
                                              Ver
                                            </a>
                                          </li>
                                          <li>
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="category?action=edit&id=${c.id}">
                                              <i class="fas fa-pen"></i>
                                              Editar
                                            </a>
                                          </li>
                                          <li><hr class="dropdown-divider"></li>
                                          <li>
                                            <a class="dropdown-item dropdown-item-danger d-flex gap-2 align-items-center" data-bs-toggle="modal" data-bs-target="#confirmaAction" data-href="category?action=delete&id=${c.id}" href="#">
                                              <i class="fas fa-trash"></i>
                                              Deletar
                                            </a>
                                          </li>
                                        </ul>
                                      </div>
                                    </div>
                                    <span class="d-block"><c:out value="${c.id}" /></span>
                                  </div>
                                </div>
                            </c:forEach>
                            <small class="d-block text-end mt-3">
                              <a href="category">Todos as categorias</a>
                            </small>
                        </div>
                    </div>
                </div>
            </div> 
        </div>                  
                            
        <jsp:include page="../../assets/components/modal/novaCategoria.html" />
        
        <jsp:include page="../../assets/components/modal/confirmaAction.html" />
        
        <jsp:include page="../../assets/includes/scripts.html" />
        
        <c:if test="${allowModalInfoOnLogin}">
            <c:if test="${show}">
                <jsp:include page="../../assets/components/modal/adminInfo.html" />
                <script>
                    $("#infosModal").show();
                </script>
            </c:if>
        </c:if>
        <%
            request.getSession().setAttribute("show", false);
        %>
    </body>
</html>