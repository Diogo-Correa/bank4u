<%-- 
    Document   : index
    Created on : 29/12/2021, 21:39:02
    Author     : Diogo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color: #efefef !important;">
    <head>
        <jsp:include page="../../assets/includes/head.html" />
        <title>4U - Charts</title>
    </head>
    <body style="background-color: #efefef !important;" class="text-dark">
        
        <jsp:include page="../../assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="../../assets/components/header/header.jsp" />
        
        
        
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="card text-dark border-0 mb-3 bg-body rounded shadow-sm">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-crown"></i>
                                Usuarios
                                <span class="badge bg-danger">${adminsCount + usersCount}</span>
                            </h5>
                        </div>
                        <div class="card-body">
                            <canvas id="usersBar" width="50" height="50"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card text-dark border-0 mb-3 bg-body rounded shadow-sm">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-crown"></i>
                                Usuarios suspensos
                            </h5>
                        </div>
                        <div class="card-body">
                            <canvas id="suspendUsers" width="50" height="50"></canvas>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
         
        
        
        <jsp:include page="../../assets/components/modal/novoUser.html" />
        <jsp:include page="../../assets/components/modal/novaCategoria.html" />
        
        <jsp:include page="../../assets/components/modal/confirmaAction.html" />
        
        <jsp:include page="../../assets/includes/scripts.html" />
        
        <script>
        const usersBar = document.getElementById('usersBar');
        const suspendUsers = document.getElementById('suspendUsers');
        
        const myChart = new Chart(usersBar, {
            type: 'bar',
            data: {
                labels: ['Admin', 'Usuario'],
                datasets: [{
                    label: 'Total',
                    data: [`${adminsCount}`, `${usersCount}`],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
        
        const suspendUsersPie = new Chart(suspendUsers, {
            type: 'pie',
            data: {
                labels: ['Suspensos', 'Ativos'],
                datasets: [{
                    data: [`${usersSuspendCount}`, `${usersCount - usersSuspendCount}`],
                    backgroundColor: [
                        'rgba(0, 0, 0, 0.2)',
                        'rgba(54, 162, 235, 0.2)'
                    ],
                    borderColor: [
                        'rgba(0, 0, 0, 1)',
                        'rgba(54, 162, 235, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
        </script>  
    </body>
</html>