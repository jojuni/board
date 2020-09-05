<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="WCApp">

<head>
    <!-- Required meta tags-->
    <!--  -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Colorlib Templates">
    <meta name="author" content="Colorlib">
    <meta name="keywords" content="Colorlib Templates">

    <!-- Title Page-->
    <title>Board</title>

    <!-- Icons font CSS-->
    <link href="/vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="/vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Vendor CSS-->
    <link href="/vendor/select2/select2.min.css" rel="stylesheet" media="all">
    <link href="/vendor/datepicker/daterangepicker.css" rel="stylesheet" media="all">

    <!-- Main CSS-->
    <link href="/css/main.css" rel="stylesheet" media="all">
    <!-- Jquery JS-->
    <script src="/vendor/jquery/jquery.min.js"></script>
    <!-- Vendor JS-->
    <script src="/vendor/select2/select2.min.js"></script>
    <script src="/vendor/datepicker/moment.min.js"></script>
    <script src="/vendor/datepicker/daterangepicker.js"></script>
    <script src="/js/common.js"></script>
    <!-- Main JS-->
    <script src="/js/global.js"></script> 		
    <script src="/js/angular_1.6.9.min.js"></script>
</head>

<body ng-controller="mainCtrl" ng-init="init()">
    <div class="page-wrapper bg-gra-01 p-t-150 p-b-100 font-poppins">
        <div class="wrapper wrapper--w780">
            <div class="card card-3">
                <div class="card-heading"></div>
                <div class="card-body">
                    <div style="display: flex;">
                         <h2 class="title">Board</h2> <span><a href="/board/signup.do">Sign up</a></span>
                    </div>
                    <div ng-show="${empty userInfo  }">
	                    <div id="form">
	                        <div class="input-group">
	                            <input class="input--style-3" type="text" placeholder="ID" name="USER_ID" id="USER_ID">
	                        </div>
	                        <div class="input-group">
	                            <input class="input--style-3" type="password" placeholder="password" name="USER_PW" id="USER_PW">
	                        </div>
	                        <div id="comment" style="display: none;margin-top: -12px;height:33px;"></div>
	                        <div class="p-t-10">
	                            <button class="btn btn--pill btn--green" type="button" ng-click="login()">Login</button>
	                        </div>
	                    </div>
                    </div>
                    <div ng-show="${not empty userInfo}">
	                    <div>
	                        <div class="input-group">
	                        	ID : ${userInfo.USER_ID }
	                        </div>
	                        <div class="input-group">
	                            NAME : ${userInfo.USER_NAME }
	                        </div>
	                    </div>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
    <script>    
        "use strict";
        var mainApp = window.mainApp || (window.mainApp = angular.module("WCApp", []));
        mainApp.controller("mainCtrl", function($scope){
            $scope.init = function(){
                $scope.loginForm = {};    
                $scope.setEvent();
            };
            $scope.setEvent = function(){
                $("#USER_ID").on('focus', function(){
                   $(this).css('border', '0');
                   $("#comment").hide();
                });
                $("#PASSWORD").on('focus', function(){
                   $(this).css('border', '0');
                   $("#comment").hide();
                });
            };
            $scope.login = function(){
                $scope.loginForm = {
                    USER_ID : $("#USER_ID").val() || '',
                    USER_PW : $("#USER_PW").val() || ''
                }
                if(checkValidation($scope.loginForm)) {
                    for(let key in $scope.loginForm) {
                        if ($scope.loginForm[key] == ''){
                            $("#" + key).css('border', '1px solid red');
                        } else {
                            $("#" + key).css('border', '0');
                        }
                    }
                    return false;
                }   
                
                $.ajax({
                    type: "post",
                    url: "/board/loginUser.json",
                    contentType: "application/json; charset=utf-8",
                    data : JSON.stringify($scope.loginForm),
                    success : function(data){
                        if (data.msg == "OK"){
                           location.href = '/board/main.do';
                       }
                     
                    }
                    , error : function(data){
                    	console.log(data);
                    }
                });
            };
          
        });
    </script>
</body><!-- This templates was made by Colorlib (https://colorlib.com) -->

</html>
<!-- end document-->