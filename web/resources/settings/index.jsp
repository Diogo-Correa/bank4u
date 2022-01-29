<%-- 
    Document   : profile
    Created on : 28/01/2022, 13:17:53
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
                    <li class="breadcrumb-item" aria-current="page"><a href="home"><i class="fas fa-th-large"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Configuracoes</li>
                </ol>
            </nav>
            
            <div class="card mb-3 shadow-sm">
                <div class="card-body p-5">
                    <h3>App configs</h3>
                    
                    <div class="d-flex text-muted pt-3">
                      <i class="fas fa-sign-in-alt me-2"></i> 
                      <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                          <div class="form-check form-switch">
                            <label class="form-check-label" for="allowModalInfoOnLogin">Mostrar o modal de informacoes apos efetuar o login?</label>
                            <input class="form-check-input" type="checkbox" role="switch" id="allowModalInfoOnLogin" ${allowModalInfoOnLogin ? 'checked' : ''}>
                          </div>
                      </div>
                    </div>
                          
                    <div class="d-flex text-muted pt-3">
                      <i class="fas fa-exclamation-triangle me-2"></i>
                      <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                          <div class="form-check form-switch">
                            <label class="form-check-label" for="showAlertNegativeAccounts">Mostrar alerta para contas negativas?</label>
                            <input class="form-check-input" type="checkbox" role="switch" id="showAlertNegativeAccounts" ${showAlertNegativeAccounts ? 'checked' : ''}>
                          </div>
                      </div>
                    </div>
                </div>
            </div>
            
            <div class="card mb-3 shadow-sm">
                <div class="card-body p-5">
                    <h3>Admin configs</h3>
                    
                    <div class="d-flex text-muted pt-3">
                      <i class="fas fa-wallet me-2"></i> 
                      <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                          <div class="form-check form-switch">
                            <label class="form-check-label" for="allowAdminDeleteBankAcc">Permitir que administradores deletem contas bancarias dos usuarios?</label>
                            <input class="form-check-input" type="checkbox" role="switch" name="AllowAdminDeleteBankAcc" id="allowAdminDeleteBankAcc" ${allowAdminDeleteBankAcc ? 'checked' : ''}>
                          </div>
                      </div>
                    </div>
                    
                    <div class="d-flex text-muted pt-3">
                      <i class="fas fa-piggy-bank me-2"></i> 
                      <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                          <div class="form-check form-switch">
                            <label class="form-check-label" for="allowAdminDeleteEntries">Permitir que administradores deletem lancamentos bancarios dos usuarios?</label>
                            <input class="form-check-input" type="checkbox" role="switch" name="AllowAdminDeleteEntries" id="allowAdminDeleteEntries" ${allowAdminDeleteEntries ? 'checked' : ''}>
                          </div>
                      </div>
                    </div>
                </div>
            </div>
        
        <jsp:include page="../../assets/includes/scripts.html" />
        <script>
            $(document).on("change", "#allowModalInfoOnLogin", function() {
                var value;
                
                if($("#allowModalInfoOnLogin").is(':checked')) value = true;
                else value = false;
                
                var urlTotal = 'settings?action=update&AllowModalInfoOnLogin='+value;
                $.ajax({
                    type:'POST',
                    url: urlTotal,
                    success: function() {
                        sweetAlert("Yeep! :D", "Configuracao atualizada!", "success");
                    },
                    error: function() {
                        sweetAlert("Oops! :(", "Ocorreu um erro no servidor", "error");
                    }   
                });
            });
            
            $(document).on("change", "#showAlertNegativeAccounts", function() {
                var value;
                
                if($("#showAlertNegativeAccounts").is(':checked')) value = true;
                else value = false;
                
                var urlTotal = 'settings?action=update&ShowAlertNegativeAccounts='+value;
                $.ajax({
                    type:'POST',
                    url: urlTotal,
                    success: function() {
                        sweetAlert("Yeep! :D", "Configuracao atualizada!", "success");
                    },
                    error: function() {
                        sweetAlert("Oops! :(", "Ocorreu um erro no servidor", "error");
                    }   
                });
            });
            
            $(document).on("change", "#allowAdminDeleteBankAcc", function() {
                var value;
                
                if($("#allowAdminDeleteBankAcc").is(':checked')) value = true;
                else value = false;
                
                var urlTotal = 'settings?action=update&AllowAdminDeleteBankAcc='+value;
                $.ajax({
                    type:'POST',
                    url: urlTotal,
                    success: function() {
                        sweetAlert("Yeep! :D", "Configuracao atualizada!", "success");
                    },
                    error: function() {
                        sweetAlert("Oops! :(", "Ocorreu um erro no servidor", "error");
                    }   
                });
            });
            
            $(document).on("change", "#allowAdminDeleteEntries", function() {
                var value;
                
                if($("#allowAdminDeleteEntries").is(':checked')) value = true;
                else value = false;
                
                var urlTotal = 'settings?action=update&AllowAdminDeleteEntries='+value;
                $.ajax({
                    type:'POST',
                    url: urlTotal,
                    success: function(total) {
                        sweetAlert("Yeep! :D", "Configuracao atualizada!", "success");
                    },
                    error: function() {
                        sweetAlert("Oops! :(", "Ocorreu um erro no servidor", "error");
                    }   
                });
            });
        </script>
    </body>
</html>
