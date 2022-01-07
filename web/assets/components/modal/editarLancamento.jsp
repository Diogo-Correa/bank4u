<%-- 
    Document   : novoLancamento
    Created on : 30/12/2021, 23:16:26
    Author     : Diogo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="ModalNovoLancamento" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen-sm-down">
        <div class="modal-content">
            <div class="modal-header bg-primary text-light" id="header">
              <h5 class="modal-title" id="exampleModalLabel">Lancamento</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="" method="" onsubmit="$('.loader').show(); $('.enter_txt').hide();">
                <div class="mb-3">
                  <label for="editCategoria" class="col-form-label">Categorias:</label>
                  <select class="form-select" id="editCategoria" name="id_categoria" disabled>
                      <c:forEach var="c" items="${categorias}">
                      <option value="${c.getId()}">${c.getDescricao()}</option>
                      </c:forEach>
                  </select>
                </div>
                <div class="mb-3">
                  <label for="editValor" class="col-form-label">Valor:</label>
                  <input type="number" id="editValor" class="form-control" min="0" max="10000" step="0.1" value="0.00" name="valor" disabled />
                </div>
                <div class="mb-3">
                  <label for="editOperacao" class="col-form-label">Operacao:</label>
                  <select class="form-select" id="editOperacao" name="operacao" disabled>
                      <option value="C">Credito</option>
                      <option value="D">Debito</option>
                  </select>
                </div>
                <div class="mb-3">
                  <label for="editData" class="col-form-label">Data:</label>
                  <input type="date" class="form-control" id="editData" disabled />
                </div>
                <div class="mb-3">
                  <label for="editDescricao" class="col-form-label">Descricao:</label>
                  <textarea class="form-control" id="editDescricao" name="descricao" disabled></textarea>
                </div>
            </div>
            <button type="button" class="btn btn-sm btn-warning float-end m-1 editButton" id="editButton"><i class="fas fa-pen"></i> Editar</button>
            <button type="button" class="btn btn-sm btn-danger float-end m-1" id="deleteButton"><i class="fas fa-trash"></i> Excluir</button>
            <div class="modal-footer d-none" id="footer">
              <button type="submit" class="btn btn-warning">
                    <span class="spinner-border spinner-border-sm loader" role="status" style="display:none;">
                        <span class="visually-hidden">Loading...</span>
                    </span>
                    <span class="enter_txt">
                        <i class="fas fa-paper-plane"></i>
                    </span>
              </button>
              </form>
            </div>
        </div>
    </div>
</div>


<script>
        
        
        $(document).on("click", ".editButton", function() {
            let categoria = $("#editCategoria");
            let valor = $("#editValor");
            let operacao = $("#editOperacao");
            let data = $("#editData");
            let descricao = $("#editDescricao");
            let header = $("#header");
            let editButton = $("#editButton");
            let footer = $("#footer");
            
            categoria.prop('disabled', false);
            valor.prop('disabled', false);
            operacao.prop('disabled', false);
            data.prop('disabled', false);
            descricao.prop('disabled', false);
            header.removeClass("bg-primary");
            header.addClass("bg-warning text-dark");
            editButton.removeClass("btn-warning");
            editButton.addClass("btn-primary");
            editButton.removeClass("editButton");
            editButton.addClass("viewButton");
            editButton.html("<i class='fas fa-eye'></i> Visualizar");
            footer.removeClass("d-none");
        });
        $(document).on("click", ".viewButton", function() {
            let categoria = $("#editCategoria");
            let valor = $("#editValor");
            let operacao = $("#editOperacao");
            let data = $("#editData");
            let descricao = $("#editDescricao");
            let header = $("#header");
            let headerTitle = $("#exampleModalLabel");
            let editButton = $("#editButton");
            let footer = $("#footer");
            
            categoria.prop('disabled', true);
            valor.prop('disabled', true);
            operacao.prop('disabled', true);
            data.prop('disabled', true);
            descricao.prop('disabled', true);
            header.addClass("bg-primary");
            header.removeClass("bg-warning text-dark");
            editButton.addClass("btn-warning");
            editButton.addClass("editButton");
            editButton.removeClass("viewButton");
            editButton.html("<i class='fas fa-pen'></i> Editar");
            footer.addClass("d-none");
        });
</script>
