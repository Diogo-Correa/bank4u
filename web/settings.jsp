<%-- 
    Document   : settings
    Created on : 18/11/2021, 21:14:43
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
        <%
            try {
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
            } catch(Exception e) {
                System.out.println("Error attribute not found.");
            }
        %>
        
        <jsp:include page="./assets/components/header/header.html" />
        
        <div class="container">
            <button type="button" class="float" title="Novo lancamento" data-bs-toggle="modal" data-bs-target="#novoUser">
                <i class="fa fa-plus my-float"></i>
            </button>
            
            <div class="alert alert-danger">
                <i class="fas fa-cog me-2"></i>
                Ola ${authName}, essa eh sua area de configuracoes.
            </div>
            
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
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="#">
                                              <i class="fas fa-eye"></i>
                                              Ver
                                            </a>
                                          </li>
                                          <li>
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="#">
                                              <i class="fas fa-pen"></i>
                                              Editar
                                            </a>
                                          </li>
                                          <li><hr class="dropdown-divider"></li>
                                          <li>
                                            <a class="dropdown-item dropdown-item-danger d-flex gap-2 align-items-center" href="#">
                                              <i class="fas fa-trash"></i>
                                              Deletar
                                            </a>
                                          </li>
                                        </ul>
                                      </div>
                                    </div>
                                    <span class="d-block"><c:out value="${a.cpf}" /></span>
                                  </div>
                                </div>
                            </c:forEach>
                            <small class="d-block text-end mt-3">
                              <a href="#">Todos os admins</a>
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
                                  <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#007bff"></rect><text x="50%" y="50%" fill="#007bff" dy=".3em">32x32</text></svg>

                                  <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                                    <div class="d-flex justify-content-between">
                                      <strong class="text-gray-dark"><c:out value="${u.nome}" /></strong>
                                      <div class="dropdown">
                                        <a href="" class="link-secondary" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>

                                        <ul class="dropdown-menu dropdown-menu-dark mx-0 shadow" style="width: 220px;">
                                          <li>
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="#">
                                              <i class="fas fa-eye"></i>
                                              Ver
                                            </a>
                                          </li>
                                          <li>
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="#">
                                              <i class="fas fa-pen"></i>
                                              Editar
                                            </a>
                                          </li>
                                          <li><hr class="dropdown-divider"></li>
                                          <li>
                                            <a class="dropdown-item dropdown-item-danger d-flex gap-2 align-items-center" href="#">
                                              <i class="fas fa-user-slash"></i>
                                              Suspender
                                            </a>
                                          </li>
                                          <li>
                                            <a class="dropdown-item dropdown-item-danger d-flex gap-2 align-items-center" href="#">
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
                              <a href="#">Todos os usuarios</a>
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
                                <span class="badge bg-danger">${tagsCount}</span>
                            </h5>
                        </div>
                        <div class="card-body">
                            <h5 class="text-end">
                                <span class="badge bg-success">
                                    <a href="" class="link-light" data-bs-toggle="modal" data-bs-target="#novaCategoria">Nova categoria</a>
                                </span>
                            </h5>
                            <c:forEach var="t" items="${tags}">
                                <div class="d-flex text-muted pt-3">
                                  <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#00ffa6"></rect><text x="50%" y="50%" fill="#00ffa6" dy=".3em">32x32</text></svg>

                                  <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                                    <div class="d-flex justify-content-between">
                                      <strong class="text-gray-dark"><c:out value="${t.descricao}" /></strong>
                                      <div class="dropdown">
                                        <a href="" class="link-secondary" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>

                                        <ul class="dropdown-menu dropdown-menu-dark mx-0 shadow" style="width: 220px;">
                                          <li>
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="#">
                                              <i class="fas fa-eye"></i>
                                              Ver
                                            </a>
                                          </li>
                                          <li>
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="#">
                                              <i class="fas fa-pen"></i>
                                              Editar
                                            </a>
                                          </li>
                                          <li><hr class="dropdown-divider"></li>
                                          <li>
                                            <a class="dropdown-item dropdown-item-danger d-flex gap-2 align-items-center" href="#">
                                              <i class="fas fa-trash"></i>
                                              Deletar
                                            </a>
                                          </li>
                                        </ul>
                                      </div>
                                    </div>
                                    <span class="d-block"><c:out value="${t.id}" /></span>
                                  </div>
                                </div>
                            </c:forEach>
                            <small class="d-block text-end mt-3">
                              <a href="#">Todos os usuarios</a>
                            </small>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
        
        <jsp:include page="./assets/components/modal/novoUser.html" />
        <jsp:include page="./assets/components/modal/novaCategoria.html" />
        
        <jsp:include page="./assets/includes/scripts.html" />
    </body>
</html>