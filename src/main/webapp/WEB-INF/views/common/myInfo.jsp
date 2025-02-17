<%@ page language="java" 
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${title}</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    #infoForm {
        background-color: #00D7FF;
        background-size: cover;
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
    }
    form {
        width: 450px;
        border-radius: 10px;
        background: rgba(0, 0, 0, 0.7);
        margin-left: auto;
        margin-right: auto;
        margin-top: 50px;
        padding: 30px;
    }
    form h2 {
        color: #fff;
        text-align: center;
    }
    form input {
        display: black;
        width: 100%;
    }
    form label {
        color: #fff;
    }
    form input {
        background-color: transparent;
        border: 0;
        border-bottom: 2px solid #fff;
        padding: 10px 5px;
        margin-top: 10px;
        margin-bottom: 10px;
    }
    form button {
        display: block;
        width: 100%;
        background-color: blueviolet;
        color: #fff;
        border-radius: 20px;
        padding: 10px;
        border: 0;
        margin-bottom: 10px;
    }    
    #userID, #password, #password2, #username, #email, #phone {
        color: #fff;
    }
    #error-message {
        color: red; /* 오류 메시지 색상 */
        text-align: left; /* 왼쪽 정렬 */
        margin-top: 10px; /* 위쪽 여백 */
        display: none; /* 처음에는 숨김 */
		font-weight: bold;
    }
</style>
</head>
<body>
    
    <form id="infoForm" method="post" action="/member/updateInfo">
        <h2 class="">회원정보 수정</h2>
        <input type="hidden" id="idx" name="idx" value='<c:out value="${userInfo.getIdx()}" />' readonly />
        <div>
            <label for="userID">아이디<label>
            <input type="text" id="userID" name="userID" value='<c:out value="${userInfo.getUserID()}" />' readonly />
        </div>
        <div>
            <label for="password">비밀번호<label>
            <input type="password" id="password" name="password" value='' />
        </div>
        <div>
            <label for="password2">비밀번호 확인<label>
            <input type="password" id="password2" name="password2" value='' />
        </div>
        <div>
            <label for="username">이름<label>
            <input type="text" id="username" name="username" value='' />
        </div>
        <div>
            <label for="phone">휴대폰 번호<label>
            <input type="text" id="phonnumber" name="phonnumber" value='' />
        </div>
        <div>
            <label for="email">이메일<label>
            <input type="text" id="email" name="email" value='' />
        </div>
		<!-- 오류 메시지를 표시할 요소 추가 -->
        <div id="error-message"></div>
        <button type="button" id="btnConfirm">확인</button>
        <button type="button" id="btnDelete">회원 탈퇴</button>

        
    </form>

    <script>
        document.querySelector('#btnConfirm').addEventListener('click', function(e){
            e.preventDefault();
            
            const userID = document.querySelector('#userID').value?.trim();
            const email = document.querySelector('#email').value?.trim();
            const username = document.querySelector('#username').value?.trim();
            const password = document.querySelector('#password').value?.trim();
            const password2 = document.querySelector('#password2').value?.trim();
            
            const email_regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;

            // 오류 메시지를 표시할 요소
            const errorMessageDiv = document.querySelector('#error-message');
            errorMessageDiv.textContent = ''; // 이전 오류 메시지 초기화
            errorMessageDiv.style.display = 'none'; // 오류 메시지를 숨김

            if (!email_regex.test(email)) { 
                errorMessageDiv.textContent = '이메일 형식을 확인하세요.';
                errorMessageDiv.style.display = 'block'; // 메시지 표시
                return false; 
            }
            if (userID === '') {
                errorMessageDiv.textContent = '아이디가 없습니다.';
                errorMessageDiv.style.display = 'block'; // 메시지 표시
                return false;
            }
            if (username.length < 2) {
                errorMessageDiv.textContent = '이름은 2글자 이상 입력하세요.';
                errorMessageDiv.style.display = 'block'; // 메시지 표시
                return false;
            }
            if (password === '' && password2 !== '') {
                errorMessageDiv.textContent = '비밀번호 변경을 원할 경우 비밀번호와 비밀번호 확인을 모두 입력하세요.';
                errorMessageDiv.style.display = 'block'; // 메시지 표시
                return false;
            }
            if (password !== '' && password2 !== '' && password !== password2) {
                errorMessageDiv.textContent = '비밀번호와 비밀번호 확인 란이 다릅니다.';
                errorMessageDiv.style.display = 'block'; // 메시지 표시
                return false;
            }
			
			 //이메일 중복 체크
	         fetch('/member/checkEmail/' + email)
	              .then((response) => response.json())
	               .then((data) => {
					console.log(data);
	                   if (!data) {
	                       errorMessageDiv.textContent = '이미 사용중인 이메일입니다.';
	                       errorMessageDiv.style.display = 'block'; // 이메일 오류 메시지 표시
	                   } else {
	                       // 이메일이 사용 가능한 경우 폼 제출
	                       document.querySelector('#infoForm').submit();
	                   }
	               });
				  
	       });
	   </script>      
</body>
</html>
