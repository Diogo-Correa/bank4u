<%-- 
    Document   : dashboard
    Created on : 16/11/2021, 23:27:43
    Author     : Diogo
--%>

<% 
    if((boolean) request.getSession().getAttribute("isAdmin") || !(boolean) request.getSession().getAttribute("isLoggedIn")) { 
            response.sendRedirect("/banco");
    } else {
%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="app.Usuario"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="./assets/includes/head.html" />
        <title>4U - Dashboard</title>
    </head>
    <body style="background-color: #efefef !important;" class="text-dark">
        
        
        <%
            try {
                if(request.getSession().getAttribute("error") != null) {
        %>
        <script>
            sweetAlert("Oops! :(", request.getSession().getAttribute("error"), "error");
        </script>
        <%
                request.getSession().removeAttribute("error");
                }

                if(request.getSession().getAttribute("success") != null) {
        %>
        <script>
            sweetAlert("Yeep! :D", request.getSession().getAttribute("success"), "success");
        </script>
        <%
                }
            } catch(Exception e) {
                System.out.println("Error attribute not found.");
            }

            Usuario user = (Usuario) request.getSession().getAttribute("authUser");  
        %>
        <jsp:include page="./assets/components/header/header.html" />
        
        <div class="container">
            <button type="button" class="float" title="Novo lancamento" data-bs-toggle="modal" data-bs-target="#novoLancamento">
                <i class="fa fa-plus my-float"></i>
            </button>
            
            <div class="alert alert-info">
                <i class="fas fa-wallet me-2"></i>
                Ola <%= user.getNome()  %>, parece que voce ainda nao tem uma conta cadastrada, clique <a class="alert-link" href=""  data-bs-toggle="modal" data-bs-target="#novaConta">aqui</a> para cadastrar uma.
            </div>
            
            <div class="row">
                <div class="col-lg-9">
                    <div class="card text-dark border-0 mb-3">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-money-check-alt"></i>
                                Extrato
                            </h5>
                        </div>
                        <div class="card-body">
                            asd
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="card text-dark border-0 mb-3">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-money-bill-alt"></i>
                                Saldo
                            </h5>
                        </div>
                        <div class="card-body">
                            asd
                        </div>
                    </div>
                </div>
            </div> 
        </div>
        
        <jsp:include page="./assets/components/modal/novoLancamento.html" />
        <jsp:include page="./assets/components/modal/novaConta.html" />
        
        
        <jsp:include page="./assets/includes/scripts.html" />
    </body>
</html>

<% } %>
