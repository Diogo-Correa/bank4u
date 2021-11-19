<%-- 
    Document   : dashboard
    Created on : 16/11/2021, 23:27:43
    Author     : Diogo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="./assets/includes/head.html" />
        <title>4U - Dashboard</title>
    </head>
    <body style="background-color: #efefef !important;" class="text-dark">
        <nav class="py-2 bg-light border-bottom">
          <div class="container d-flex flex-wrap">
            <ul class="nav me-auto">
              <li class="nav-item"><a href="#" class="nav-link link-dark px-2 active" aria-current="page"><i class="fas fa-th-large"></i></a></li>
              <li class="nav-item"><a href="#" class="nav-link link-dark px-2"><i class="fas fa-cog"></i></a></li>
            </ul>
            <ul class="nav">
              <li class="nav-item"><a href="#" class="nav-link link-dark px-2"><i class="fas fa-sign-out-alt"></i></a></li>
            </ul>
          </div>
        </nav>

        <header class="py-3 mb-4 border-bottom" style="background-color: white;">
          <div class="container d-flex flex-wrap justify-content-center">
            <a href="/" class="d-flex align-items-center mb-lg-0 me-lg-auto text-dark text-decoration-none">
              <i class="fab fa-btc text-success" style="font-size: 2rem; margin-right: 10px;"></i>
              <span class="fs-4 d-none d-lg-block">4U</span>
            </a>
          </div>
        </header>
        
        <div class="container">
            <button type="button" class="float" title="Novo lancamento" data-bs-toggle="modal" data-bs-target="#novoLancamento">
                <i class="fa fa-plus my-float"></i>
            </button>
            
            <div class="alert alert-info">
                <i class="fas fa-wallet me-2"></i>
                Parece que voce ainda nao tem uma conta cadastrada, clique <a class="alert-link" href=""  data-bs-toggle="modal" data-bs-target="#novaConta">aqui</a> para cadastrar uma.
            </div>
            
            <div class="row">
                <div class="col-lg-9">
                    <div class="card text-dark border-0 mb-2">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-money-check-alt"></i>
                                Extrato
                            </h5>
                        </div>
                        <div class="card-body">
                            asd
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="card text-dark border-0 mb-2">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-money-bill-alt"></i>
                                Saldo
                            </h5>
                        </div>
                        <div class="card-body">
                            asd
                        </div>
                    </div>
                </div>
            </div> 
        </div>
        <div class="modal fade" id="novoLancamento" tabindex="-1" aria-labelledby="ModalNovoLancamento" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen-sm-down">
                <div class="modal-content">
                    <div class="modal-header bg-success text-light">
                      <h5 class="modal-title" id="exampleModalLabel">Novo lancamento</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="" method="" onsubmit="$('.loader').show(); $('.enter_txt').hide();">
                        <div class="mb-3">
                          <label for="conta" class="col-form-label">Contas</label>
                          <select class="form-control" id="conta" name="conta">
                              <option value="">0000/00000-0</option>
                              <option value="">0000/00000-0</option>
                          </select>
                        </div>
                        <div class="mb-3">
                          <label for="categoria" class="col-form-label">Categorias:</label>
                          <select class="form-control" id="categoria" name="id_categoria">
                              <option value="">Transferencia</option>
                              <option value="">Boleto</option>
                          </select>
                        </div>
                        <div class="mb-3">
                          <label for="valor" class="col-form-label">Valor:</label>
                          <input type="number" class="form-control" min="0" max="10000" step="0.1" value="0.00" id="valor" name="valor"/>
                        </div>
                        <div class="mb-3">
                          <label for="operacao" class="col-form-label">Operacao:</label>
                          <select class="form-control" id="operacao" name="operacao">
                              <option value="C">Credito</option>
                              <option value="D">Debito</option>
                          </select>
                        </div>
                        <div class="mb-3">
                          <label for="data" class="col-form-label">Data:</label>
                          <input type="date" class="form-control" id="data" value="data"/>
                        </div>
                        <div class="mb-3">
                          <label for="descricao" class="col-form-label">Descricao:</label>
                          <textarea class="form-control" id="descricao" name="descricao"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
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
        
        
        <div class="modal fade" id="novaConta" tabindex="-1" aria-labelledby="ModalNovaConta" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen-sm-down">
                <div class="modal-content">
                    <div class="modal-header bg-success text-light">
                      <h5 class="modal-title" id="exampleModalLabel">Nova Conta</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="" method="" onsubmit="$('.loader').show(); $('.enter_txt').hide();">
                        <input type="hidden" class="form-control" id="id_usuario" name="id_usuario"/>
                        <div class="mb-3">
                          <label for="nome_conta" class="col-form-label">Nome da conta:</label>
                          <input type="text" class="form-control" id="nome_conta" name="nome_conta"/>
                        </div>
                        <div class="mb-3">
                          <label for="banco" class="col-form-label">Banco:</label>
                          <select class="form-control" id="banco" name="banco">
                              <option value="001">Banco do Brasil</option>
                              <option value="341">Itau</option>
                          </select>
                        </div>
                        <div class="mb-3">
                          <label for="agencia" class="col-form-label">Agencia:</label>
                          <input type="number" class="form-control" min="000001" max="999999" id="agencia" name="agencia"/>
                        </div>
                        <div class="mb-3">
                          <label for="conta_corrente" class="col-form-label">C/C</label>
                          <input type="number" class="form-control" min="000001" max="999999" id="conta_corrente" name="conta_corrente"/>
                        </div>
                    </div>
                    <div class="modal-footer">
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
        
        <jsp:include page="./assets/includes/scripts.html" />
    </body>
</html>
