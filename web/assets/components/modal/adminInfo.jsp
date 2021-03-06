<%-- 
    Document   : adminInfo
    Created on : 29/01/2022, 17:06:22
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
        <div class="alert alert-info">Para desativar esse modal desative a opcao 'AllowModalInfoOnLogin' em <a href='settings' class='link-info'><i class="fas fa-cog"></i>settings</a>.</div>
        <h3>Menu:</h3>
        <p><i class="fas fa-th-large"></i>: Home</p>
        <p><i class="fas fa-user"></i>: Listagem de usuarios do sistema</p>
        <p><i class="fas fa-tags"></i>: Listagem de categorias</p>
        <p><i class="fas fa-chart-bar"></i>: Graficos de dados do sistema</p>
        <p><i class="fas fa-cog"></i>: Configuracoes do sistema</p>
        <p><i class="fas fa-user-circle"></i>: Perfil</p>
        <p><i class="fas fa-sign-out-alt"></i>: Logout</p>
        <div class="alert alert-danger">Existem restricoes para admins removerem contas e lancamentos dos usuarios (habilidar/desabilitar na pagina <a href='settings' class='link-danger'><i class="fas fa-cog"></i>settings</a>).</div>
      </div>
    </div>
  </div>
</div>
