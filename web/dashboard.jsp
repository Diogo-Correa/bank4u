<%-- 
    Document   : dashboard
    Created on : 16/11/2021, 23:27:43
    Author     : Diogo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="app.Usuario"%>
<!DOCTYPE html>
<html style="background-color: #efefef !important;">
    <head>
        <jsp:include page="./assets/includes/head.html" />
        <title>4U - Dashboard</title>
    </head>
    <body style="background-color: #efefef !important;" class="text-dark">
        
        <jsp:include page="./assets/components/modal/alertMsgs.jsp" />
        
        <%
            Usuario user = (Usuario) request.getSession().getAttribute("authUser");  
        %>
        <jsp:include page="./assets/components/header/header.jsp" />
        
        <div class="container">
            <button type="button" class="float" title="Novo lancamento" data-bs-toggle="modal" data-bs-target="#novoLancamento">
                <i class="fa fa-plus my-float"></i>
            </button>
            
            <div class="alert alert-info">
                <i class="fas fa-wallet me-2"></i>
                Ola <%= user.getNome() %>, parece que voce ainda nao tem uma conta cadastrada, clique <a class="alert-link" href=""  data-bs-toggle="modal" data-bs-target="#novaConta">aqui</a> para cadastrar uma.
            </div>
            
            <div class="row">
                <div class="col-lg-9">
                    <div class="card text-dark border-0 mb-3">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-money-check-alt"></i>
                                Extrato
                            </h5>
                        </div>
                        <div class="card-body">
                            <div id="calendar"></div>
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
                            asd
                        </div>
                    </div>
                </div>
            </div> 
        </div>
        
        <jsp:include page="./assets/components/modal/novoLancamento.html" />
        <jsp:include page="./assets/components/modal/novaConta.html" />
        
        
        <jsp:include page="./assets/includes/scripts.html" />
        
        <script>

        document.addEventListener('DOMContentLoaded', function() {
          var calendarEl = document.getElementById('calendar');
          var calendar = new FullCalendar.Calendar(calendarEl, {
            locale: 'pt-br',
            initialView: 'listMonth',
            events: [
            { // this object will be "parsed" into an Event Object
              title: 'Salario', // a property!
              start: '2021-11-01', // a property!
              end: '2021-11-01' // a property! ** see important note below about 'end' **
            },
            { // this object will be "parsed" into an Event Object
              title: 'Salario', // a property!
              start: '2021-12-01', // a property!
              end: '2021-12-01' // a property! ** see important note below about 'end' **
            },
            { // this object will be "parsed" into an Event Object
              title: 'Deposito', // a property!
              start: '2021-12-01', // a property!
              end: '2021-12-01' // a property! ** see important note below about 'end' **
            },
            { // this object will be "parsed" into an Event Object
              title: 'Transferencia', // a property!
              start: '2021-12-30', // a property!
              end: '2021-12-30' // a property! ** see important note below about 'end' **
            },
            { // this object will be "parsed" into an Event Object
              title: 'Saque', // a property!
              start: '2021-12-31', // a property!
              end: '2021-12-31' // a property! ** see important note below about 'end' **
            }
          ]
          });
          calendar.render();
        });

      </script>
    </body>
</html>
