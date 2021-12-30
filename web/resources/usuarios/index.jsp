<%-- 
    Document   : index
    Created on : 30/12/2021, 12:43:40
    Author     : Diogo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color: #efefef !important;">
    <head>
        <jsp:include page="../../assets/includes/head.html" />
        <title>4U - Users</title>
    </head>
    <body style="background-color: #efefef !important;" class="text-dark">
        
        <jsp:include page="../../assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="../../assets/components/header/header.jsp" />
        
        <div class="container bg-white p-5 rounded">
            
            <button type="button" class="float" title="Novo lancamento" data-bs-toggle="modal" data-bs-target="#novoUser">
                <i class="fa fa-plus my-float"></i>
            </button>
            
            <table id="data" class="table table-striped table-hover" style="width:100%">
                <thead class="table-dark">
                    <tr>
                        <th>Nome</th>
                        <th>CPF</th>
                        <th>Nivel</th>
                        <th colspan="2"></th>
                    </tr>
                </thead>
                <tbody>
                    
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td>${u.getNome()}</td>
                            <td>${u.getCpf()}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.isAdmin()}">
                                        <span class="badge bg-danger">Admin</span>
                                    </c:when>    
                                    <c:otherwise>
                                        <span class="badge ${u.isSuspenso() ?  'bg-secondary' : 'bg-primary'}">Usuario</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <c:choose>
                                <c:when test="${u.isAdmin()}">
                                    <td colspan="2" class="text-end">
                                        <div class="dropdown">
                                        <a href="" class="link-secondary" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>

                                        <ul class="dropdown-menu dropdown-menu-dark mx-0 shadow" style="width: 220px;">
                                          <li>
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="user?action=show&admin=true&id=${u.id}">
                                              <i class="fas fa-eye"></i>
                                              Ver
                                            </a>
                                          </li>
                                          <li>
                                            <a class="dropdown-item d-flex gap-2 align-items-center" href="user?action=edit&admin=true&id=${u.id}">
                                              <i class="fas fa-pen"></i>
                                              Editar
                                            </a>
                                          </li>
                                          <c:if test="${u.id != authUser.getId()}">
                                            <li><hr class="dropdown-divider"></li>
                                            <li>
                                              <a class="dropdown-item dropdown-item-danger d-flex gap-2 align-items-center" data-bs-toggle="modal" data-bs-target="#confirmaAction" data-href="user?action=delete&admin=true&id=${u.id}" href="#">
                                                <i class="fas fa-trash"></i>
                                                Deletar
                                              </a>
                                            </li>
                                          </c:if>
                                        </ul>
                                      </div>
                                    </td>
                                </c:when>    
                                <c:otherwise>
                                    <td colspan="2" class="text-end">
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
                                    </td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot class="table-dark">
                    <tr>
                        <th>Nome</th>
                        <th>CPF</th>
                        <th>Nivel</th>
                        <th colspan="2"></th>
                    </tr>
                </tfoot>
            </table>
        </div>
        
        <jsp:include page="../../assets/components/modal/novoUser.html" />
        
        <jsp:include page="../../assets/components/modal/confirmaAction.html" />
        
        <jsp:include page="../../assets/includes/scripts.html" />
        <script>
            $(document).ready(function() {
                $('#data').DataTable({
                    "language": {
                        "lengthMenu": "Mostrar _MENU_ resultados por pagina.",
                        "zeroRecords": "Nada encontrado - desculpe.",
                        "info": "Mostrando pagina _PAGE_ de _PAGES_",
                        "infoEmpty": "Nenhum registro encontrado.",
                        "infoFiltered": "(filtrado de _MAX_ resultados totais)",
                        "search": "Buscar:"
                    },
                    "columnDefs": [{
                        "targets": 3,
                        "searchable": false,
                        "orderable": false
                    }]
                });
            } );
        </script>
    </body>
</html>
