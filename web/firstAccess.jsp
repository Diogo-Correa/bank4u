<%-- 
    Document   : profile
    Created on : 18/01/2022, 13:17:53
    Author     : Diogo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ${applicationDarkTheme ? '' : 'style="background-color: #efefef !important;"'}>
    <head>
        <jsp:include page="./assets/includes/head.html" />
        <title>4U - Setup</title>
    </head>
    <body ${applicationDarkTheme ? '' : 'style="background-color: #efefef !important;" class="text-dark"'}>
        
        <jsp:include page="./assets/components/modal/alertMsgs.jsp" />
        
        <div class="container my-5">
            <div class="text-center mb-3">
                <a class="navbar-brand d-block ps-3" href="#">4U</a>
                <p class="text-muted">Setup</p>
            </div>
            
            <div class="card ${applicationDarkTheme ? 'bg-dark' : 'bg-white text-dark'} mb-5">
                <div class="card-body p-5">
                    <h3><i class="fas fa-cog"></i> Primeiro acesso</h3>
                    <p class="small text-muted">Aqui voce vai encontrar as configuracoes do sistema para comecar a fazer o uso.</p>
                    
                    <div class="my-5 p-5 py-2">
                        <h5 id="dbtitle"><i class="fas fa-database" id="dbIcon"></i> Database configs</h5>
                        <p class="small text-muted mb-3">Configuracoes iniciais do banco de dados.</p>
                        <div class="d-none" id="alert">
                            
                        </div>
                        <form id="dbForm">
                            
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control  ${applicationDarkTheme ? 'bg-black text-white border-dark' : ''}" id="driver" name="driver" placeholder="Driver" value="com.mysql.jdbc.Driver" required>
                                <label for="driver">Database driver</label>
                            </div>
                            
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control  ${applicationDarkTheme ? 'bg-black text-white border-dark' : ''}" id="host" name="host" placeholder="Hostname" value="jdbc:mysql://localhost:3306/financeiro" required>
                                <label for="host">Database host</label>
                            </div>
                            
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control  ${applicationDarkTheme ? 'bg-black text-white border-dark' : ''}" id="username" name="username" placeholder="Username" value="root" required>
                                <label for="username">Database username</label>
                            </div>
                            
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control  ${applicationDarkTheme ? 'bg-black text-white border-dark' : ''}" id="password" name="password" placeholder="Password">
                                <label for="password">Database password</label>
                            </div>
                            <div class="form-floating mb-3">
                                <button type="button" class="btn  ${applicationDarkTheme ? 'btn-light' : 'btn-dark'}" id="testarConexao"><i class="fas fa-plug"></i> Testar conexao</button>
                                <button type="button" class="btn btn-success disabled" id="save"><i class="fas fa-save"></i> Salvar</button>
                            </div>
                            
                        </form>
                    </div>
                    
                    <div class="my-5 p-5 py-2">
                        <h5><i class="fas fa-database"></i> System configs</h5>
                        <p class="small text-muted mb-3">Configuracoes do sistema. Essas opcoes podem ser alteradas em um usuario admin (settings page).</p>
                        
                        <h6 class="ps-4 pt-3"><i class="fas fa-tools"></i> App configs</h6>

                        <div class="d-flex ps-4 pt-3">
                          <i class="fas fa-sign-in-alt me-2"></i> 
                          <div class="pb-3 mb-0 small lh-sm border-bottom w-100" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
                              <div class="form-check form-switch">
                                <label class="form-check-label" for="allowModalInfoOnLogin">Mostrar o modal de informacoes apos efetuar o login?</label>
                                <input class="form-check-input" type="checkbox" role="switch" id="allowModalInfoOnLogin" ${allowModalInfoOnLogin ? 'checked' : ''}>
                              </div>
                          </div>
                        </div>

                        <div class="d-flex ps-4 pt-3">
                          <i class="fas fa-exclamation-triangle me-2"></i>
                          <div class="pb-3 mb-0 small lh-sm border-bottom w-100" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
                              <div class="form-check form-switch">
                                <label class="form-check-label" for="showAlertNegativeAccounts">Mostrar alerta para contas negativas?</label>
                                <input class="form-check-input" type="checkbox" role="switch" id="showAlertNegativeAccounts" ${showAlertNegativeAccounts ? 'checked' : ''}>
                              </div>
                          </div>
                        </div>

                        <div class="d-flex ps-4 pt-3">
                          <i class="fas fa-palette me-2"></i>
                          <div class="pb-3 mb-0 small lh-sm border-bottom w-100" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
                              <div class="form-check form-switch">
                                <label class="form-check-label" for="applicationDarkTheme">Ativar tema dark?</label>
                                <input class="form-check-input" type="checkbox" role="switch" id="applicationDarkTheme" ${applicationDarkTheme ? 'checked' : ''}>
                              </div>
                          </div>
                        </div>
                              
                              <h6 class="ps-4 pt-5"><i class="fas fa-user-cog"></i> Admin configs</h6>
                    
                    <div class="d-flex ps-4 pt-3">
                      <i class="fas fa-wallet me-2"></i> 
                      <div class="pb-3 mb-0 small lh-sm border-bottom w-100" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
                          <div class="form-check form-switch">
                            <label class="form-check-label" for="allowAdminDeleteBankAcc">Permitir que administradores deletem contas bancarias dos usuarios?</label>
                            <input class="form-check-input" type="checkbox" role="switch" name="AllowAdminDeleteBankAcc" id="allowAdminDeleteBankAcc" ${allowAdminDeleteBankAcc ? 'checked' : ''}>
                          </div>
                      </div>
                    </div>
                    
                    <div class="d-flex ps-4 pt-3">
                      <i class="fas fa-piggy-bank me-2"></i> 
                      <div class="pb-3 mb-0 small lh-sm border-bottom w-100" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
                          <div class="form-check form-switch">
                            <label class="form-check-label" for="allowAdminDeleteEntries">Permitir que administradores deletem lancamentos bancarios dos usuarios?</label>
                            <input class="form-check-input" type="checkbox" role="switch" name="AllowAdminDeleteEntries" id="allowAdminDeleteEntries" ${allowAdminDeleteEntries ? 'checked' : ''}>
                          </div>
                      </div>
                    </div>
                    </div>
                </div>
                          
                <a href="setup?action=finalize" class="btn btn-success disabled" id="finalize"><i class="fas fa-check"></i> Finalizar</a>
                          
            </div>
        </div>
                          <br>
        <jsp:include page="./assets/includes/scripts.html" />
        
        <script>
            $(document).on("click", "#testarConexao", function() {
                var driver = $("#driver").val();
                var url = $("#host").val();
                var user = $("#username").val();
                var pass = $("#password").val();
                
                var urlTotal = 'setup?action=dbTest&driver='+driver+'&host='+url+'&username='+user+'&password='+pass;
                $.ajax({
                    type:'POST',
                    url: urlTotal,
                    success: function(res) {
                        if(res == 'ok!'){
                            $("#alert").removeClass('alert bg-danger');
                            $("#alert").addClass('alert bg-warning text-dark');
                            $("#alert").removeClass('d-none');
                            function banco(){
                                $("#alert").html(`
                                    <span class="spinner-border spinner-border-sm loader" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </span>
                                    Checando conexao, aguarde...
                                `);
                            }
                            setTimeout(banco, 0);
                            
                            function success(){
                                $("#alert").removeClass('alert bg-warning text-dark');
                                $("#alert").addClass('alert bg-success');
                                $("#alert").html(`
                                    <i class="fas fa-check"></i>
                                    Conexao efetuada com sucesso!
                                `);
                                $("#driver").addClass('is-valid');
                                $("#host").addClass('is-valid');
                                $("#username").addClass('is-valid');
                                $("#password").addClass('is-valid');
                                $("#save").removeClass('disabled');
                            }
                            setTimeout(success, 1000*5);
                            
                            
                        } else {
                            $("#alert").removeClass('alert bg-danger');
                            $("#alert").addClass('alert bg-warning text-dark');
                            $("#alert").removeClass('d-none');
                            function banco(){
                                $("#alert").html(`
                                    <span class="spinner-border spinner-border-sm loader" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </span>
                                    Checando conexao, aguarde...
                                `);
                            }
                            setTimeout(banco, 0);
                            
                            function error(){
                                $("#alert").removeClass('alert bg-success');
                                $("#alert").removeClass('alert bg-warning text-dark');
                                $("#alert").addClass('alert bg-danger');

                                $("#alert").removeClass('d-none');
                                $("#save").addClass('disabled');

                                $("#alert").html(res);
                                $("#driver").addClass('is-invalid');
                                $("#host").addClass('is-invalid');
                                $("#username").addClass('is-invalid');
                                $("#password").addClass('is-invalid');
                            }
                            setTimeout(error, 1000*5);
                        }
                    },
                    error: function() {
                        sweetAlert("Oops! :(", "Ocorreu um erro no servidor", "error");
                    }   
                });
            });
            
            
            $(document).on("click", "#save", function() {
                var driver = $("#driver").val();
                var url = $("#host").val();
                var user = $("#username").val();
                var pass = $("#password").val();
                
                var urlTotal = 'setup?action=dbSave&driver='+driver+'&host='+url+'&username='+user+'&password='+pass;
                $.ajax({
                    type:'POST',
                    url: urlTotal,
                    success: function(res) {
                        if(res == 'ok!'){
                            $("#alert").removeClass('alert bg-danger');
                            $("#alert").addClass('alert bg-warning text-dark');
                            $("#save").addClass('disabled');
                            $("#testarConexao").addClass('disabled');
                            
                            function save(){
                                $("#alert").html(`
                                    <span class="spinner-border spinner-border-sm loader" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </span>
                                    Salvando configuracoes, aguarde...
                                `);
                            }
                            setTimeout(save, 0);
                            
                            function success(){
                                $("#alert").removeClass('alert bg-warning text-dark');
                                $("#alert").addClass('alert bg-success');
                                $("#finalize").removeClass('disabled');
                                $("#alert").html(`
                                    <i class="fas fa-check"></i>
                                    Configuracao salva com sucesso!
                                `);
                            }
                            setTimeout(success, 5*10);
                            
                            $("#dbForm").html(`
                                <button class="btn btn-danger" type="button" id="dbInstall"><i class="fas fa-database"></i> Instalar banco de dados</button>
                                <p class="text-danger py-2">Voce ja pode finalizar o processo de instalacao. A criacao do banco de dados nao esta como obrigatoria.</p>
                            `);
                            
                        } else {
                            $("#save").removeClass('disabled');
                            $("#testarConexao").removeClass('disabled');
                            $("#dbtitle").removeClass('text-success');
                            $("#dbIcon").removeClass('fa-check');
                            $("#dbIcon").addClass('fa-database');
                            
                            $("#driver").addClass('is-invalid');
                            $("#host").addClass('is-invalid');
                            $("#username").addClass('is-invalid');
                            $("#password").addClass('is-invalid');
                            
                            $("#alert").html(res);
                        }
                    },
                    error: function() {
                        sweetAlert("Oops! :(", "Ocorreu um erro no servidor", "error");
                    }   
                });
            });
            
            
            $(document).on("click", "#dbInstall", function() {
                
                var urlTotal = 'setup?action=dbInstall';
                $.ajax({
                    type:'POST',
                    url: urlTotal,
                    success: function(res) {
                        if(res == 'ok!'){
                            $("#alert").removeClass('alert bg-success');
                            $("#alert").addClass('alert bg-warning text-dark');
                            $("#alert").removeClass('d-none');
                            $("#dbInstall").removeClass('disabled');
                            function banco(){
                                $("#alert").html(`
                                    <span class="spinner-border spinner-border-sm loader" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </span>
                                    Criando banco de dados, aguarde...
                                `);
                            }
                            setTimeout(banco, 0);
                            function success(){
                                $("#alert").removeClass('alert bg-warning text-dark');
                                $("#alert").addClass('alert bg-success');
                                $("#dbInstall").addClass('d-none');
                                $("#dbtitle").addClass('text-success');
                                $("#dbIcon").removeClass('fa-database');
                                $("#dbIcon").addClass('fa-check');
                                $("#alert").html(`
                                    <i class="fas fa-check"></i>
                                    Banco de dados criado com sucesso!
                                `);
                            }
                            setTimeout(success, 1000*10);
                        } else {
                            console.log(res);
                        }
                    },
                    error: function() {
                        sweetAlert("Oops! :(", "Ocorreu um erro no servidor", "error");
                    } 
                });
            });
            
            $(document).on("input", "input[type='checkbox']", function(e) {
                e.preventDefault();
                var value;
                var action = this.id;
                console.log(action);
                if($(this).is(':checked')) value = true;
                else value = false;
                
                var urlTotal = 'setup?action=update&'+action+'='+value;
                console.log(urlTotal);
                $.ajax({
                    type:'POST',
                    url: urlTotal,
                    success: function(res) {
                        if(res == 'ok!') sweetAlert("Yeep! :D", "Configuracao atualizada!", "success");
                    },
                    error: function(res) {
                        sweetAlert("Oops! :(", res, "error");
                    }   
                });
            });
            
        </script>
        
    </body>
</html>
