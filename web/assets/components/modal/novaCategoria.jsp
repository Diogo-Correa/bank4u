<%-- 
    Document   : novaCategoria
    Created on : 29/01/2022, 16:44:37
    Author     : Diogo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="modal fade" id="novaCategoria" tabindex="-1" aria-labelledby="ModalNovaCategoria" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen-sm-down">
        <div class="modal-content ${applicationDarkTheme ? 'bg-dark' : 'bg-white text-dark'}"">
            <div class="modal-header bg-success text-light" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
              <h5 class="modal-title" id="exampleModalLabel">Nova Categoria</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="category?action=store" method="POST" onsubmit="$('.loader').show(); $('.enter_txt').hide();">
                <div class="mb-3">
                  <label for="descricao" class="col-form-label">Descricao:</label>
                  <input type="text" class="form-control ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" id="descricao" name="descricao" maxlength="20" required/>
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
