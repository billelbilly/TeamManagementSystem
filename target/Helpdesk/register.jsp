<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="resources/css/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/css/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/css/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="resources/css/util.css">
<link rel="stylesheet" type="text/css" href="resources/css/main.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/ResetPassword.css">
<!--===============================================================================================-->

</head>
<body>
	<div class="container">

		<hr>
		<div class="row col-md-10 col-md-offset-3 justify-content-center">

			<div class="card card-body ">

				<h2>Créer un nouveau compte</h2>
				<div class="col-md-8 col-md-offset-3 mt-3">

					<form id="registerForm"
						action="<%=request.getContextPath()%>/UserManagement" method="post" autocomplete="off"
						oninput='password2.setCustomValidity(password2.value != password.value ? "Mot de passe ne correspondent pas." : "")'>
						<div class="form-group" hidden="1">
										<input type="text" name="action" id="action" value="/register" />
						</div>
					
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-user"></i>
								</span>
							</div>
							<input name="firstName" id="prenom_id" class="form-control"
								placeholder="Prénom" type="text" oninvalid="this.setCustomValidity('Prénom obligatoire !')"
                                     oninput="setCustomValidity('')" required>
						</div>
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-user"></i>
								</span>
							</div>
							<input name="lastName" id="nom_id" class="form-control" placeholder="Nom"
								type="text" oninvalid="this.setCustomValidity('Nom obligatoire !')"
                                     oninput="setCustomValidity('')" required>
						</div>
						<!-- form-group// -->
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-envelope"></i>
								</span>
							</div>
							<input name="email" id="email_id" class="form-control"
								placeholder="adresse Email" type="email" oninvalid="this.setCustomValidity('Email obligatoire !')"
                                     oninput="setCustomValidity('')" required>
						</div>
						<!-- form-group// -->
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-phone"></i>
								</span>
							</div>

							<input name="phone" id="phone_id" class="form-control" placeholder="Téléphone"
								type="text" oninvalid="this.setCustomValidity('Téléphone obligatoire !')"
                                     oninput="setCustomValidity('')" required>
						</div>
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-user"></i>
								</span>
							</div>
							<input name="username" id="username_id" class="form-control"
								placeholder="Username" type="text" oninvalid="this.setCustomValidity('Username obligatoire !')"
                                     oninput="setCustomValidity('')" required>
						</div>
						<!-- form-group// -->
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-lock"></i>
								</span>
							</div>
							<input name="password" id="password_id" class="form-control"
								placeholder="Password" type="password" required>
						</div>
						<!-- form-group// -->
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-lock"></i>
								</span>
							</div>
							<input name="password2" id="password2_id" class="form-control"
								placeholder="Confirmer password" type="password"
								required>
						</div>
						<!-- form-group// -->

						<div class="form-group">
							<button type="submit" class="btn btn-primary">Submit</button>
							<p>
								déjà enregistré? <a href="/Helpdesk/login.jsp">Login ici <i
									class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i></a>
							</p>
						</div>

					</form>
				</div>
			</div>
		</div>
		<div id="semiTransparentDiv"> </div>
	</div>

	<script src="resources/js/jquery-3.5.1.min.js"></script>
	<script src="resources/js/main.js"></script>
	<script src="resources/js/flash.min.js"></script>
	<script src="resources/js/validateForms.js"></script>
</body>
</html>