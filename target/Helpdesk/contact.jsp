<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Nous Contacter</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
<link rel="icon" type="image/png" href="images/icons/favicon.ico" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/contact_assets/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/contact_assets/vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/contact_assets/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/contact_assets/vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/contact_assets/css/util.css">
<link rel="stylesheet" type="text/css"
	href="resources/contact_assets/css/main.css">
	<link rel="stylesheet" type="text/css"
	href="resources/css/ResetPassword.css">
<!--===============================================================================================-->
</head>
<body>

	<div class="contact1">
		<div class="container-contact1">
			<div class="contact1-pic js-tilt" data-tilt>
				<img src="resources/images/envlope.png" alt="IMG">
			</div>

			<form id="idForm"
				action="<%=request.getContextPath()%>/Contacts"
				class="contact1-form validate-form" method="post" autocomplete="off">
				<span class="contact1-form-title"> Nous Contacter </span>
				<div class="form-group" hidden="1">
					<input type="text" name="action" id="action" value="/SaveContact" />
				</div>

				<div class="wrap-input1 validate-input"
					data-validate="Nom obligatoire">
					<input class="input1" type="text" name="nom" placeholder="Nom" oninvalid="this.setCustomValidity('Nom obligatoire !')"
                                     oninput="setCustomValidity('')" required>
					<span class="shadow-input1"></span>
				</div>

				<div class="wrap-input1 validate-input"
					data-validate="Email Obligatoire: ex@abc.xyz">
					<input class="input1" type="text" name="email" placeholder="Email" oninvalid="this.setCustomValidity('Email obligatoire !')"
                                     oninput="setCustomValidity('')" required>
					<span class="shadow-input1"></span>
				</div>

				<div class="wrap-input1 validate-input"
					data-validate="Objet Obligatoire">
					<input class="input1" type="text" name="objet" placeholder="Objet" oninvalid="this.setCustomValidity('Objet obligatoire !')"
                                     oninput="setCustomValidity('')" required>
					<span class="shadow-input1"></span>
				</div>

				<div class="wrap-input1 validate-input"
					data-validate="Message Obligatoire">
					<textarea class="input1" name="message" placeholder="Message" oninvalid="this.setCustomValidity('Message obligatoire !')"
                                     oninput="setCustomValidity('')" required></textarea>
					<span class="shadow-input1"></span>
				</div>

				<div class="container-contact1-form-btn">
					<button type="submit" class="contact1-form-btn">
						<span> Envoyer <i class="fa fa-long-arrow-right"
							aria-hidden="true"></i>
						</span>
					</button>
				</div>
			</form>
		</div>
		<div id="semiTransparentDiv"> </div>
	</div>


	<!--===============================================================================================-->
	<script
		src="resources/contact_assets/vendor/jquery/jquery-3.2.1.min.js"></script>
	<!--===============================================================================================-->
	<script src="resources/contact_assets/vendor/bootstrap/js/popper.js"></script>
	<script
		src="resources/contact_assets/vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script src="resources/contact_assets/vendor/select2/select2.min.js"></script>
	<!--===============================================================================================-->
	<script src="resources/contact_assets/vendor/tilt/tilt.jquery.min.js"></script>
	<script>
		$('.js-tilt').tilt({
			scale : 1.1
		})
	</script>

	<!--===============================================================================================-->
	<script src="resources/contact_assets/js/main.js"></script>
	<script src="resources/js/contacts/contacts.js"></script>

</body>
</html>
