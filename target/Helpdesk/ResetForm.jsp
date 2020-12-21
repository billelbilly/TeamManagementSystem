<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Changer Mot de Passe</title>
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.min.css">
	
	<link rel="stylesheet" type="text/css"
	href="resources/css/ResetPassword.css">
	
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
</head>
<body>

<%
		response.setHeader("cache-control", "no-cache,no-store,must-revalidate");
		if (session.getAttribute("email") == null) {

			response.sendRedirect("login.jsp");
		}
	%>

<hr>
<div class="container">
 
        <div class="row">
            <div id="toReplace" class="col-md-4 offset-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="text-center">
                          <h3><i class="fa fa-lock fa-4x"></i></h3>
                          <h2 class="text-center">Mot de Passe Oublié ?</h2>
                          <p>Récupération de Mot de Passe.</p>
                            <div class="panel-body">
                              
                              <form id="updatePasswordForm" class="form" action="<%=request.getContextPath()%>/ResetPassword" oninput='password2.setCustomValidity(password2.value != password.value ? "Mot de passe ne correspondent pas." : "")' method="post">
                                <fieldset>
                                <div class="form-group" hidden>
													<input type="text" name="action" id="action"
														value="/UpdatePassword" />
								</div>
								<div class="form-group" hidden>
													<input type="text" name="email" id="email"
														value="<%=session.getAttribute("email")%>" />
								</div>
                                  <!-- form-group// -->
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-lock"></i>
								</span>
							</div>
							<input name="password" id="password_id" class="form-control"
								placeholder="Password" type="password" required="required">
						</div>
						<!-- form-group// -->
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-lock"></i>
								</span>
							</div>
							<input name="password2" id="password2_id" class="form-control"
								placeholder="Confirmer password" type="password"
								required="required">
						</div>
                                  <div class="form-group">
                                    <input class="btn btn-lg btn-primary btn-block" value="Envoyer Password" type="submit">
                                  </div>
                                </fieldset>
                              </form>
                              
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
         <div id="semiTransparentDiv"> </div>
         <a href="/Helpdesk/login.jsp" data-toggle="tooltip" data-placement="top" title="Accès Au Système">
         <div id="loginPage" class="circleBase type1" hidden></div>
        </a>

</div>


	<!--===============================================================================================-->
	<script src="resources/js/jquery-3.5.1.min.js"></script>
	<!--===============================================================================================-->
	<script src="resources/js/popper.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/flash.min.js"></script>
	<script src="resources/js/resetPassword.js"></script>
	<!--===============================================================================================-->

</body>
</html>