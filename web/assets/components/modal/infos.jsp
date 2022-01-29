<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="modal text-dark modal-dialog-scrollable" tabindex="-1" id="infosModal">
  <div class="modal-dialog">
    <div class="modal-content ${applicationDarkTheme ? 'bg-dark' : 'bg-white text-dark'}">
      <div class="modal-header" ${applicationDarkTheme ? 'style="border-color: #1d2024 !important;"' : ''}>
        <h5 class="modal-title">Infos</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <h3>Sobre:</h3>
        <p>Projeto do curso de Sistemas de Informacao (UFF).</p>
        <p>DESENVOLVIMENTO WEB - prof. Leonardo Cruz da Costa.</p>
        <p>Forntend e backend: <a href="https://github.com/Diogo-Correa" target="_blank"><i class="fab fa-github"></i>Diogo Correa</a></p>
        <p>Projeto: <a href="https://github.com/Diogo-Correa/bank4u" target="_blank"><i class="fab fa-github"></i>Bank4u</a></p>
        <p class="alert bg-danger">O formulario de login so abre por completo apos o preenchimento de um CPF valido por parte do usuario!</p>
        <p class="alert bg-danger">Todos os formularios que houverem campos de CPF, so poderao ser enviados apos o preenchimento de um CPF valido!</p>
      </div>
    </div>
  </div>
</div>