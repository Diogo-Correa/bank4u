<%-- 
    Document   : index
    Created on : 30/12/2021, 12:43:40
    Author     : Diogo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ${applicationDarkTheme ? '' : 'style="background-color: #efefef !important;"'}>
    <head>
        <jsp:include page="../../assets/includes/head.html" />
        <title>4U - Category</title>
    </head>
    <body ${applicationDarkTheme ? '' : 'style="background-color: #efefef !important;" class="text-dark"'}>
        
        <jsp:include page="../../assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="../../assets/components/header/header.jsp" />
        
        <div class="container">
            
            <button type="button" class="float" title="Novo lancamento" data-bs-toggle="modal" data-bs-target="#novaCategoria">
                <i class="fa fa-plus my-float"></i>
            </button>
            
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb ${applicationDarkTheme ? 'bg-dark' : 'bg-white'} p-3 rounded shadow-sm">
                    <li class="breadcrumb-item"><a href="home"><i class="fas fa-th-large"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Categorias</li>
                </ol>
            </nav>
                
            <div class="card ${applicationDarkTheme ? 'bg-dark' : 'bg-white text-dark'} rounded shadow-sm">
                <div class="card-body">
                    <table id="data" class="table table-hover ${applicationDarkTheme ? 'table-dark' : 'table-light'} table-striped" style="width:100%">
                        <thead class="${applicationDarkTheme ? 'table-active' : 'table-dark'}">
                            <tr>
                                <th>#</th>
                                <th>Descricao</th>
                                <th colspan="2"></th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach var="c" items="${categories}">
                                <tr>
                                    <td>${c.id}</td>
                                    <td>${c.descricao}</td>
                                    <td colspan="2" class="text-end">
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
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <jsp:include page="../../assets/components/modal/novaCategoria.jsp" />
        
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
                        "targets": 2,
                        "searchable": false,
                        "orderable": false
                    }],
                order: [[0, "asc"]]
                });
            } );
        </script>
        
        <c:if test="${applicationDarkTheme}">
            <script>
                $( document ).ready(function() {
                    $('.form-control-sm').addClass('bg-black border-dark text-white');
                    $('.form-select-sm').addClass('bg-black border-dark text-white');
                });
            </script>
        </c:if>
    </body>
</html>
