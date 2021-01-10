<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<meta name="description"
	content="Responsive Bootstrap 4 and web Application ui kit.">
<title>PanneauAdmin</title>
<link rel="icon" href="favicon.ico" type="image/x-icon">
<!-- Favicon-->

<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css"
	href="resources/css/select2.min.css">

<link rel="stylesheet" type="text/css"
	href="resources/css/datepicker.css">

<link rel="stylesheet" type="text/css"
	href="resources/css/tabulator_bootstrap4.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">

<link rel="stylesheet"
	href="resources/assets/plugins/jvectormap/jquery-jvectormap-2.0.3.min.css" />
<link rel="stylesheet"
	href="resources/assets/plugins/charts-c3/plugin.css" />

<link rel="stylesheet"
	href="resources/assets/plugins/morrisjs/morris.min.css" />
<!-- Custom Css -->
<link rel="stylesheet" href="resources/assets/css/style.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/ResetPassword.css">

<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap-datetimepicker.min.css">


<style type="text/css">
.dropdown-toggle {
	display: none;
}

.option-heading:before {
	content: "\25bc";
}

.option-heading.is-active:before {
	content: "\25b2";
}

/* Helpers */
.is-hidden {
	display: none;
}

.option-heading:hover {
	cursor: pointer;
}

#Settings .modal-lg {
	max-width: 70%;
	max-height: 70%;
}

.datepicker-container {
	z-index: 9999 !important; /* has to be larger than 1050 */
}

div.progress {
	width: 200px
}

#delete_user_modal {
	z-index: 9999 !important; /* has to be larger than 1050 */
}

#edit_user_modal {
	z-index: 9999 !important; /* has to be larger than 1050 */
}

#userListModal .modal-lg {
	max-width: 80%;
	max-height: 80%;
}
</style>

</head>
<body class="theme-blush">
	<%
		response.setHeader("cache-control", "no-cache,no-store,must-revalidate");
		if (session.getAttribute("username") == null) {

			response.sendRedirect("index.jsp");
		}
	%>



	<!-- Page Loader -->
	<div class="page-loader-wrapper">
		<div class="loader">
			<div class="m-t-30">
				<img class="zmdi-hc-spin" src="resources/assets/images/loader.svg"
					width="48" height="48" alt="Aero">
			</div>
			<p>Chargement...</p>
		</div>
	</div>

	<!-- Overlay For Sidebars -->
	<div class="overlay"></div>


	<!--Right Icon menu Sidebar -->
	<div class="navbar-right">
		<ul class="navbar-nav">
			<li><a href="<%=request.getContextPath()%>/Logout"
				class="mega-menu" title="Log Out"><i class="zmdi zmdi-power"></i></a></li>
		</ul>
	</div>

	<!-- Left Sidebar -->
	<aside id="leftsidebar" class="sidebar">
		<div class="navbar-brand">
			<button class="btn-menu ls-toggle-btn" type="button">
				<i class="zmdi zmdi-menu"></i>
			</button>

		</div>
		<div class="menu">
			<ul class="list">
				<li>
					<div class="user-info">
						<a class="image" href="javascript:void(0)"> <!--  <img src="assets/images/profile_av.jpg" alt="User">-->
							<i class="fa fa-user-circle fa-lg"></i>
						</a>
						<div class="detail">
							<h4>Bienvenue</h4>
							<small><%=session.getAttribute("username")%></small>
						</div>
					</div>
				</li>
				<li class="active open"><a href="panneauAdmin_new.jsp"><i
						class="zmdi zmdi-home"></i><span>Tableau de Bord</span></a></li>
				<li><a href="mainTemplate.jsp"><i
						class="zmdi zmdi-folder-star-alt"></i><span>Tiquets</span></a></li>

				<li><a data-toggle="modal" data-target="#Settings"
					href="javascript:void(0)"><i class="zmdi zmdi-settings"></i><span>Paramètres</span></a></li>


			</ul>
		</div>
	</aside>


	<!-- Main Content -->

	<section class="content">


		<div class="container-fluid">

			<div class="row clearfix">
				<div class="col-lg-12">
					<div class="card">
						<div class="header">
							<h2>
								<strong><i class="zmdi zmdi-accounts-list-alt"></i>
									Gestion</strong> Utilisateurs
							</h2>

						</div>

						<div class="body">
							<button class="btn btn-sm btn-success pull-right"
								data-toggle="modal" data-target="#registerModal">
								<i class="fa fa-pencil"></i> Nouveau
							</button>
							<div id="usersList"></div>
						</div>
					</div>
				</div>
			</div>

			<div class="row clearfix">
				<div class="col-lg-12">
					<div class="card">
						<div class="header">
							<h2>
								<strong><i class="zmdi zmdi-email"></i> Gestion</strong>
								Contacts
							</h2>


						</div>

						<div class="body">
							<div id="contactList"></div>
						</div>
					</div>
				</div>
			</div>

		</div>

		<div id="semiTransparentDiv"></div>
	</section>





	<!--Edit User-->
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<div class="modal fade" id="edit_user_modal">

					<div class="modal-dialog">
						<div class="modal-content">

							<div class="modal-body">

								<em><i class="fa fa-edit"
									style="font-size: 30px; color: green; width: 10%; height: 10%"></i>
									Editer User</em>
								<div class="mt-3">
									<form id="editForm"
										action="<%=request.getContextPath()%>/UserManagement"
										method="POST" autocomplete="off"
										oninput='password2.setCustomValidity(password2.value != password.value ? "Mot de passe ne correspondent pas." : "")'>

										<div class="form-group" hidden="1">
											<input type="text" name="usernameId" id="user_id" value="" />
										</div>
										<div class="form-group" hidden="1">
											<input type="text" name="action" id="action"
												value="/EditUser" />
										</div>
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-user"></i>
												</span>
											</div>
											<input name="firstName" id="prenom_id" class="form-control"
												placeholder="Prénom" type="text" required="required">
										</div>
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-user"></i>
												</span>
											</div>
											<input name="lastName" id="nom_id" class="form-control"
												placeholder="Nom" type="text" required="required">
										</div>
										<!-- form-group// -->
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i
													class="fa fa-envelope"></i>
												</span>
											</div>
											<input name="email" id="email_id" class="form-control"
												placeholder="addresse Email" type="email"
												required="required">
										</div>
										<!-- form-group// -->
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i
													class="fa fa-phone"></i>
												</span>
											</div>

											<input name="phone" id="phone_id" class="form-control"
												placeholder="Téléphone" type="text" required="required">
										</div>
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-user"></i>
												</span>
											</div>
											<input name="username" id="username_id" class="form-control"
												placeholder="Username" type="text" required="required">
										</div>

										<!-- form-group// -->
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-lock"></i>
												</span>
											</div>
											<input name="password" id="password_id" class="form-control"
												placeholder="Password" type="password">
										</div>
										<!-- form-group// -->
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-lock"></i>
												</span>
											</div>
											<input name="password2" id="password2_id"
												class="form-control" placeholder="Confirmer password"
												type="password">
										</div>
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i
													class="fa fa-calendar" aria-hidden="true"></i>
												</span>
											</div>
											<input type="text" class="form-control"
												id="date_expiration_compte_EditUser"
												name="date_expiration_compte"
												placeholder="Date Expération du Compte" required>

										</div>
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text">Type</span>
											</div>
											<select name=userType id="userType_id">
												<option value="1">Admin</option>
												<option value="2">Client</option>
												<option value="3">User Entreprise</option>
											</select>
										</div>
										<!-- form-group// -->
										<div class="form-group">

											<button type="submit" class="btn btn-success btn-md">
												<i class="fa fa-save"></i> Sauvgarder
											</button>
										</div>
									</form>
								</div>


							</div>

							<div class="modal-footer">


								<button class="btn btn-danger btn-md" data-dismiss="modal"
									style="color: white">
									<i class="fa fa-times" aria-hidden="true"></i> Annuler
								</button>

							</div>

						</div>


					</div>


				</div>

			</div>

		</div>


	</div>


	<!--Delete User-->
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<div class="modal fade" id="delete_user_modal">

					<div class="modal-dialog">
						<div class="modal-content">

							<div class="modal-body">

								<em><i class="fa fa-exclamation-triangle"
									style="font-size: 30px; color: red; width: 10%; height: 10%"></i>êtes
									vous sûre ?</em>
							</div>

							<div class="modal-footer">

								<form id="DeleteUserForm"
									action="<%=request.getContextPath()%>/UserManagement"
									method="POST" autocomplete="off">

									<div class="form-group" hidden="1">
										<input type="text" name="username_id" id="username_id"
											value="" />
									</div>
									<div class="form-group" hidden="1">
										<input type="text" name="action" id="action"
											value="/DeleteUser" />
									</div>
									<button type="submit" class="btn btn-danger btn-md">
										<i class="fa fa-trash"></i> Supprimer
									</button>
								</form>
								<button class="btn btn-success btn-md" data-dismiss="modal"
									style="color: white">
									<i class="fa fa-times" aria-hidden="true"></i> Annuler
								</button>

							</div>

						</div>


					</div>


				</div>

			</div>

		</div>


	</div>


	<!--Delete Contact-->
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<div class="modal fade" id="delete_contact_modal">

					<div class="modal-dialog">
						<div class="modal-content">

							<div class="modal-body">

								<em><i class="fa fa-exclamation-triangle"
									style="font-size: 30px; color: red; width: 10%; height: 10%"></i>êtes
									vous sûre ?</em>

							</div>

							<div class="modal-footer">

								<form id="DeleteContactForm"
									action="<%=request.getContextPath()%>/Contacts" method="POST"
									autocomplete="off">

									<div class="form-group" hidden>
										<input type="text" name="contact_id" id="contact_id" value="" />
									</div>
									<div class="form-group" hidden>
										<input type="text" name="action" id="action"
											value="/DeleteContact" />
									</div>
									<button type="submit" class="btn btn-danger btn-md">
										<i class="fa fa-trash"></i> Supprimer
									</button>
								</form>
								<button id="close_model" class="btn btn-success btn-md"
									data-dismiss="modal" style="color: white">
									<i class="fa fa-times" aria-hidden="true"></i> Annuler
								</button>

							</div>

						</div>


					</div>


				</div>

			</div>

		</div>


	</div>


	<!--Show Message In popup-->
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<div class="modal fade" id="Message">

					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">
									<i class="fa fa-envelope fa-lg" aria-hidden="true"></i> Message
								</h5>
							</div>

							<div class="modal-body">

								<div class="form-group">

									<textarea class="form-control" id="putMessage" rows="10"
										style="color: #000" readonly></textarea>
								</div>



							</div>

							<div class="modal-footer">


								<button id="close_model" class="btn btn-danger btn-md"
									data-dismiss="modal" style="color: white">
									<i class="fa fa-times" aria-hidden="true"></i> Fermer
								</button>

							</div>

						</div>


					</div>


				</div>

			</div>

		</div>


	</div>


	<!--Show Settings In popup-->
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<div class="modal fade" id="Settings">

					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">
									<i class="fa fa-cog fa-lg" aria-hidden="true"></i> Paramètres
								</h5>

							</div>

							<div class="modal-body">


								<!-- first param menu -->
								<div class="option-heading">Paramètrage Mailing &
									Attachement</div>
								<div class="option-content is-hidden">
									<div class="col-md-8 offset-2 mt-1">

										<form id="MailingSettingForm"
											action="<%=request.getContextPath()%>/Settings" method="POST"
											autocomplete="off">

											<div class="form-group" hidden="1">
												<input type="text" name="action" id="action"
													value="/MailSettings&Attachment" />
											</div>
											<div class="form-group input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"> <i class="fa fa-at"></i>
													</span>
												</div>
												<input name="host" id="host" class="form-control"
													placeholder="Host" type="text"
													oninvalid="this.setCustomValidity('Host obligatoire !')"
													oninput="setCustomValidity('')" required>
											</div>

											<div class="form-group input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"> <i
														class="fa fa-server"></i>
													</span>
												</div>
												<input name="smtp" id="smtp" class="form-control"
													placeholder="SMTP Server" type="text"
													oninvalid="this.setCustomValidity('SMTP Server obligatoire !')"
													oninput="setCustomValidity('')" required>
											</div>

											<div class="form-group input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"> <i
														class="fa fa-plug"></i>
													</span>
												</div>
												<input name="port" id="port" class="form-control"
													placeholder="Port" type="number"
													oninvalid="this.setCustomValidity('Port obligatoire !')"
													oninput="setCustomValidity('')" required>
											</div>

											<div class="form-group input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"> <i
														class="fa fa-envelope"></i>
													</span>
												</div>
												<input name="email" id="email" class="form-control"
													placeholder="Email" type="email"
													oninvalid="this.setCustomValidity('Email obligatoire !')"
													oninput="setCustomValidity('')" required>
											</div>

											<div class="form-group input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"> <i
														class="fa fa-user"></i>
													</span>
												</div>
												<input name="nom" id="nom" class="form-control"
													placeholder="Nom" type="text"
													oninvalid="this.setCustomValidity('Nom obligatoire !')"
													oninput="setCustomValidity('')" required>
											</div>

											<div class="form-group input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"> <i
														class="fa fa-lock"></i>
													</span>
												</div>
												<input name="password" id="password" class="form-control"
													placeholder="Password" type="password"
													oninvalid="this.setCustomValidity('Password obligatoire !')"
													oninput="setCustomValidity('')" required>
											</div>

											<div class="form-group input-group">
												<div class="input-group-prepend">
													<span class="input-group-text"> <i
														class="fa fa-paperclip"></i>
													</span>
												</div>
												<input name="attchpath" id="attchpath" class="form-control"
													placeholder="Path Attachement exp: C:/Attachements"
													type="text"
													oninvalid="this.setCustomValidity('Path Attachement obligatoire !')"
													oninput="setCustomValidity('')" required>
											</div>


											<!-- form-group// -->
											<div class="form-group">

												<button id="sauv" type="submit"
													class="btn btn-success btn-md">
													<i class="fa fa-save"></i> Sauvgarder
												</button>
											</div>
										</form>
									</div>
									<!-- Put Edit Mailing parameters here -->
									<div id="paramList"></div>

								</div>
								<br>
							<!-- second param menu -->
								<div id="usersParam" class="option-heading">Logiciels et Version</div>
								<div class="option-content is-hidden">

									<h1>put here</h1>

								</div>
								

							</div>

							<div class="modal-footer">


								<button id="close_model" class="btn btn-danger btn-md"
									data-dismiss="modal" style="color: white">
									<i class="fa fa-times" aria-hidden="true"></i> Fermer
								</button>

							</div>

						</div>


					</div>


				</div>

			</div>

		</div>


	</div>


	<!--Show Edit Settings In popup-->
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<div class="modal fade" id="edit_param_modal">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">
									<i class="fa fa-cog fa-lg" aria-hidden="true"></i> Paramètres
								</h5>
							</div>
							<div class="modal-body">

								<div class="col-md-8 offset-2 mt-1">

									<form id="EditMailingSettingForm"
										action="<%=request.getContextPath()%>/Settings" method="POST"
										oninput='password2.setCustomValidity(password2.value != password.value ? "Mot de passe ne correspondent pas." : "")'
										autocomplete="off">

										<div class="form-group" hidden="1">
											<input type="text" name="action" id="action"
												value="/EditMailSettings&Attachment" />
										</div>
										<div class="form-group" hidden>
											<input type="text" name="settings_id" id="settings_id"
												value="" />
										</div>
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-at"></i>
												</span>
											</div>
											<input name="host" id="host" class="form-control"
												placeholder="Host" type="text"
												oninvalid="this.setCustomValidity('Host obligatoire !')"
												oninput="setCustomValidity('')" required>
										</div>

										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i
													class="fa fa-server"></i>
												</span>
											</div>
											<input name="smtp" id="smtp" class="form-control"
												placeholder="SMTP Server" type="text"
												oninvalid="this.setCustomValidity('SMTP Server obligatoire !')"
												oninput="setCustomValidity('')" required>
										</div>

										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-plug"></i>
												</span>
											</div>
											<input name="port" id="port" class="form-control"
												placeholder="Port" type="number"
												oninvalid="this.setCustomValidity('Port obligatoire !')"
												oninput="setCustomValidity('')" required>
										</div>

										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i
													class="fa fa-envelope"></i>
												</span>
											</div>
											<input name="email" id="email" class="form-control"
												placeholder="Email" type="email"
												oninvalid="this.setCustomValidity('Email obligatoire !')"
												oninput="setCustomValidity('')" required>
										</div>

										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-user"></i>
												</span>
											</div>
											<input name="nom" id="nom" class="form-control"
												placeholder="Nom" type="text"
												oninvalid="this.setCustomValidity('Nom obligatoire !')"
												oninput="setCustomValidity('')" required>
										</div>

										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-lock"></i>
												</span>
											</div>
											<input name="password" id="password_id" class="form-control"
												placeholder="Password" type="password">
										</div>
										<!-- form-group// -->
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-lock"></i>
												</span>
											</div>
											<input name="password2" id="password2_id"
												class="form-control" placeholder="Confirmer password"
												type="password">
										</div>

										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i
													class="fa fa-paperclip"></i>
												</span>
											</div>
											<input name="attchpath" id="attchpath" class="form-control"
												placeholder="Path Attachement exp: C:/Attachements"
												type="text"
												oninvalid="this.setCustomValidity('Path Attachement obligatoire !')"
												oninput="setCustomValidity('')" required>
										</div>

										<!-- form-group// -->
										<div class="form-group">

											<button id="sauv" type="submit"
												class="btn btn-success btn-md">
												<i class="fa fa-save"></i> Sauvgarder
											</button>
										</div>
									</form>
								</div>

							</div>

							<div class="modal-footer">


								<button id="close_model" class="btn btn-danger btn-md"
									data-dismiss="modal" style="color: white">
									<i class="fa fa-times" aria-hidden="true"></i> Fermer
								</button>

							</div>

						</div>


					</div>


				</div>

			</div>

		</div>


	</div>

	<!-------------------------------Add new user----------------------->
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<div class="modal fade" id="registerModal">

					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">
									<i class="fa fa-pencil fa-lg" aria-hidden="true"></i> Ajouter
									nouveau utilisateur
								</h5>

							</div>

							<div class="modal-body">
								<div id="successAlert" class="alert alert-success" role="alert"
									hidden></div>
								<div class="col-md-8 offset-2">

									<form id="registerForm"
										action="<%=request.getContextPath()%>/UserManagement"
										method="post" autocomplete="off"
										oninput='password2.setCustomValidity(password2.value != password.value ? "Mot de passe ne correspondent pas." : "")'>
										<div class="form-group" hidden="1">
											<input type="text" name="action" id="action"
												value="/register" />
										</div>

										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-user"></i>
												</span>
											</div>
											<input name="firstName" id="prenomRegister_id"
												class="form-control" placeholder="Prénom" type="text"
												oninvalid="this.setCustomValidity('Prénom obligatoire !')"
												oninput="setCustomValidity('')" required>
										</div>
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-user"></i>
												</span>
											</div>
											<input name="lastName" id="nomRegister_id"
												class="form-control" placeholder="Nom" type="text"
												oninvalid="this.setCustomValidity('Nom obligatoire !')"
												oninput="setCustomValidity('')" required>
										</div>
										<!-- form-group// -->
										<div id="emailAlert" class="alert alert-danger" role="alert"
											hidden></div>
										<div class="form-group input-group">

											<div class="input-group-prepend">
												<span class="input-group-text"> <i
													class="fa fa-envelope"></i>
												</span>
											</div>

											<input name="email" id="emailRegister_id"
												class="form-control" placeholder="adresse Email"
												type="email"
												oninvalid="this.setCustomValidity('Email obligatoire !')"
												oninput="setCustomValidity('')" required>
										</div>
										<!-- form-group// -->
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i
													class="fa fa-phone"></i>
												</span>
											</div>

											<input name="phone" id="phoneRegister_id"
												class="form-control" placeholder="Téléphone" type="text"
												oninvalid="this.setCustomValidity('Téléphone obligatoire !')"
												oninput="setCustomValidity('')" required>
										</div>
										<div id="usernameAlert" class="alert alert-danger"
											role="alert" hidden></div>
										<div class="form-group input-group">

											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-user"></i>
												</span>
											</div>

											<input name="username" id="usernameRegister_id"
												class="form-control" placeholder="Username" type="text"
												oninvalid="this.setCustomValidity('Username obligatoire !')"
												oninput="setCustomValidity('')" required>
										</div>
										<!-- form-group// -->
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-lock"></i>
												</span>
											</div>
											<input name="password" id="passwordRegister_id"
												class="form-control" placeholder="Password" type="password"
												required>
										</div>
										<!-- form-group// -->
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="fa fa-lock"></i>
												</span>
											</div>
											<input name="password2" id="password2Register_id"
												class="form-control" placeholder="Confirmer password"
												type="password" required>
										</div>
										<!-- form-group// -->
										<!-- Here put Expiration DatePickers -->
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i
													class="fa fa-calendar" aria-hidden="true"></i>
												</span>
											</div>
											<input type="text" class="form-control"
												id="date_expiration_compte" name="date_expiration_compte"
												placeholder="Date Expération du Compte" required>

										</div>
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text">Type</span>
											</div>
											<select name="userType" id="userType_id" required>
												<option value="1">Admin</option>
												<option value="2">Client</option>
												<option value="3">User Entreprise</option>
											</select>
										</div>

										<div class="form-group">
											<button type="submit" class="btn btn-success">Submit</button>
										</div>

									</form>
								</div>



							</div>

							<div class="modal-footer">


								<button id="closeAddUser" class="btn btn-danger btn-md"
									data-dismiss="modal" style="color: white">
									<i class="fa fa-times" aria-hidden="true"></i> Annuler
								</button>

							</div>

						</div>


					</div>


				</div>

			</div>

		</div>


	</div>
	<!-- ------------------------------------------------------------------------------------------ -->

	<!------------------------------- Liste des Utilisateurs ----------------------->
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<div class="modal fade" id="userListModal">

					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">

								<h5 class="modal-title">
									<i class="fa fa-badge fa-lg" aria-hidden="true"></i> Liste des
									Utilisateur
								</h5>


							</div>

							<div class="modal-body">
								<div class="mb-1">
									<button id="download-xlsx" class="btn btn-success btn-sm">Télécharger
										XLSX</button>
									<button id="download-pdf" class="btn btn-danger btn-sm">Télécharger
										PDF</button>
									<button class="btn btn-sm btn-success pull-right mx-1 "
										data-toggle="modal" data-target="#registerModal">
										<i class="fa fa-pencil"></i> Nouveau
									</button>
								</div>


								<div id="usersList"></div>

							</div>

							<div class="modal-footer">


								<button id="close_model" class="btn btn-danger btn-md"
									data-dismiss="modal" style="color: white">
									<i class="fa fa-times" aria-hidden="true"></i> Fermer
								</button>

							</div>

						</div>


					</div>


				</div>

			</div>

		</div>


	</div>
	<!-- ------------------------------------------------------------------------------------------ -->


	<script src="resources/js/jquery-3.5.1.min.js"></script>
	<script src="resources/js/moment.min.js"></script>
	<script src="resources/js/select2.min.js" defer></script>
	<script src="resources/js/tabulator.min.js"></script>
	<script src="resources/js/flash.min.js"></script>
	<script src="resources/js/manageTickets.js"></script>
	<script src="resources/js/manageUsers.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/mainTemplate.js"></script>
	<script src="resources/js/popper.js"></script>

	<!-- Jquery Core Js -->
	<script src="resources/assets/bundles/libscripts.bundle.js"></script>
	<!-- Lib Scripts Plugin Js ( jquery.v3.2.1, Bootstrap4 js) -->
	<script src="resources/assets/bundles/vendorscripts.bundle.js"></script>
	<!-- slimscroll, waves Scripts Plugin Js -->

	<script src="resources/assets/bundles/jvectormap.bundle.js"></script>
	<!-- JVectorMap Plugin Js -->
	<script src="resources/assets/bundles/sparkline.bundle.js"></script>
	<!-- Sparkline Plugin Js -->
	<script src="resources/assets/bundles/c3.bundle.js"></script>
	<script src="resources/js/bootstrap-datetimepicker.min.js"></script>
	<script src="resources/js/datepicker.js"></script>
	<script src="resources/js/datepickerForAdmin.js"></script>
	<script src="resources/assets/bundles/mainscripts.bundle.js"></script>
	<script src="resources/assets/js/pages/index.js"></script>
	<script src="resources/js/contacts/contacts.js"></script>
	<script src="resources/js/Settings.js"></script>
	<script src="resources/js/validateForms.js"></script>


</body>
</html>