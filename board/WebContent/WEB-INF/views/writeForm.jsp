<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html ng-app="WCApp">

<head>
    <meta charset="UTF-8">
    <title>Board</title>
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
    <link rel="stylesheet" type="text/css" href="/css/semantic.min.css">
    <style type="text/css">
        body {
            background-color: #DADADA;
        }

        body>.grid {
            height: 100%;
        }

        .image {
            margin-top: -100px;
        }

        .column {
            max-width: 1000px;
        }

        .view_btn {
            cursor: pointer;
        }
               
		.ui.grid {
	       background: -webkit-gradient(linear, left bottom, left top, from(#5897fb), to(#a18cd1));
		   background: -webkit-linear-gradient(bottom, #5897fb 0%, #a18cd1 100%);
		   background: -moz-linear-gradient(bottom, #5897fb 0%, #a18cd1 100%);
		   background: -o-linear-gradient(bottom, #5897fb 0%, #a18cd1 100%);
		   background: linear-gradient(to top, #5897fb 0%, #a18cd1 100%);
		}
		
    </style>
    
</head>

<body ng-controller="mainCtrl" ng-init="init()">
    <div class="ui middle aligned center aligned grid">
        <div class="column">
            <h2 class="ui teal image header" style="color: #4dae3c;">
                Board
            </h2>
            <div class="ui large form">
                <div class="ui stacked segment">
                   <div class="input-group">
                    	<div style="margin: 5px;padding: 5px;text-align: left;"  class="input-group">
                    		제목: <input class="input--style-3" type="text" placeholder="제목을 입력하세요." name="TITLE" id="TITLE">
                    	</div>
                    	<div style="margin: 5px;padding: 5px;text-align: left;" class="input-group">
                    		작성자: <input class="input--style-3" type="text" style="background: #A6A6A6;color:white;" name="WRITER" id="WRITER" value="${userInfo.USER_ID}" readonly="readonly" >
                    	</div>
                    	<div  class="input-group" style="margin: 5px;padding: 5px;text-align:left;">
                    	       내용:  <textarea name="CONTENTS" id="CONTENTS"></textarea>
                    	</div>
                    </div>
                    <div class="actions" ng-click="insertBoard()">
			            <div class="ui black deny button">
			           		등록
			            </div>
			        </div>
				</div>
            </div>
        </div>
    </div>

    <!-- js 가져오기 -->
    <script src="/vendor/jquery/jquery.min.js"></script>
    <script src="/js/semantic.min.js"></script>
    <script src="/js/angular_1.6.9.min.js"></script>
    <script src="/js/common.js"></script>
    
	 <script>    
        "use strict";
        var mainApp = window.mainApp || (window.mainApp = angular.module("WCApp", []));
        mainApp.controller("mainCtrl", function($scope){
            $scope.init = function(){
            	$scope.writeForm = {};	
            };
            
            $scope.insertBoard = function() {
            	var no = this.$index + 1;
            	$scope.writeForm = {
           			TITLE : $("#TITLE").val(),
               		WRITER : $("#WRITER").val(),
               		CONTENTS : $("#CONTENTS").val(),	
            	}
            	if (!checkValidation($scope.writeForm)) {
            		$.ajax({
                        type: "post",
                        url: "/board/insertBoard.json",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify($scope.writeForm),
                        success : function(data){
                           if (data.msg == "OK"){
                        	   location.href = "/board/main.do";
                           }else {
                        	   alert("등록 실패");
                           }
                        }
                    });	
            	} else {
            		alert("빈값을 입력하세요");
            	}
            
            }
          
        });
    </script>


  <!--   <script>
    
    	
    	$(document).ready(function() {
            $.ajax({
                type: "get",
                url: "bbs_all",
                success: function(data) {
                    for (var str in data) {
                    	
                    	
                        var tr = $("<tr></tr>").attr("data-id", data[str]['b_no']).appendTo("#list");
                        $("<td></td>").text(data[str]['b_no']).addClass("view_btn").appendTo(tr);
                        $("<td></td>").text(data[str]['b_title']).addClass("view_btn").appendTo(tr);
                        $("<td></td>").text(data[str]['b_ownernick']).addClass("view_btn").appendTo(tr);
                        $("<td></td>").text(FormatToUnixtime(data[str]['b_regdate'])).addClass("view_btn").appendTo(tr);
                    }
                },
                error: function(error) {
                    alert("오류 발생" + error);
                }
            });

            $(document).on("click", ".view_btn", function() {
                var b_no = $(this).parent().attr("data-id");

                $.ajax({
                    type: "get",
                    url: "get_bbs",
                    data: {
                        b_no: b_no
                    },
                    success: function(data) {
                    	console.log(data);
                    	$("#b_title").text(data['b_title']);
                    	$("#b_review").text(data['b_ownernick'] + " - " +  FormatToUnixtime(data['b_regdate']));
                    	$("#b_content").text(data['b_content']);
                    	$('#view_modal').modal('show');
                    },
                    error: function(error) {
                        alert("오류 발생" + error);
                    }
                });
            });

            function FormatToUnixtime(unixtime) {
                var u = new Date(unixtime);
                return u.getUTCFullYear() +
                    '-' + ('0' + u.getUTCMonth()).slice(-2) +
                    '-' + ('0' + u.getUTCDate()).slice(-2) +
                    ' ' + ('0' + u.getUTCHours()).slice(-2) +
                    ':' + ('0' + u.getUTCMinutes()).slice(-2) +
                    ':' + ('0' + u.getUTCSeconds()).slice(-2)
            };
        });

    </script> -->
</body>

</html>

