<%@ page language="java" contentType="text/html; charset=UTF8"
    pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF8">
<title>Nouveau Mot de passe</title>
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.min.css">
	
	<link rel="stylesheet" type="text/css"
	href="resources/css/ResetPassword.css">
	
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
</head>
<body>
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
                              
                              <form id="resetForm" class="form" action="<%=request.getContextPath()%>/ResetPassword" method="post">
                                <fieldset>
                                <div class="form-group" hidden>
													<input type="text" name="action" id="action"
														value="/SendLink" />
								</div>
                                  <div class="form-group input-group">
                                    <div class="input-group-prepend">
                                      <span class="input-group-text"> <i class="fa fa-envelope"></i>
								       </span>
                                    </div>
                                    <input id="emailInput" name="emailInput" placeholder="Email" class="form-control" type="email" oninvalid="setCustomValidity('SVP entrez un email valide!')" onchange="try{setCustomValidity('')}catch(e){}" required>
                                  </div>
                                  <div class="form-group">
                                    <input class="btn btn-lg btn-primary btn-block" value="Envoyer Lien de Récupération" type="submit">
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