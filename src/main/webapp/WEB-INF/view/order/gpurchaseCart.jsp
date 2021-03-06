<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/util.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
<div class="section-title">
	<div class="container">
		<h2>공동구매 장바구니</h2>
	</div>
</div>
	<div class="sideContainer d-md-flex align-items-stretch">
		<div id="content" class="p-4 p-md-5 pt-5">
				<table class="table table-striped">
				<thead>
					<tr>
						<th><input type="checkbox" id="checkAll" class="check" /></th>
						<th>Product</th>
						<th>Price</th>
						<th>Quantity</th>
						<th>Total</th>
						<th>&nbsp;</th>
						<th>&nbsp;</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="gpurchaseCart" items="${gpurchaseCartList}">
						<tr>
							<td><input type="checkbox" id="box" name ="box" class="check" value="${gpurchaseCart.gpurchase.boardNum}"/></td>
							<td ><a href="<c:url value="/gpurchase/${gpurchaseCart.boardNum}"></c:url>">
										<img src="${pageContext.request.contextPath}/resources/img/dog-food.png" border="0"> &nbsp;
										${gpurchaseCart.gpurchase.boardTitle}</a></td>
							<td>${gpurchaseCart.gpurchase.price}</td>
							<td>1</td>
							<td>${gpurchaseCart.gpurchase.price}</td>
							<td><input type="hidden" name="price" value="${gpurchaseCart.gpurchase.price}" /></td>
							<td><input type="submit" class = "btn" value="x" onclick="del(${gpurchaseCart.gpurchase.boardNum})" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<hr class="dashed">
	
			<table class="text-right" align="right">
				<tr>
					<td>총상품금액</td>
					<td>&nbsp;</td>
					<td id="totalPrice">0₩</td>
				</tr>
				<tr>
					<td>배송비</td>
					<td>&nbsp;</td>
					<td>2500₩</td>
				</tr>
				<tr>
					<td>결제예상금액</td>
					<td>&nbsp;</td>
					<td id="expectPrice">2500₩</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><button type="button" id="btnOrder" name ="btnOrder" class="btn">order</button></td>
				</tr>
			</table>
		
		</div>

		<nav id="sidebar">
			<div class="p-4 pt-5">
				<!-- <span style="color:black"><h5>Categories</h5></span> -->
				<ul class="list-unstyled components mb-5">
					<li><a href="#" data-toggle="modal" data-target="#myModal">회원 정보 수정</a></li>
 					<li>
			            <a href="#pageSubmenu2" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">내가 쓴 글</a>
			            <ul class="collapse list-unstyled" id="pageSubmenu2">
			                <li><a href="mypage-info"><span class="fa fa-chevron-right mr-2"></span>정보 게시판</a></li>
			                <li><a href="mypage-inquiry"><span class="fa fa-chevron-right mr-2"></span>질문 게시판</a></li>
			                <li><a href="mypage-gpurchase"><span class="fa fa-chevron-right mr-2"></span>공구 게시판</a></li>
			                <li><a href="mypage-secondhand"><span class="fa fa-chevron-right mr-2"></span>중고 게시판</a></li>
							<c:if test="${petsitterChk == 0}">
								<li><a href="mypage-petsitter"><span class="fa fa-chevron-right mr-2"></span>매칭 게시판</a></li>
							</c:if>
							<c:if test="${petsitterChk == 1}">
								<li><a href="mypage-review"><span class="fa fa-chevron-right mr-2"></span>리뷰 게시판</a></li>
							</c:if>
			            </ul>
	          		</li>
	          		<li>
			            <a href="#pageSubmenu3" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">내가 쓴 댓글</a>
			            <ul class="collapse list-unstyled" id="pageSubmenu3">
			                <li><a href="myreply-info"><span class="fa fa-chevron-right mr-2"></span>정보 게시판</a></li>
			                <li><a href="myreply-inquiry"><span class="fa fa-chevron-right mr-2"></span>질문 게시판</a></li>
			                <li><a href="myreply-gpurchase"><span class="fa fa-chevron-right mr-2"></span>공구 게시판</a></li>
			                <li><a href="myreply-secondhand"><span class="fa fa-chevron-right mr-2"></span>중고 게시판</a></li>
			                <li><a href="myreply-petsitter"><span class="fa fa-chevron-right mr-2"></span>매칭 게시판</a></li>
			                <li><a href="myReply-review"><span class="fa fa-chevron-right mr-2"></span>리뷰 게시판</a></li>
			            </ul>
	          		</li>
	          		<li>
			            <a href="#pageSubmenu4" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">북마크</a>
			            <ul class="collapse list-unstyled" id="pageSubmenu4">
			                <li><a href="mylike-info"><span class="fa fa-chevron-right mr-2"></span>정보 게시판</a></li>
			                <li><a href="mylike-inquiry"><span class="fa fa-chevron-right mr-2"></span>질문 게시판</a></li>
			                <li><a href="mylike-review"><span class="fa fa-chevron-right mr-2"></span>리뷰 게시판</a></li>
			                <li><a href="mylike-petsitter"><span class="fa fa-chevron-right mr-2"></span>매칭 게시판</a></li>
			            </ul>
	          		</li>
	          		<li>
			            <a href="#pageSubmenu5" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">장바구니</a>
			            <ul class="collapse list-unstyled" id="pageSubmenu5">
			                <li><a href="gpurchase-cart"><span class="fa fa-chevron-right mr-2"></span>공구 게시판</a></li>
			                <li><a href="secondhand-cart"><span class="fa fa-chevron-right mr-2"></span>중고 게시판</a></li>
			            </ul>
	          		</li>
	          		<li><a href="myorder">내 주문 내역</a></li>
				</ul>
			</div>
		</nav>
	</div>
	
<!-- Modal HTML -->
<div id="myModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">				
				<h4 class="modal-title">비밀번호 확인</h4>
			</div>
			<div class="modal-body">
				<form method="post"
				class="login100-form validate-form flex-sb flex-w">
					<!-- <span class="login100-form-title p-b-32"> Account Login </span>  -->
					<span class="txt1 p-b-11"> 
						비밀번호 
					</span>
					<div class="wrap-input100 validate-input m-b-36">
						<input type="password" id="pwd" name="pwd" class="input100"/>
						<span class="focus-input100"></span>
					</div>
					<span class="txt1 p-b-11"> 
						비밀번호 확인
					</span>
					<div class="wrap-input100 validate-input m-b-36">
						<input type="password" id="confirmPwd" name="confirmPwd" class="input100"/>
						<span class="focus-input100"></span>
					</div>
					<div class="container-login100-form-btn">
						<button type="submit" value="확인"
								class="login100-form-btn" id="btnConfirm" name="btnConfirm">확인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>  
<script>
	$(document).on('click', '#btnConfirm', function(e){
		var pass1 = $("#pwd").val();
		var pass2 = $("#confirmPwd").val();
		if (pass1 == "" || pass2 == "") {
			alert("비밀번호를 입력하세요.");
			$("#pwd").focus();
			return false;
		}
		if(pass1 != pass2) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#confirmPwd").focus();
			return false;
		}
		$.ajax({
	        url : '${pageContext.request.contextPath}/confirm/'+confirmPwd,
	        type : 'post',
	        data : {'confirmPwd' : pass2},
	        success : function(data){
	        	if (data == 1) {
	        		location.href="${pageContext.request.contextPath}/sign-up";
	        	}
	        	else {
	        		alert('비밀번호가 틀렸습니다.');
	        		return false;
		        }
	        }
	    });
	});

	$(document).on("click","#btnOrder", function() {
	  	var checkArr = new Array();     // 배열 초기화
	  	var price = 0;
	    $('#box:checked').each(function(i){
	        checkArr.push($(this).val());  // 체크된 것만 값을 뽑아서 배열에 push
	    });

	    if(checkArr == "" || checkArr == null || checkArr == undefined || (checkArr != null && typeof checkArr == "object" && !Object.keys(checkArr).length)){
		   alert("담은 상품이 없습니다.");
		   return;
		}
		
	    price = $("#expectPrice").val();
	    
	    $.ajax({
	        url: '${pageContext.request.contextPath}/gpurchase-cart/order',
	        type: 'post',
	        data: { gpurchaseCartList : checkArr, price : price },
	    	success : function(result) {
				alert(result);
				location.href = "${pageContext.request.contextPath}/gpurchase/order";
			}
	    });
	});
	
	   $(document).ready(function() {

		 //체크 박스 모두 선택
		$("#checkAll").change(function () {
		    $('.check').prop("checked", $(this).prop("checked"));
		});  
		
		 //체크 박스 선택 시 가격 변경
		$(".check").change(function() {
			var html = 0;
			var html2 = 0;
			for (var i = 1; i < $('table tr').size(); i++) {
				var fabric_seq = 0;
				// table 중 tr이 i번째 있는 자식중에 체크박스가 체크중이면
				var chk = $('table tr').eq(i).children().find('input[type="checkbox"]').is(':checked');

				if (chk == true) { // 그 i 번째 input text의 값을 가져온다.
					fabric_seq = parseInt($('table tr').eq(i).find('input[name=price]').val());
				}
					html += fabric_seq;
					html2 = html + 2500;
					$("#expectPrice").val(html2);
					$("#totalPrice").html(html + '₩');
					$("#expectPrice").html(html2 + '₩');
				}
		  });

		 
	 });
/* 
	function del(boardNum) {
		var chk = confirm("해당 상품을 삭제하시겠습니까?");
		if (chk) {
			location.href='gpurchase-cart/'+boardNum;
		}
	} */

	function del(boardNum) {
		var chk = confirm("해당 상품을 삭제하시겠습니까?");
		if (chk) {
			$.ajax({
				url : '${pageContext.request.contextPath}/gpurchase-cart/'+boardNum,
				type : 'delete',
				dataType : 'text',
				success : function(data) {
					if (data == "success") {
						location.href = "${pageContext.request.contextPath}/gpurchase-cart";
					}
				},
				error: function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
		}
	} 
</script>