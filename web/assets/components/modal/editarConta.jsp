<%-- 
    Document   : editarConta
    Created on : 29/01/2022, 18:12:40
    Author     : Diogo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="editConta" tabindex="-1" aria-labelledby="ModalEditarConta" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen-sm-down">
        <div class="modal-content ${applicationDarkTheme ? 'bg-dark text-white' : 'bg-white text-dark'}">
            <div class="modal-header bg-warning text-dark" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
              <h5 class="modal-title" id="exampleModalLabel">Editar conta</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="" method="POST" id="formEditConta" onsubmit="$('.loaderConta').show(); $('.conta_txt').hide();">
                    <div class="mb-3">
                      <label for="nome_conta" class="col-form-label">Nome da conta:</label>
                      <input type="text" class="form-control ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" id="nome_conta" name="nome_conta" maxlength="20" required/>
                    </div>
                    <div class="mb-3">
                      <label for="banco" class="col-form-label">Banco:</label>
                      <select class="form-select ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" id="banco" name="banco" required>
                          <option value="001">Banco do Brasil</option>
                          <option value="341">Itau</option>
                      </select>
                    </div>
                    <div class="mb-3">
                      <label for="agencia" class="col-form-label">Agencia:</label>
                      <input type="number" class="form-control ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" min="000000" max="999999" step="000001" id="agencia" name="agencia" required/>
                    </div>
                    <div class="mb-3">
                      <label for="conta_corrente" class="col-form-label">C/C</label>
                      <input type="number" class="form-control ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" min="0000" max="9999" step="0001" id="conta_corrente" name="conta_corrente" required/>
                    </div>
                    <div class="mb-3">
                      <label for="digito" class="col-form-label">Digito</label>
                      <input type="number" class="form-control ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" min="0" max="9" id="digito" name="digito" required/>
                    </div>
                    </div>
                    <div class="modal-footer" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
                    <button type="submit" class="btn btn-warning">
                        <span class="spinner-border spinner-border-sm loaderConta" role="status" style="display:none;">
                            <span class="visually-hidden">Loading...</span>
                        </span>
                        <span class="conta_txt">
                            <i class="fas fa-paper-plane"></i>
                        </span>
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
