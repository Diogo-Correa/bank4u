<%-- 
    Document   : dashboard
    Created on : 16/11/2021, 23:27:43
    Author     : Diogo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html ${applicationDarkTheme ? '' : 'style="background-color: #efefef !important;"'}>
    <head>
        <jsp:include page="./assets/includes/head.html" />
        <title>4U - Dashboard</title>
    </head>
    <body ${applicationDarkTheme ? '' : 'style="background-color: #efefef !important;" class="text-dark"'}>
        
        <jsp:include page="./assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="./assets/components/header/header.jsp" />
        
        <div class="container">
            <button type="button" class="float" title="Novo lancamento" data-bs-toggle="modal" data-bs-target="#novoLancamento">
                <i class="fa fa-plus my-float"></i>
            </button>
            
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb ${applicationDarkTheme ? 'bg-dark' : 'bg-white'} p-3 rounded shadow-sm">
                    <li class="breadcrumb-item active" aria-current="page"><i class="fas fa-home"></i></li>
                </ol>
            </nav>
            
            <div class="row">
                <div class="col-lg-9">
                    <div class="card ${applicationDarkTheme ? 'bg-dark' : 'bg-body text-dark'} border-0 mb-3">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-money-check-alt"></i>
                                Extrato
                            </h5>
                            
                            <div class="input-group">
                                <i class="fas fa-wallet text-white my-2"></i>
                                <select class="form-select bg-dark text-white border-0" id="contaSelect">
                                    <option value="-2">Selecione uma conta</option>
                                    <optgroup label="Adicionar">
                                    <option value="-1"> <i class="fas fa-plus"></i> Nova conta</option>
                                    </optgroup>
                                    <optgroup label="Suas contas">
                                        <c:forEach var="c" items="${contas}">
                                        <option value="${c.getId()}">${c.getNome()}</option>
                                        </c:forEach>
                                    </optgroup>
                                </select>
                            </div>
                        </div>
                        
                        <div class="card-body">
                            
                            <c:if test="${showAlertNegativeAccounts}"> 
                                <p class="alert bg-danger text-light d-none" id="negativeAlert">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    O saldo da sua conta esta negativo.
                                </p>
                            </c:if>
                                
                            <p id="msgSelecionar" class="p-5 text-center text-muted">Nenhuma conta selecionada.</p>
                            
                            <div class="d-flex space-between pb-3 d-none" id="totais">
                                <div id="logo_banco" class="me-3"></div>
                                <div class="my-3">
                                    <span class="text-danger h6 d-block">Total de despesas: <span id='totalDebito'></span></span>
                                    <span class="text-success h6">Total de credito: <span id='totalCredito'></span></span>
                                </div>
                            </div>
                            <div id="calendar" class="d-none"></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="card ${applicationDarkTheme ? 'bg-dark' : 'bg-body text-dark'} border-0 mb-3">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-money-bill-alt"></i>
                                Saldo
                            </h5>
                        </div>
                        <div class="card-body">
                            <div id="saldo" class="text-muted text-center">
                                Nenhuma conta selecionada.
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
        
        <jsp:include page="./assets/components/modal/novoLancamento.jsp" />
        <jsp:include page="./assets/includes/scripts.html" />
        
        <jsp:include page="./assets/components/modal/confirmaAction.html" />
        
        <jsp:include page="./assets/components/modal/editarLancamento.jsp" />
        
        <script>
            $(document).on("change", "#contaSelect", function() {
                let contaId = $("#contaSelect").val();
                
                switch(contaId) {
                    case "-1":
                        $("#saldo").text("Nenhuma conta selecionada.");
                        $("#saldo").removeClass("h3");
                        $("#msgSelecionar").addClass('d-none');
                        $("#calendar").addClass('d-none');
                        $("#totais").addClass('d-none');
                        $("#totalDebito").text("");
                        $("#totalCredito").text("");
                        $("#negativeAlert").addClass("d-none");
                        
                        $("#msgSelecionar").after(
                            `    
                            <form action="wallet?action=store" method="POST" id="formConta" onsubmit="$('.loaderConta').show(); $('.conta_txt').hide();">
                                <div class="mb-3">
                                  <label for="nome_conta" class="col-form-label">Nome da conta:</label>
                                  <input type="text" class="form-control ${applicationDarkTheme ? 'bg-black text-white border-dark' : ''}" id="nome_conta" name="nome_conta" maxlength="20" required/>
                                </div>
                                <div class="mb-3">
                                  <label for="banco" class="col-form-label">Banco:</label>
                                  <select class="form-select ${applicationDarkTheme ? 'bg-black text-white border-dark' : ''}" id="banco" name="banco" required>
                                      <option value="001">Banco do Brasil</option>
                                      <option value="341">Itau</option>
                                  </select>
                                </div>
                                <div class="mb-3">
                                  <label for="agencia" class="col-form-label">Agencia:</label>
                                  <input type="number" class="form-control ${applicationDarkTheme ? 'bg-black text-white border-dark' : ''}" min="000000" max="999999" step="000001" id="agencia" name="agencia" required/>
                                </div>
                                <div class="mb-3">
                                  <label for="conta_corrente" class="col-form-label">C/C</label>
                                  <input type="number" class="form-control ${applicationDarkTheme ? 'bg-black text-white border-dark' : ''}" min="0000" max="9999" step="0001" id="conta_corrente" name="conta_corrente" required/>
                                </div>
                                <div class="mb-3">
                                  <label for="digito" class="col-form-label">Digito</label>
                                  <input type="number" class="form-control ${applicationDarkTheme ? 'bg-black text-white border-dark' : ''}" min="0" max="9" id="digito" name="digito" required/>
                                </div>
                                </div>
                                <button type="submit" class="btn btn-success">
                                    <span class="spinner-border spinner-border-sm loaderConta" role="status" style="display:none;">
                                        <span class="visually-hidden">Loading...</span>
                                    </span>
                                    <span class="conta_txt">
                                        <i class="fas fa-paper-plane"></i>
                                    </span>
                                </button>
                            </form>
                            `
                        );
                        
                        
                        break;
                    case "-2":
                        $("#saldo").text("Nenhuma conta selecionada.");
                        $("#saldo").removeClass("h3");
                        $("#msgSelecionar").removeClass('d-none');
                        $("#calendar").addClass('d-none');
                        $("#totais").addClass('d-none');
                        $("#totalDebito").text("");
                        $("#totalCredito").text("");
                        $("#negativeAlert").addClass("d-none");
                        $("#formConta").remove();
                        break;
                    default:
                        var urlTotal = 'wallet?action=total&conta='+contaId;
                        $.ajax({
                            type:'GET',
                            url: urlTotal,
                            success: function(total) {
                                $("#saldo").addClass("h3");
                                if(total) {
                                    $("#saldo").text("R$ " + total[0]);
                                    $("#totalDebito").text(total[1]);
                                    $("#totalCredito").text(total[2]);

                                    if(total[0] < 0) {
                                        $("#negativeAlert").removeClass("d-none");
                                    } else {
                                        $("#negativeAlert").addClass("d-none");
                                    }


                                    $("#msgSelecionar").addClass('d-none');
                                    $("#totais").removeClass('d-none');
                                    $("#calendar").removeClass('d-none');
                                    $("#formConta").remove();
                                    if(total[3] == "001") $("#logo_banco").html("<img src='./assets/images/bb-logo.png' width='80'>");
                                    else $("#logo_banco").html("<img src='./assets/images/itau-logo.png' width='80'>");

                                    var calendarEl = document.getElementById('calendar');
                                    var calendar = new FullCalendar.Calendar(calendarEl, {
                                        locale: 'pt-br',
                                        initialView: 'listMonth',
                                        allDayText: "",
                                        events: {
                                            url: 'entries?action=lancamentos&conta='+contaId,
                                            method: 'GET',
                                            extraParams: function() {
                                                return {
                                                  valor: valor,
                                                  operacao: operacao,
                                                  categoria: categoria,
                                                  descricao: descricao
                                                };
                                            }
                                        },
                                        eventClick: function (args) {
                                            let urlDelete = "<a class='btn btn-sm btn-danger w-100' id='deleteButton' data-bs-toggle='modal' data-bs-target='#confirmaAction' data-href='entries?action=delete&id="+args.event.id+"' href='#'><i class='fas fa-trash'></i> Excluir</a>";
                                            if (args.event.extendedProps.valor < 0) $("#editValor").val(args.event.extendedProps.valor * -1);
                                            else $("#editValor").val(args.event.extendedProps.valor);
                                            $("#editData").val(args.event.start.toISOString().split('T')[0]);
                                            $("#editOperacao").val(args.event.extendedProps.operacao);
                                            $("#editCategoria").val(args.event.extendedProps.categoria);
                                            $("#editDescricao").val(args.event.extendedProps.descricao);
                                            $("#deleteLink").html(urlDelete);
                                            $("#formEdit").attr("action", "entries?action=update&id="+args.event.id);
                                            $('#eventModal').modal('show');
                                            return false;
                                        }
                                    });

                                    calendar.render();
                                } else {
                                    $("#contaSelect").val("-2");
                                    $("#saldo").text("Nenhuma conta selecionada.");
                                    $("#saldo").removeClass("h3");
                                    $("#msgSelecionar").removeClass('d-none');
                                    $("#calendar").addClass('d-none');
                                    $("#totais").addClass('d-none');
                                    $("#totalDebito").text("");
                                    $("#totalCredito").text("");
                                    $("#negativeAlert").addClass("d-none");
                                    $("#formConta").remove();
                                    sweetAlert("Oops! :(", "Conta nao encontrada", "error");
                                }
                            }, error: function() {
                                sweetAlert("Oops! :(", "O id informado nao eh um inteiro!", "error");
                            }
                        });
                        break;
                    
                }
            });
        </script>
        
        <c:if test="${allowModalInfoOnLogin}">
            <c:if test="${show}">
                <jsp:include page="./assets/components/modal/userInfo.jsp" />
                <script>
                    $("#infosModal").show();
                </script>
            </c:if>
        </c:if>
        <%
            request.getSession().setAttribute("show", false);
        %>
    </body>
</html>
