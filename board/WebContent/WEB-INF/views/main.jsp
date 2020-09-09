<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html ng-app="WCApp">

<head>
    <meta charset="UTF-8">
    <title>Board</title>
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

<body ng-controller="mainCtrl" ng-init="init('${userInfo.USER_ID}')">
    <div class="ui middle aligned center aligned grid">
        <div class="column">
            <h2 class="ui teal image header"  style="color: #4dae3c;">
                Board
            </h2>
            <div style="color: white;float: right;">${userInfo.USER_ID}님 안녕하세요
            <br>
            <a ng-click="logout()" style="color: white;float: right;">logout</a>
             </div>
            
            <div class="ui large form">
                <div class="ui stacked segment">
                    <a href="/board/writeForm.do"><button class="ui fluid large teal submit button" style="backgroud: #4dae3c;">게시글 작성하기</button></a>
                <div class="list_type1">
					<div class="count">
						<div style="float: left;">총 <span>{{ data.totalCount | number }}</span> 건</div>
					</div>
					 <table class="ui celled table" style="position: relative;top: 10px;">
                        <thead>
                            <tr>
                            	<th>번호</th>
                                <th>제목</th>
                                <th>등록자</th>
                                <th>등록일</th>
                                <th>#</th>
                            </tr>
                        </thead>
                        <tbody id="list">
                        	<tr data-ng-repeat="row in data.list">
                        		<td ng-click="getBoard()">{{row.no}}</td>
	                    		<td ng-click="getBoard()">{{row.title}}</td>
	                    		<td ng-click="getBoard()">{{row.writer}}</td>
	                    		<td ng-click="getBoard()">{{row.regDate}}</td>
	                    		<td>
	                    			<div class="actions" ng-if="row.modify" ng-click="deleteBoard()">
							            <div class="ui black deny button">
							           		삭제
							            </div>
							        </div>
        						</td>
	                    	</tr>
                        </tbody>
                    </table>
				</div>
				</div>
				
                <div class="ui error message"></div>
            </div>
        </div>
    </div>

    <div class="ui modal" id='view_modal'>
        <div class="header">
            <span id="title">{{info.title}}</span>
        </div>
        <div class="content">
            <div class="description">
            	<p style = "text-align: right" id = "b_review"></p>
            	<div id = 'content'>{{info.contents}}</div>
            </div>
        </div>
        <div class="actions">
        	<div class="ui black deny button" style='background: blueviolet;'" ng-if="info.modify" ng-click="updateBoard()">
           		수정
            </div>
        	<div class="ui black deny button"  ng-click="close()">
           		닫기
            </div>
            
        </div>
    </div>

    <!-- js 가져오기 -->
    <script src="/vendor/jquery/jquery.min.js"></script>
    <script src="/js/semantic.min.js"></script>
    <script src="/js/angular_1.6.9.min.js"></script>
    <script src="/js/jquery.bpopup.min.js"></script>
    
	 <script>    
		$(document).keyup(function(e) {	// esc키로도 팝업창을 닫을 수 있어서 esc키 감지 하는 기능 추가
		     if (e.keyCode == 27) { // escape key maps to keycode `27`
		    	 closePop();
		    }
		});
		
		// 수정모드일 때, esc키나 닫기버튼으로 팝업창 닫으면 수정을 위해 추가된 input이나 textarea삭제하고 기존에 보이던 제목과 내용이 보이도록 수정 
		function closePop(){
			document.getElementById('title').removeAttribute('class');
   			$("#u_title").remove();
   			
   			document.getElementById('content').removeAttribute('class');
			$("#u_contents").remove();
		}
	 
        "use strict";
        var mainApp = window.mainApp || (window.mainApp = angular.module("WCApp", []));
        mainApp.controller("mainCtrl", function($scope){
            $scope.init = function(id){
            	$scope.data = {
            		totalCount : 0,	
            		list : [],
            		userId: id
            	};
            	$scope.setEvent();
            	$scope.info = {
            		title : "",
            		contents : "",
            		writer : ""
            	}
            	$scope.getBoardList();
            	$scope.setEvent();
            };
            
            $scope.setEvent = function() {
           		$("#title").unbind('dblclick').dblclick(function(){
               		if ($scope.info && $scope.info.writer == '${userInfo.USER_ID}') {
               			document.getElementById('title').setAttribute('class','ng-hide');		// 기존 제목 보이는 부분 숨김처리
               			$("#title").before("<input type='text' name='u_title' id='u_title'/>");	// 기존 제목 보이는 부분 대신 새로 입력하는 창 생성
               			
               		}		
               	});	
   				$("#content").unbind('dblclick').dblclick(function(){
   					if ($scope.info && $scope.info.writer == '${userInfo.USER_ID}') {
   						document.getElementById('content').setAttribute('class','ng-hide');		// 기존 내용 보이는 부분 숨김처리
   						$("#content").before("<textarea name='u_contents' id='u_contents'></textarea>");	// 기존 내용 보이는 부분 대신 새로 입력하는 창 생성
   					}
               	});	
   				
            }
            
            $scope.getBoardList = function() {
            	$.ajax({
                    type: "post",
                    url: "/board/getBoardList.json",
                    contentType: "application/json; charset=utf-8",
                    data: {},
                    success : function(data){
                       if (data.msg == "OK"){
                    	  $scope.data.totalCount = data.list.length || 0;
                    	  if (data.list) {
                    		  for(var i = 0; i < data.list.length ; i++) {
                         		 if (data.list[i].writer == $scope.data.userId) {
                         			 data.list[i].modify = true;
                         		 } 
                         	  }	  
                    	  }
                    	  $scope.data.list = data.list;
                          $scope.$apply();
                       }
                    }
                });
            }
            
            $scope.getBoard = function() {
            	var no = 0;
            	no = $scope.data.list[this.$index].no;
            	$scope.info = null;
            	$.ajax({
                    type: "post",
                    url: "/board/getBoard.json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(no),
                    success : function(data){
                       if (data.msg == "OK"){
                    	  if (data.info.writer ==  $scope.data.userId) {
                    		  data.info.modify = true
                    	  } 
                    	  $scope.info = data.info || [];
                    	  $('#view_modal').bPopup({
							  modalClose:false
						  });
                    	  $scope.$apply();
                       }
                    }
                });
            }
            
            $scope.close = function(){
            	closePop();							// 팝업창 닫을 때 수정상태 였을 때 원복시키기 위한 부분 함수로 뻄
       			
        		$('#view_modal').bPopup().close();
            }
            
            $scope.deleteBoard = function() {
            	var no = $scope.data.list[this.$index].no;
            	$.ajax({
                    type: "post",
                    url: "/board/deleteBoard.json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(no),
                    success : function(data){
                       if (data.msg == "OK"){
                    	  $scope.getBoardList();
                       }else {
                    	   alert("삭제 실패");
                       }
                    }
                });
            }
            
            $scope.updateBoard = function(){
            	var info = $scope.info;
            	
            	var u_info = {};
            	for(var key in info) {
            		var data = info[key];
            		key = key.toUpperCase();
            		u_info[key] = data;
            	}
            	
            	$.extend(u_info, {TITLE : $("#u_title").val(), CONTENTS : $("#u_contents").val()});
            	
            	$.ajax({
                    type: "post",
                    url: "/board/updateBoard.json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(u_info),
                    success : function(data){
                       if (data.msg == "OK"){
                    	  $scope.close();
                    	  location.reload();
                       }else {
                    	   alert("수정 실패");
                       }
                    }
                });
            }
            
            
            $scope.logout = function(){
            	 
                $.ajax({
                    type: "get",
                    url: "/board/logout.json",
                    contentType: "application/json; charset=utf-8",
                    data : null,
                    success : function(data){
                    	
                        if (data.msg == "OK"){
                            location.href = '/';	
                       }
                    }
                    , error : function(data){
                    	console.log("456789");
                    	console.log(data);
                    }
                });
            }
          
        });
    </script>
</body>

</html>

