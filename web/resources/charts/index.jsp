<%-- 
    Document   : index
    Created on : 29/12/2021, 21:39:02
    Author     : Diogo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ${applicationDarkTheme ? '' : 'style="background-color: #efefef !important;"'}>
    <head>
        <jsp:include page="../../assets/includes/head.html" />
        <title>4U - Charts</title>
    </head>
    <body ${applicationDarkTheme ? '' : 'style="background-color: #efefef !important;" class="text-dark"'}>
        
        <jsp:include page="../../assets/components/modal/alertMsgs.jsp" />
        
        <jsp:include page="../../assets/components/header/header.jsp" />
        
        <div class="container">
            
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb ${applicationDarkTheme ? 'bg-dark' : 'bg-white'} p-3 rounded shadow-sm">
                    <li class="breadcrumb-item"><a href="home"><i class="fas fa-th-large"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Charts</li>
                </ol>
            </nav>
            
            <div class="row">
                <div class="col-lg-6">
                    <div class="card text-dark border-0 mb-3 ${applicationDarkTheme ? 'bg-dark' : 'bg-white text-dark'} rounded shadow-sm">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-crown"></i>
                                Usuarios
                            </h5>
                        </div>
                        <div class="card-body">
                            <canvas id="usersBar" height="250"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card text-dark border-0 mb-3 ${applicationDarkTheme ? 'bg-dark' : 'bg-white text-dark'} rounded shadow-sm">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-crown"></i>
                                Usuarios suspensos
                            </h5>
                        </div>
                        <div class="card-body">
                            <canvas id="suspendUsers" height="250"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card text-dark border-0 mb-3 ${applicationDarkTheme ? 'bg-dark' : 'bg-white text-dark'} rounded shadow-sm">
                        <div class="card-header bg-dark">
                            <h5 class="card-title text-light py-2">
                                <i class="fas fa-wallet"></i>
                                Contas
                            </h5>
                        </div>
                        <div class="card-body">
                            <canvas id="contas" height="250"></canvas>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
         
        
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
                        'rgba(255, 99, 132, 0.6)',
                        'rgba(54, 162, 235, 0.6)'
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
                },
                responsive: true,
                maintainAspectRatio: false
            }
        });
        
        const suspendUsersPie = new Chart(suspendUsers, {
            type: 'pie',
            data: {
                labels: ['Suspensos', 'Ativos'],
                datasets: [{
                    data: [`${usersSuspendCount}`, `${usersCount - usersSuspendCount}`],
                    backgroundColor: [
                        'rgba(0, 0, 0, 0.6)',
                        'rgba(54, 162, 235, 0.6)'
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
                },
                responsive: true,
                maintainAspectRatio: false
            }
        });
        
        const contasPie = new Chart(contas, {
            type: 'pie',
            data: {
                labels: ['Itau', 'BB'],
                datasets: [{
                    data: [`${itauCount}`, `${bbCount}`],
                    backgroundColor: [
                        'rgba(235, 128, 52, 0.6)',
                        'rgba(232, 235, 52, 0.6)'
                    ],
                    borderColor: [
                        'rgba(235, 128, 52, 1)',
                        'rgba(232, 235, 52, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                responsive: true,
                maintainAspectRatio: false
            }
        });
        </script>  
    </body>
</html>
