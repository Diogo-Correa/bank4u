<%-- 
    Document   : novoLancamento
    Created on : 30/12/2021, 23:16:26
    Author     : Diogo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="novoLancamento" tabindex="-1" aria-labelledby="ModalNovoLancamento" aria-hidden="true">
    <div class="modal-dialog  ${applicationDarkTheme ? 'bg-dark' : 'bg-white text-dark'} modal-fullscreen-sm-down">
        <div class="modal-content ${applicationDarkTheme ? 'bg-dark' : 'bg-white text-dark'}">
            <div class="modal-header bg-success text-light" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
              <h5 class="modal-title" id="exampleModalLabel">Novo lancamento</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="entries?action=store" method="POST" onsubmit="$('.loader').show(); $('.enter_txt').hide();">
                    <div class="mb-3">
                      <label for="conta" class="col-form-label">Contas</label>
                      <select class="form-select ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" id="id_conta" name="id_conta">
                          <c:forEach var="c" items="${contas}">
                          <option value="${c.getId()}">${c.getNome()}</option>
                          </c:forEach>
                      </select>
                    </div>
                    <div class="mb-3">
                      <label for="categoria" class="col-form-label">Categorias:</label>
                      <select class="form-select ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" id="categoria" name="id_categoria">
                          <c:forEach var="c" items="${categorias}">
                          <option value="${c.getId()}">${c.getDescricao()}</option>
                          </c:forEach>
                      </select>
                    </div>
                    <div class="mb-3">
                      <label for="valor" class="col-form-label">Valor:</label>
                      <input type="number" class="form-control ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" min="0" max="10000" step="0.01" value="0.00" id="valor" name="valor"/>
                    </div>
                    <div class="mb-3">
                      <label for="operacao" class="col-form-label">Operacao:</label>
                      <select class="form-select ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" id="operacao" name="operacao">
                          <option value="C">Credito</option>
                          <option value="D">Debito</option>
                      </select>
                    </div>
                    <div class="mb-3">
                      <label for="data" class="col-form-label">Data:</label>
                      <input type="date" class="form-control ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" id="data" name="data" value="data"/>
                    </div>
                    <div class="mb-3">
                      <label for="descricao" class="col-form-label">Descricao:</label>
                      <textarea class="form-control ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" id="descricao" name="descricao"></textarea>
                    </div>
                </div>
                <div class="modal-footer" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
                  <button type="submit" class="btn btn-success">
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

