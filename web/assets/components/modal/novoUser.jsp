<%-- 
    Document   : novoUser
    Created on : 29/01/2022, 16:48:54
    Author     : Diogo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="novoUser" tabindex="-1" aria-labelledby="ModalNovoUsuario" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen-sm-down">
        <div class="modal-content  ${applicationDarkTheme ? 'bg-dark' : 'bg-white text-dark'}">
            <div class="modal-header bg-success text-light" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
              <h5 class="modal-title" id="exampleModalLabel">Novo usuario</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="user?action=store" method="POST" onsubmit="$('.loader').show(); $('.enter_txt').hide();">
                <div class="mb-3">
                  <label for="nome" class="col-form-label">Nome:</label>
                  <input type="text" class="form-control ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" id="nome" name="nome" maxlength="20" required />
                </div>
                <div class="mb-3">
                  <label for="cpf" class="col-form-label">CPF:</label>
                  <input type="text" class="form-control mascara-cpf ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" id="cpf" name="cpf" maxlength="14" oninput="validateCPF(this.value)" required />
                  <div id="cpf" class="invalid-feedback">
                    Por favor, digite um CPF valido.
                  </div>
                </div>
                <div class="mb-3">
                  <label for="senha" class="col-form-label">Senha:</label>
                  <input type="password" class="form-control  ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" id="senha" name="senha" required />
                </div>
                <div class="mb-3">
                    <input class="list-group-item-check" type="radio" name="role" id="admin" value="admin">
                    <label class="list-group-item ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''} py-3" id="adminLabel" for="admin">
                        Administrador
                        <span class="d-block small opacity-50">Usuario master</span>
                    </label>
                    <input class="list-group-item-check" type="radio" name="role" id="user" value="user">
                    <label class="list-group-item py-3 ${applicationDarkTheme ? 'bg-black border-dark text-white' : ''}" id="userLabel" for="user">
                        Usuario
                        <span class="d-block small opacity-50">Usuario basico</span>
                    </label>
                </div>
            </div>
            <div class="modal-footer" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
              <button type="submit" class="btn btn-success" id="btnDisabled" disabled>
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
