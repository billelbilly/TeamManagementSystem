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
	href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">

<link rel="stylesheet"
	href="resources/assets/plugins/jvectormap/jquery-jvectormap-2.0.3.min.css" />

<!-- Custom Css -->
<link rel="stylesheet" href="resources/assets/css/style.min.css">

<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap-datetimepicker.min.css">

<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap-toggle.min.css">




<style type="text/css">


/* Response Css*/
.comment-wrapper .card-body {
	max-height: 650px;
	overflow: auto;
}

.comment-wrapper .media-list .media img {
	width: 64px;
	height: 64px;
	border: 2px solid #e5e7e8;
}

.comment-wrapper .media-list .media {
	border-bottom: 1px dashed #efefef;
	margin-bottom: 25px;
}

#logout {
	padding: 10px;
}

#logout:hover {
	background: red;
}

#back:hover {
	background: #d3d3d3;
}

.datepicker-container {
	z-index: 1050 !important; /* has to be larger than 1050 */
}

#planifList .modal-lg {
	max-width: 80%;
	max-height: 80%;
}

#newIssue .modal-md {
	max-width: 40%;
	max-height: 40%;
}

div.responseScroll {
	/*background-color: lightblue;*/
	max-height: 200px;
	overflow: auto;
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
	<!-- Send user Session To Server -->
	<input type="text" name="usersession" id="usersession"
		value="<%=session.getAttribute("username")%>" hidden />
	<input type="text" name="userPermission" id="userPermission"
		value="<%=session.getAttribute("userPermission")%>" hidden />



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


			</ul>
		</div>
	</aside>
	
	<section class="content">
	
							<div class="btn-group">
								<button id="nbr_ticket_open" type="button"
									class="btn btn-success"></button>
								<button id="nbr_ticket_assigned" type="button"
									class="btn btn-info"></button>
								<button id="nbr_ticket_closed" type="button"
									class="btn btn-danger"></button>
							</div>

							<div class="btn-group">

								<div class="input-group-prepend">
									<span class="input-group-text"> Filtrer Par: </span> <select
										name=filtreTicket id="filtreTicket">
										<option>...</option>
										<option value="créé">Crées</option>
										<option value="fermer">Fermer</option>
										<option value="assigné">Assignés</option>
									</select>
								</div>

								<div class="input-group-prepend ml-3">
									<input type="text" name="search" value="" id="search"
										placeholder="Recherche" autofocus />
								</div>


							</div>

							<div class="justify-content-center pull-right">
								<button type="button" class="btn btn-info btn-sm"
									id="listPlanifBtn" data-toggle="modal"
									data-target="#planifList" hidden>
									<i class="fa fa-history"></i> Liste Planification
								</button>
								<button type="button" class="btn btn-success btn-sm"
									data-toggle="modal" data-target="#newIssue">
									<i class="fa fa-pencil"></i> Nouveau Tiquet
								</button>
							</div>


							<hr>

			<!-- BEGIN TICKET -->
				<div class="col-md-8 offset-2">
					<div class="">
						<div class="">
							




							<!-- BEGIN NEW TICKET -->

							<div class="modal fade" id="newIssue" tabindex="-1" role="dialog"
								aria-labelledby="newIssue" aria-hidden="true">

								<div class="modal-dialog modal-md">
									<div class="modal-content">
										<div class="modal-header bg-blue">
											<h4 class="modal-title pull-left">
												<i class="fa fa-pencil"></i> Crée Nouvau Tiquet
											</h4>
										</div>
										<form id="ticketForm"
											action="<%=request.getContextPath()%>/TicketManagement"
											method="post" enctype="multipart/form-data"
											autocomplete="off">
											<div class="modal-body">
												<div class="form-group" hidden>
													<input type="text" name="action" id="action"
														value="/CreateTicket" />
												</div>
												<div class="form-group">
													<input name="subject" type="text" class="form-control"
														placeholder="Objet"
														oninvalid="this.setCustomValidity('Objet obligatoire !')"
														oninput="setCustomValidity('')" required>
												</div>
												<div class="d-flex justify-content-center">
													<div class="form-group input-group">
														<div class="input-group-prepend">
															<span class="input-group-text"> Sévérité </span>
														</div>
														<select name="severity" id="severity"
															style='width: 150px;'>
															<option>Critique</option>
															<option>Moyen</option>
															<option>Normale</option>

														</select>

													</div>
													<div class="form-group input-group">
														<div class="input-group-prepend">
															<span class="input-group-text"> Logiciel </span>
														</div>
														<select name=listLogiciel id="listLogiciel"
															style='width: 150px;' required>

														</select>
													</div>
													<div class="form-group input-group">
														<div class="input-group-prepend">
															<span class="input-group-text"> Version </span>
														</div>
														<select name=listVersion id="listVersion"
															style='width: 150px;'
															oninvalid="this.setCustomValidity('SVP Choisissez Le Logiciel et sa Version !')"
															oninput="setCustomValidity('')" required>

														</select>
													</div>
												</div>

												<div class="form-group">
													<textarea name="detail" class="form-control"
														placeholder="Détail du tiquet ou question"
														style="height: 120px;"
														oninvalid="this.setCustomValidity('Détails obligatoire !')"
														oninput="setCustomValidity('')" required></textarea>
												</div>
												<div class="form-group">
													<div id="bigFile" class="alert alert-danger" role="alert"
														hidden></div>
													<input id="file" type="file" name="attachment">
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-danger"
													data-dismiss="modal">
													<i class="fa fa-times"></i> Annuler
												</button>
												<button id="saveTicket" type="submit"
													class="btn btn-primary pull-right">
													<i class="fa fa-pencil"></i> Créer
												</button>
											</div>
										</form>
									</div>
								</div>
							</div>

							<!-- END NEW TICKET -->

							<div class="padding"></div>

							<div id="clickClearSearchHistory" class="row">
								<!-- BEGIN TICKET CONTENT -->
								<div class="col-md-6 offset-3">
									<div class="ticket_list"></div>


									<ul class="list-group fa-padding">

									</ul>

									<nav aria-label="Page navigation example">
										<ul class="pagination justify-content-center mt-3">

										</ul>
									</nav>



									<!-- BEGIN DETAIL TICKET -->
									<div class="modal fade" id="issue" tabindex="-1" role="dialog"
										aria-labelledby="issue" aria-hidden="true">
										<div class="modal-wrapper">
											<div class="modal-dialog modal-lg">
												<div class="modal-content">
													<div class="modal-header bg-blue">
														<!-- <button type="button" class="close" data-dismiss="modal" -->
														<!-- aria-hidden="true">×</button> -->
														<h4 class="modal-title">
															<i class="fa fa-info-circle"></i> Détails du Ticket
														</h4>
													</div>

													<div class="modal-body">

														<!-- Ticket Details -->
														<div class="row">
															<div class="col-md-2">
																<img src="assets/img/user/avatar01.png"
																	class="img-circle" alt="" width="50">
															</div>
															<div id="ticket_detail_header" class="col-md-10"></div>
														</div>
														<!-- End Ticket Details -->
														<!-- Ticket response comments -->
														<hr>
														<div class="row bootstrap snippets bootdeys">
															<div class="col-md-12">
																<div class="comment-wrapper">
																	<div class="card border-primary">
																		<div class="card-header bg-primary">
																			<span class="text-white">Réponses</span>
																			<div class="pull-right">
																				<label for="sele" class="text-white">Filtrer
																					Par:</label> <select id="filtreResponses"
																					name="filtreResponses">
																					<option>Récents</option>
																					<option>Best Rated</option>
																				</select>

																			</div>

																		</div>
																		<div class="card-body">
																			<button id="add_response"
																				class="btn btn-primary btn-sm" type="button"
																				data-toggle="collapse" data-target="#this"
																				aria-expanded="false" style="margin-bottom: 2px;">
																				Ajouter Réponse <i class="fa fa-caret-square-o-down"
																					aria-hidden="true"></i>
																			</button>
																			<form id="responseForm"
																				action="<%=request.getContextPath()%>/ResponseManagement"
																				method="post" autocomplete="off">
																				<div id="this" class="collapse"
																					style="margin-bottom: 50px">
																					<div class="form-group" hidden>
																						<input type="text" name="ticket_id" id="ticket_id"
																							value="" /> <input type="text"
																							name="usersession" id="usersession"
																							value="<%=session.getAttribute("username")%>"
																							hidden="1" /> <input type="text" name="action"
																							id="action" value="/CreateResponse" />
																					</div>

																					<textarea id="responseDetail" name="response"
																						class="form-control mb-1"
																						placeholder="Ajouter une Réponse..." rows="3"
																						required></textarea>
																					<span id="respBtn"></span>

																					<button type="submit"
																						class="btn btn-primary pull-right">Poster</button>
																				</div>
																			</form>
																			<div class="clearfix"></div>

																			<div class="response_list mt-3"></div>

																			<div class="responseScroll">
																				<ul class="media-list">


																				</ul>
																			</div>

																		</div>
																	</div>
																</div>

															</div>
														</div>

														<!-- End Ticket response comments -->
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-danger"
															data-dismiss="modal">
															<i class="fa fa-times"></i> Fermer
														</button>
													</div>

												</div>
											</div>
										</div>
									</div>
									<!-- END DETAIL TICKET -->
								</div>
								<!-- END TICKET CONTENT -->
							</div>
						</div>
					</div>
				</div>
				<!-- END TICKET -->




	<div id="semiTransparentDiv"></div>
</section>
	
	<jsp:include page="Footer.jsp"></jsp:include>
	<script src="resources/js/bootstrap-toggle.min.js"></script>
	<script src="resources/js/jquery.quicksearch.js"></script>
	<script src="resources/js/jquery.twbsPagination.min.js"></script>
	<script src="resources/js/ticketTemplate.js"></script>
</body>
</html>