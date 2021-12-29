<%-- 
    Document   : showCategoria
    Created on : 27/12/2021, 19:21:05
    Author     : Diogo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <div class="card text-dark border-0 mb-3 bg-body rounded shadow-sm">
                <div class="card-header bg-warning">
                    <h5 class="card-title py-2">
                        <i class="fas fa-tag"></i>
                        <span id="nameTitleOld">${nome}</span>
                        <span id="nameTitle" class="d-none">${nome}</span>
                    </h5>
                </div>
                <div class="card-body">
                    <form action="category?action=update" method="POST" onsubmit="$('.loader').show(); $('.enter_txt').hide();">
                                
                        <input type="hidden" value="${id}" name="id" class="form-control" />
                        
                        <div class="d-flex text-muted pt-3">
                          <i class="fas fa-user me-2"></i> 
                          <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                            <div class="d-flex justify-content-between">
                              <strong class="text-gray-dark"> Nome</strong>
                            </div>
                              <span class="d-block"><input type="text" name="descricao" value="${nome}" class="form-control" oninput="changeTitle(this.value)" maxlength="20"/></span>
                          </div>
                        </div>

                        <div class="d-flex text-muted pt-3">
                          <div class="pb-3 mb-0 small lh-sm w-100 text-end">
                              <span class="d-block">
                                <button class="btn btn-warning m-2 w-100" type="submit"> 
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
                            
        <jsp:include page="../../assets/components/modal/novoUser.html" />
        <jsp:include page="../../assets/components/modal/novaCategoria.html" />
        
        <jsp:include page="../../assets/components/modal/confirmaAction.html" />
        
        <jsp:include page="../../assets/includes/scripts.html" />
        
        <script>
            function changeTitle(input) {
                let spanNameTitleOld = document.getElementById("nameTitleOld");
                let spanNameTitle = document.getElementById("nameTitle");

                spanNameTitleOld.classList.add("d-none");
                spanNameTitle.classList.remove("d-none");
                spanNameTitle.innerHTML = input;
            }
        </script>
    </body>
</html>
