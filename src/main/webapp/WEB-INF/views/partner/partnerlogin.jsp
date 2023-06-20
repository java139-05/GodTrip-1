<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%@ include file="../header.jsp" %>    

<style>
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
<!-- 본문시작 -->
<div class="col-sm-12">


<c:choose>
<c:when test="${ empty p_id  || empty p_passwd || p_level == 'E1' || p_level == 'F1' }"> 	
<c:if test="${not empty Loginmessage}">
        <script>
            //alert('${Loginmessage}');
            location.href = '/partner/partnerpage';
        </script>
    </c:if>
    
<c:if test="${not empty FindIdmessage}">
        <script>
            alert('${FindIdmessage}');
        </script>
    </c:if>    
    

<div class="wrap">
        <div class="login">
            <h2>*판매자 로그인*</h2>
            <div class="login_id">
                <form action="partnerlogin.do" method="post" id="partnerloginfrm" name="partnerloginfrm" onsubmit="return partnerloginCheck()"> 
                <h4>ID</h4>
             <input type="text" name="p_id" id="p_id" placeholder="ID" maxlength="15" autofocus>
           
            </div>
            <div class="login_pw">
                <h4>Password</h4>
                <input type="password" name="p_passwd" id="p_passwd" placeholder="Password" maxlength="15">
            </div>
        

            <div class="login_etc">
                <div class="checkbox">
                <a href="agreement">회원가입</a>
                </div>
              <br>
                <div class="forgot_pw">
                <a href="pfindId.do">비밀번호 찾기</a>
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
	<strong>${p_name}</strong> 님
      <a href="partnerlogout.do">[로그아웃]</a>
      <br><br>
      <a href="partnerModify">[회원정보 수정]</a>
      <a href="partnerWithdraw">[회원 탈퇴]</a>
    </div>
  </c:otherwise>
</c:choose>
	
</div>
<!-- 본문끝 -->
<%@ include file="../footer.jsp" %>