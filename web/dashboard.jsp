<%-- 
    Document   : dashboard
    Created on : 16/11/2021, 23:27:43
    Author     : Diogo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html style="background-color: #efefef !important;">
    <head>
        <jsp:include page="./assets/includes/head.html" />
        <title>4U - Dashboard</title>
    </head>
    <body style="background-color: #efefef !important;" class="text-dark">
        
        <jsp:include page="./assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="./assets/components/header/header.jsp" />
        
        <div class="container">
            <button type="button" class="float" title="Novo lancamento" data-bs-toggle="modal" data-bs-target="#novoLancamento">
                <i class="fa fa-plus my-float"></i>
            </button>
            
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb bg-white p-3 rounded shadow-sm">
                    <li class="breadcrumb-item active" aria-current="page"><i class="fas fa-home"></i></li>
                </ol>
            </nav>
            
            <div class="row">
                <div class="col-lg-9">
                    <div class="card text-dark border-0 mb-3">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-money-check-alt"></i>
                                Extrato
                            </h5>
                            <select class="form-select bg-dark text-white border-0" id="conta" name="conta">
                                <option value="-1">Selecione uma conta</option>
                                <c:forEach var="c" items="${contas}">
                                <option value="${c.getId()}">${c.getNome()}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="card-body">
                            
                            <p id="msgSelecionar" class="p-5 text-center text-muted">Nenhuma conta selecionada.</p>
                            <div class="pb-3 text-end d-none" id="totais">
                                <span class="text-danger h6 d-block">Total de despesas: <span id='totalDebito'></span></span>
                                <span class="text-success h6">Total de credito: <span id='totalCredito'></span></span>
                            </div>
                            <div id="calendar" class="d-none"></div>
                            
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="card text-dark border-0 mb-3">
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
        <jsp:include page="./assets/components/modal/novaConta.html" />
        
        
        <jsp:include page="./assets/includes/scripts.html" />
        
        <jsp:include page="./assets/components/modal/editarLancamento.jsp" />
        
        <script>
            $(document).on("change", "#conta", function() {
                let contaId = $("#conta").val();
                if(contaId > -1) {
                    $.get('wallet?action=total&conta='+contaId, function(total) {
                        $("#saldo").addClass("h3");
                        $("#saldo").text(total[0]);
                        $("#totalDebito").text(total[1]);
                        $("#totalCredito").text(total[2]);

                        $("#msgSelecionar").addClass('d-none');
                        $("#totais").removeClass('d-none');
                        $("#calendar").removeClass('d-none');

                        var calendarEl = document.getElementById('calendar');
                        var calendar = new FullCalendar.Calendar(calendarEl, {
                            locale: 'pt-br',
                            initialView: 'listMonth',
                            allDayText: "",
                            events: {
                                url: 'wallet?action=lancamentos&conta='+contaId,
                                method: 'GET',
                                extraParams: function(){
                                    return {
                                      valor: valor,
                                      operacao: operacao,
                                      categoria: categoria,
                                      descricao: descricao
                                    }
                                },
                            },
                            eventClick: function (args) {
                                if (args.event.extendedProps.valor < 0) $("#editValor").val(args.event.extendedProps.valor * -1);
                                else $("#editValor").val(args.event.extendedProps.valor);
                                $("#editData").val(args.event.start.toISOString().split('T')[0]);
                                $("#editOperacao").val(args.event.extendedProps.operacao);
                                $("#editCategoria").val(args.event.extendedProps.categoria);
                                $("#editDescricao").val(args.event.extendedProps.descricao);
                                $('#eventModal').modal('show');
                                return false;
                            }
                        });

                        calendar.render();
                    });
                } else {
                        $("#saldo").text("Nenhuma conta selecionada.");
                        $("#saldo").removeClass("h3");
                        $("#msgSelecionar").removeClass('d-none');
                        $("#calendar").addClass('d-none');
                        $("#totais").addClass('d-none');
                        $("#saldo").text("");
                        $("#totalDebito").text("");
                        $("#totalCredito").text("");
                }
            });
        </script>
    </body>
</html>
