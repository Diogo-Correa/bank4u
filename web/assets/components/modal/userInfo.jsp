<%-- 
    Document   : userInfo
    Created on : 29/01/2022, 17:10:07
    Author     : Diogo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal text-dark modal-dialog-scrollable" tabindex="-1" id="infosModal">
  <div class="modal-dialog">
    <div class="modal-content ${applicationDarkTheme ? 'bg-dark text-white' : 'bg-white text-dark'}">
      <div class="modal-header" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
        <h5 class="modal-title">Infos</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="alert alert-info">Para desativar esse modal desative a opcao 'AllowModalInfoOnLogin' em <a href='settings' class='link-info'><i class="fas fa-cog"></i>settings</a>. (Remover esse alerta em producao).</div>
        <h3>Menu:</h3>
        <p><i class="fas fa-home"></i>: Home</p>
        <p><i class="fas fa-user-circle"></i>: Perfil</p>
        <p><i class="fas fa-sign-out-alt"></i>: Logout</p>
        <div class="alert bg-danger">Para visualizar, editar e deletar os lancamentos basta navegar pelo extrato e, ao encontrar algum, clicar com o botao esquerdo sobre ele.</div>
        <div class="alert bg-danger">Para criar uma nova conta, basta selecionar a opcao "Nova conta" no input select.</div>
        <div class="alert bg-danger">Para gerenciar as contas bancarias e outras opcoes do usuario, entre no seu perfil.</div>
        <div class="alert bg-danger">Contas com saldos negativos estao com alertas.</div>
      </div>
    </div>
  </div>
</div>
