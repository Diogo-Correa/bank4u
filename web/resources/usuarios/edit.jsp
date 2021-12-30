<%-- 
    Document   : edit
    Created on : 15/12/2021, 19:40:15
    Author     : Diogo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8" import="app.Administrador"%>
<!DOCTYPE html>
<html style="background-color: #efefef !important;">
    <head>
        <jsp:include page="../../assets/includes/head.html" />
        <title>4U - Edit ${nome}</title>
    </head>
    <body style="background-color: #efefef !important;" class="text-dark">
        
        <jsp:include page="../../assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="../../assets/components/header/header.jsp" />
        
        <div class="container">
            
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb bg-white p-3 rounded shadow-sm">
                    <li class="breadcrumb-item"><a href="home"><i class="fas fa-th-large"></i></a></li>
                    <li class="breadcrumb-item"><a href="user"><i class="fas fa-user"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Editar</li>
                    <li class="breadcrumb-item active" aria-current="page">${nome}</li>
                </ol>
            </nav>
            
            <div class="card text-dark border-0 mb-3 bg-body rounded shadow-sm">
                <div class="card-header bg-warning">
                    <h5 class="card-title py-2">
                        <i class="fas fa-user"></i>
                        <span id="nameTitleOld">${nome}</span>
                        <span id="nameTitle" class="d-none">${nome}</span>
                    </h5>
                </div>
                <div class="card-body">
                    
                    <c:choose>
                        <c:when test="${admin}">
                            <form action="user?action=update&admin=true" method="POST" onsubmit="$('.loader').show(); $('.enter_txt').hide();">
                        </c:when>    
                        <c:otherwise>
                            <form action="user?action=update" method="POST" onsubmit="$('.loader').show(); $('.enter_txt').hide();">
                        </c:otherwise>
                    </c:choose>
                                
                        <input type="hidden" value="${id}" name="id" class="form-control" />
                        
                        <div class="d-flex text-muted pt-3">
                          <i class="fas fa-user me-2"></i> 
                          <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                            <div class="d-flex justify-content-between">
                              <strong class="text-gray-dark"> Nome</strong>
                            </div>
                              <span class="d-block"><input type="text" name="nome" value="${nome}" class="form-control" oninput="changeTitle(this.value)" maxlength="20" required/></span>
                          </div>
                        </div>
                        <div class="d-flex text-muted pt-3">
                          <i class="fas fa-user-shield me-2"></i> 
                          <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                            <div class="d-flex justify-content-between">
                              <strong class="text-gray-dark"> CPF</strong>
                            </div>
                              <input type="text" class="form-control mascara-cpf" id="cpf" value="${cpf}" name="cpf" maxlength="14" oninput="validateCPF(this.value)" required />
                              <div id="cpf" class="invalid-feedback">
                                Por favor, digite um CPF valido.
                              </div>
                          </div>
                        </div>
                        <div class="d-flex text-muted pt-3">
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

                        <div class="d-flex text-muted pt-3">
                          <div class="pb-3 mb-0 small lh-sm w-100 text-end">
                              <span class="d-block">
                                <button class="btn btn-warning m-2 w-100" type="submit" id="btnDisabled"> 
                                    <span class="spinner-border spinner-border-sm loader" role="status" style="display:none;">
                                        <span class="visually-hidden">Loading...</span>
                                    </span>
                                    <span class="enter_txt">
                                        <i class="fas fa-paper-plane"></i> Atualizar
                                    </span>
                                </button>
                              </span>
                          </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <jsp:include page="../../assets/includes/scripts.html" />
    </body>
    
    <script>
        function changeTitle(input) {
            let spanNameTitleOld = document.getElementById("nameTitleOld");
            let spanNameTitle = document.getElementById("nameTitle");
            
            spanNameTitleOld.classList.add("d-none");
            spanNameTitle.classList.remove("d-none");
            spanNameTitle.innerHTML = input;
        }
        
        function validateCPF(value) {
            const cpfInput = document.getElementById('cpf');
            const btn = document.getElementById('btnDisabled');
            const isValid = new ValidaCPF(value).valida();

            if(isValid) {
              cpfInput.classList.remove('is-invalid');
              cpfInput.classList.add('is-valid');
              btn.disabled = false;
            } else {
              cpfInput.classList.add('is-invalid'); 
              btn.disabled = true;
            }
        }
    </script>
</html>
