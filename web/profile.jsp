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
        <title>4U - Profile</title>
    </head>
    <body ${applicationDarkTheme ? '' : 'style="background-color: #efefef !important;" class="text-dark"'}>
        
        <jsp:include page="./assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="./assets/components/header/header.jsp" />
        
        <div class="container">
            
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb ${applicationDarkTheme ? 'bg-dark' : 'bg-white'} p-3 rounded shadow-sm">
                    <li class="breadcrumb-item" aria-current="page"><a href="home"><i class="fas fa-home"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Perfil</li>
                </ol>
            </nav>
            
            <div class="row">
                <div class="col-lg-3 mb-3">
                    <div class="row">
                        <div class="col-12 mb-3">
                            <div class="card ${applicationDarkTheme ? 'bg-dark' : 'bg-white text-dark'} rounded shadow-sm">
                                <div class="card-body text-center">
                                    <div class="user-avatar text-center">
                                        <p></p>
                                    </div>
                                    <h5>${nome}</h5>
                                    <span class="badge ${isAdmin ?  'bg-danger' : 'bg-primary'}">${isAdmin ?  'Admin' : 'Usuario'}</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="list-group">
                                <a id="perfil" class="list-group-item list-group-item-action ${applicationDarkTheme ? 'text-white' : ''} active pointer" aria-current="true">
                                  <i class="fas fa-user-circle me-2"></i> Perfil
                                </a>
                                <a id="password" class="list-group-item ${applicationDarkTheme ? 'bg-dark text-white' : ''} list-group-item-action pointer"><i class="fas fa-key me-2"></i> Mudar senha</a>
                                <c:if test="${contas != null}">
                                    <a id="wallets" class="list-group-item ${applicationDarkTheme ? 'bg-dark text-white' : ''} list-group-item-action pointer"><i class="fas fa-piggy-bank me-2"></i> Minhas contas</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9 mb-3">
                    <div class="row">
                        <div class="col-12">
                            <div class="card ${applicationDarkTheme ? 'bg-dark' : 'bg-white text-dark'} rounded shadow-sm">
                                <div class="card-body">
                                    <div class="row" id="content">
                                        <div class="col-12  ${applicationDarkTheme ? 'bg-black' : 'bg-black text-white'} rounded shadow-sm p-2 rounded">
                                            <strong>
                                                <i class="fas fa-nada me-2"></i> Infos
                                            </strong>
                                        </div>
                                        <div class="col-6 p-4">
                                            <i class="fas fa-user-shield me-2"></i> 
                                            ${cpf}
                                        </div>
                                        <div class="col-12 ${applicationDarkTheme ? 'bg-black' : 'bg-black text-white'} p-2 rounded">
                                            <strong>
                                                <i class="fas fa-pen me-2"></i> Alterar nome
                                            </strong>
                                        </div>
                                        <div class="col-lg-6 p-4">
                                            <form action="profile?action=update" method="POST" onsubmit="$('.loader').show(); $('.enter_txt').hide();">
                                                <div class="input-group">
                                                    <div class="form-floating">
                                                        <input type="text" class="form-control ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" name="nome" id="nome" placeholder="Digite seu nome" maxlength="20" required>
                                                        <label for="nome" id="labelNome">${nome}</label>
                                                    </div>
                                                    <button class="btn btn-outline-secondary disabled" type="submit" id="buttonNome">
                                                        <span class="spinner-border spinner-border-sm loader" role="status" style="display:none;">
                                                            <span class="visually-hidden">Loading...</span>
                                                        </span>
                                                        <span class="enter_txt">
                                                            <i class="fas fa-save"></i>
                                                        </span>
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
        <jsp:include page="./assets/includes/scripts.html" />
        
        <jsp:include page="./assets/components/modal/editarConta.jsp" />
        <jsp:include page="./assets/components/modal/confirmaAction.html" />
        <script>
            $(document).on("click", "#perfil", function() {
                var darkTheme = ${applicationDarkTheme};
                if(darkTheme) {
                    $("#perfil").removeClass("bg-dark");
                    
                    $("#password").addClass("bg-dark");

                    $("#wallets").addClass("bg-dark");
                }
                
                $("#perfil").addClass("active");
                $("#password").removeClass("active");
                $("#wallets").removeClass("active");
                
                $("#content").html(`
                    <div class="col-12  ${applicationDarkTheme ? 'bg-black' : 'bg-black text-white'} rounded shadow-sm p-2 rounded">
                        <strong>
                            <i class="fas fa-nada me-2"></i> Infos
                        </strong>
                    </div>
                    <div class="col-6 p-4">
                        <i class="fas fa-user-shield me-2"></i> 
                        ${cpf}
                    </div>
                    <div class="col-12 ${applicationDarkTheme ? 'bg-black' : 'bg-black text-white'} p-2 rounded">
                        <strong>
                            <i class="fas fa-pen me-2"></i> Alterar nome
                        </strong>
                    </div>
                    <div class="col-lg-6 p-4">
                        <form action="profile?action=update" method="POST" onsubmit="$('.loader').show(); $('.enter_txt').hide();">
                            <div class="input-group">
                                <div class="form-floating">
                                    <input type="text" class="form-control ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" name="nome" id="nome" placeholder="Digite seu nome" maxlength="20" required>
                                    <label for="nome" id="labelNome">${nome}</label>
                                </div>
                                <button class="btn btn-outline-secondary disabled" type="submit" id="buttonNome">
                                    <span class="spinner-border spinner-border-sm loader" role="status" style="display:none;">
                                        <span class="visually-hidden">Loading...</span>
                                    </span>
                                    <span class="enter_txt">
                                        <i class="fas fa-save"></i>
                                    </span>
                                </button>
                            </div>
                        </form>
                    </div>
                `)
            });
            $(document).on("click", "#password", function() {
                var darkTheme = ${applicationDarkTheme};
                if(darkTheme) {
                    $("#perfil").addClass("bg-dark");

                    $("#password").removeClass("bg-dark");

                    $("#wallets").addClass("bg-dark");
                }
                $("#perfil").removeClass("active");
                
                $("#password").addClass("active");
                
                $("#wallets").removeClass("active");
                
                $("#content").html(`
        
                                        <div class="col-12 ${applicationDarkTheme ? 'bg-black' : 'bg-black text-white'} p-2 rounded">
                                            <strong>
                                                <i class="fas fa-key me-2"></i> Alterar senha
                                            </strong>
                                        </div>
                                        <div class="col-lg-8 p-4">
                                            <form action="profile?action=update" method="POST" onsubmit="$('.loader').show(); $('.enter_txt').hide();">
                                                <div class="input-group mb-2">
                                                    <div class="form-floating">
                                                        <input type="password" class="form-control ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" id="senha_antiga" placeholder="Digite sua senha antiga" required>
                                                        <label for="senha_antiga" id="labelNome">Digite sua antiga senha</label>
                                                    </div>
                                                </div>

                                                <div class="input-group">
                                                    <div class="form-floating">
                                                        <input type="password" class="form-control ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" name="senha" id="senha" placeholder="Digite a nova senha" required disabled>
                                                        <label for="senha" id="labelSenha">Digite sua nova senha</label>
                                                    </div>
                                                    <button class="btn btn-outline-secondary disabled" type="submit" id="buttonNome">
                                                        <span class="spinner-border spinner-border-sm loader" role="status" style="display:none;">
                                                            <span class="visually-hidden">Loading...</span>
                                                        </span>
                                                        <span class="enter_txt">
                                                            <i class="fas fa-save"></i>
                                                        </span>
                                                    </button>
                                                </div>
                                            </form>
                                                
                                        </div>
                            `);
            });
            $(document).on("click", "#wallets", function() {
                
                var darkTheme = ${applicationDarkTheme};
                if(darkTheme) {
                    $("#perfil").addClass("bg-dark");

                    $("#password").addClass("bg-dark");

                    $("#wallets").removeClass("bg-dark");
                }
                $("#perfil").removeClass("active");
                $("#password").removeClass("active");
                $("#wallets").addClass("active");
                
                $("#content").html(`
                                        <div class="col-12 ${applicationDarkTheme ? 'bg-black' : 'bg-black tex-white'} text-light p-2 rounded">
                                            <strong>
                                                <i class="fas fa-piggy-bank me-2"></i> Minhas contas
                                            </strong>
                                        </div>
                                        <div class="col-12 p-4">
                                            <c:if test="${contas != null}">
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
                                                                                  <a class="dropdown-item d-flex gap-2 align-items-center" href="#" data-bs-toggle="modal" data-bs-target="#editConta" onclick="openEdit(${c.id}, '${c.nome}', '${c.banco}', '${c.agencia}', '${c.conta}')">
                                                                                    <i class="fas fa-pen"></i>
                                                                                    Editar
                                                                                  </a>
                                                                                </li>
                                                                                <li><hr class="dropdown-divider"></li>
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
                    `);
            });
            
            $(document).on("input", "#nome", function() {
                var input = $("#nome");
                var regexp = /[^a-zA-Z ]/g;
                
                if(this.value.match(regexp)){
                  $(this).val(this.value.replace(regexp,''));
                }
                
                if(input.val().length >= 3) {
                    $("#buttonNome").removeClass("disabled");
                    $("#buttonNome").removeClass("btn-outline-secondary");
                    $("#buttonNome").addClass("btn-outline-success");
                    input.removeClass("is-invalid");
                    input.addClass("is-valid");
                    $("#labelNome").html(`${nome}`);
                } else {
                    input.removeClass("is-valid");
                    input.addClass("is-invalid");
                    $("#buttonNome").addClass("disabled");
                    $("#buttonNome").addClass("btn-outline-secondary");
                    $("#buttonNome").removeClass("btn-outline-success");
                    $("#labelNome").text("Nome invalido.");
                }
            });
            
            $(document).on("input", "#senha_antiga", function() {
                var oldPass = `${senha}`;
                var input = $("#senha_antiga");
                if(input.val() == oldPass) {
                    input.removeClass("is-invalid");
                    input.addClass("is-valid");
                    $("#labelNome").text("Digite sua antiga senha");
                    $("#senha").prop("disabled", false);
                } else {
                    input.removeClass("is-valid");
                    input.addClass("is-invalid");
                    $("#labelNome").text("Senha invalida.");
                    $("#senha").prop("disabled", true);
                }
            });
            
            $(document).on("input", "#senha", function() {
                var oldPass = `${senha}`;
                var input = $("#senha");
                if(input.val().length >= 3 && input.val().length != "" && input.val() != oldPass) {
                    $("#buttonNome").removeClass("disabled");
                    $("#buttonNome").removeClass("btn-outline-secondary");
                    $("#buttonNome").addClass("btn-outline-success");
                    input.removeClass("is-invalid");
                    input.addClass("is-valid");
                    $("#labelSenha").text("Digite sua antiga senha");
                    $("#senha").prop("disabled", false);
                } else {
                    input.removeClass("is-valid");
                    input.addClass("is-invalid");
                    $("#buttonNome").addClass("disabled");
                    $("#buttonNome").addClass("btn-outline-secondary");
                    $("#buttonNome").removeClass("btn-outline-success");
                    $("#labelSenha").text("Senha invalida.");
                }
            });
            
            function openEdit(id, nome, banco, agencia, conta) {
                $("#nome_conta").val(nome);
                $("#banco").val(banco);
                $("#agencia").val(agencia);
                $("#conta_corrente").val(conta.slice(0, 4));
                $("#digito").val(conta.slice(5, 6));
                $("#formEditConta").attr("action", "wallet?action=update&id="+id);
            }
        </script>
        
    </body>
</html>
