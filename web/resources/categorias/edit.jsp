<%-- 
    Document   : showCategoria
    Created on : 27/12/2021, 19:21:05
    Author     : Diogo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ${applicationDarkTheme ? '' : 'style="background-color: #efefef !important;"'}>
    <head>
        <jsp:include page="../../assets/includes/head.html" />
        <title>4U - Edit ${nome}</title>
    </head>
    <body ${applicationDarkTheme ? '' : 'style="background-color: #efefef !important;" class="text-dark"'}>
        
        <jsp:include page="../../assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="../../assets/components/header/header.jsp" />
        
        <div class="container">
            
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb ${applicationDarkTheme ? 'bg-dark' : 'bg-white'} p-3 rounded shadow-sm">
                    <li class="breadcrumb-item"><a href="home"><i class="fas fa-th-large"></i></a></li>
                    <li class="breadcrumb-item"><a href="category"><i class="fas fa-tags"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Editar</li>
                    <li class="breadcrumb-item active" aria-current="page">${nome}</li>
                </ol>
            </nav>
                
            <div class="card text-dark border-0 mb-3 ${applicationDarkTheme ? 'bg-dark' : 'bg-body text-dark'} rounded shadow-sm">
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
                          <div class="pb-3 mb-0 small lh-sm border-bottom w-100" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
                            <div class="d-flex justify-content-between">
                              <strong class="text-gray-dark"> Nome</strong>
                            </div>
                              <span class="d-block"><input type="text" name="descricao" value="${nome}" class="form-control ${applicationDarkTheme ? 'bg-black text-white border-dark' : ''}" oninput="changeTitle(this.value)" maxlength="20"/></span>
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
