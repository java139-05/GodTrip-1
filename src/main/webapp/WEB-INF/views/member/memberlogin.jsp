<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ include file="../header.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Noto Sans KR", sans-serif;
}

a {
  text-decoration: none;
  color: black;
}

li {
  list-style: none;
}

.wrap {
  width: 100%;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(0, 0, 0, 0.1);
}

.login {
  width: 30%;
  height: 600px;
  background: white;
  border-radius: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}

h2 {
  color: tomato;
  font-size: 2em;
}
.login_sns {
  padding: 20px;
  display: flex;
}

.login_sns li {
  padding: 0px 15px;
}

.login_sns a {
  width: 50px;
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 10px;
  border-radius: 50px;
  background: white;
  font-size: 20px;
  box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.4), -3px -3px 5px rgba(0, 0, 0, 0.1);
}

.login_id {
  margin-top: 20px;
  width: 80%;
}

.login_id input {
  width: 100%;
  height: 50px;
  border-radius: 30px;
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid lightgray;
  outline: none;
}

.login_pw {
  margin-top: 20px;
  width: 80%;
}

.login_pw input {
  width: 100%;
  height: 50px;
  border-radius: 30px;
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid lightgray;
  outline: none;
}

.login_etc {
  padding: 5px;
  width: 55%;
  font-size: 14px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
}

.submit {
  margin-top: 0px;
  width: 80%;
}
.submit input {
  width: 100%;
  height: 50px;
  border: 0;
  outline: none;
  border-radius: 40px;
  background: linear-gradient(to left, rgb(255, 77, 46), rgb(255, 155, 47));
  color: white;
  font-size: 1.2em;
  letter-spacing: 2px;
}
</style>
</head>
<body>
<!-- 본문 시작 -->



<c:choose>
<c:when test="${ empty s_id  || empty s_passwd || s_mlevel == 'E1' || s_mlevel == 'F1' }"> 	
<c:if test="${not empty Loginmessage}">
        <script>
            alert('${Loginmessage}');
        </script>
    </c:if>
    
<c:if test="${not empty FindIdmessage}">
        <script>
            alert('${FindIdmessage}');
        </script>
    </c:if>    
    

<div class="wrap">
        <div class="login">
            <h2>*로그인*</h2>
            <div class="login_id">
                <form action="login.do" method="post" id="loginfrm" name="loginfrm" onsubmit="return loginCheck()"> 
                <h4>ID</h4>
             <input type="text" name="id" id="id" placeholder="id" maxlength="15" autofocus>
           
            </div>
            <div class="login_pw">
                <h4>Password</h4>
                <input type="password" name="passwd" id="passwd" placeholder="Password" maxlength="15">
            </div>
        

            <div class="login_etc">
                <div class="checkbox">
                <a href="agreement">회원가입</a>
                </div>
              <br>
                <div class="forgot_pw">
                <a href="findId.do">비밀번호/아이디 찾기</a>
            </div>
            
            </div>
            <div class="submit">
                <input type="submit" value="로그인">
            </div>
             
        </form>
        </div>
    </div>

</c:when>
<c:otherwise>
<div style="text-align:center;">
	<strong>${mname}</strong> 님
      <a href="logout.do">[로그아웃]</a>
      <br><br>
      <a href="memberModify">[회원정보 수정]</a>
      <a href="memberWithdraw">[회원 탈퇴]</a>
    </div>
  </c:otherwise>
</c:choose>
	

<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>

</body>
</html>