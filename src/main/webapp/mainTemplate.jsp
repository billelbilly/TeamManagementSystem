<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Ticket Dashboard</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/tabulator_bootstrap4.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/datepicker.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/styleTemplate.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap-toggle.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/ResetPassword.css">



<style type="text/css">
body {
	margin-top: 20px;
	background: #eee;
}

.padding {
	padding: 10px;
}

/* GRID */
.col {
	padding: 10px 20px;
	margin-bottom: 10px;
	background: #fff;
	color: #666666;
	text-align: center;
	font-weight: 400;
	box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.1);
}

.row h3 {
	color: #666666;
}

.row.grid {
	margin-left: 0;
}

.grid {
	position: relative;
	width: 100%;
	background: #fff;
	color: #666666;
	border-radius: 2px;
	margin-bottom: 25px;
	box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.1);
}

.grid .grid-header {
	position: relative;
	border-bottom: 1px solid #ddd;
	padding: 15px 10px 10px 20px;
}

.grid .grid-header:before, .grid .grid-header:after {
	display: table;
	content: " ";
}

.grid .grid-header:after {
	clear: both;
}

.grid .grid-header span, .grid .grid-header>.fa {
	display: inline-block;
	margin: 0;
	font-weight: 300;
	font-size: 1.5em;
	float: left;
}

.grid .grid-header span {
	padding: 0 5px;
}

.grid .grid-header>.fa {
	padding: 5px 10px 0 0;
}

.grid .grid-header>.grid-tools {
	padding: 4px 10px;
}

.grid .grid-header>.grid-tools a {
	color: #999999;
	padding-left: 10px;
	cursor: pointer;
}

.grid .grid-header>.grid-tools a:hover {
	color: #666666;
}

.grid .grid-body {
	padding: 15px 20px 15px 20px;
	font-size: 0.9em;
	line-height: 1.9em;
}

.grid .full {
	padding: 0 !important;
}

.grid .transparent {
	box-shadow: none !important;
	margin: 0px !important;
	border-radius: 0px !important;
}

.grid.top.black>.grid-header {
	border-top-color: #000000 !important;
}

.grid.bottom.black>.grid-body {
	border-bottom-color: #000000 !important;
}

.grid.top.blue>.grid-header {
	border-top-color: #007be9 !important;
}

.grid.bottom.blue>.grid-body {
	border-bottom-color: #007be9 !important;
}

.grid.top.green>.grid-header {
	border-top-color: #00c273 !important;
}

.grid.bottom.green>.grid-body {
	border-bottom-color: #00c273 !important;
}

.grid.top.purple>.grid-header {
	border-top-color: #a700d3 !important;
}

.grid.bottom.purple>.grid-body {
	border-bottom-color: #a700d3 !important;
}

.grid.top.red>.grid-header {
	border-top-color: #dc1200 !important;
}

.grid.bottom.red>.grid-body {
	border-bottom-color: #dc1200 !important;
}

.grid.top.orange>.grid-header {
	border-top-color: #f46100 !important;
}

.grid.bottom.orange>.grid-body {
	border-bottom-color: #f46100 !important;
}

.grid.no-border>.grid-header {
	border-bottom: 0px !important;
}

.grid.top>.grid-header {
	border-top-width: 4px !important;
	border-top-style: solid !important;
}

.grid.bottom>.grid-body {
	border-bottom-width: 4px !important;
	border-bottom-style: solid !important;
}

/* SUPPORT TICKET */
.support ul {
	list-style: none;
	padding: 0px;
}

.support ul li {
	padding: 8px 10px;
}

.support ul li a {
	color: #999;
	display: block;
}

.support ul li a:hover {
	color: #666;
}

.support ul li.active {
	background: #0073b7;
}

.support ul li.active a {
	color: #fff;
}

.support ul.support-label li {
	padding: 2px 0px;
}

.support h2, .support-content h2 {
	margin-top: 5px;
}

.support-content .list-group li {
	padding: 15px 20px 12px 20px;
	cursor: pointer;
}

.support-content .list-group li:hover {
	background: #eee;
}

.support-content .fa-padding .fa {
	padding-top: 5px;
	width: 1.5em;
}

.support-content .info {
	color: #777;
	margin: 0px;
}

.support-content a {
	color: #111;
}

.support-content .info a:hover {
	text-decoration: underline;
}

.support-content .info .fa {
	width: 1.5em;
	text-align: center;
}

.support-content .number {
	color: #777;
}

.support-content img {
	margin: 0 auto;
	display: block;
}

.support-content .modal-body {
	padding-bottom: 0px;
}

.support-content-comment {
	padding: 10px 10px 10px 30px;
	background: #eee;
	border-top: 1px solid #ccc;
}

/* BACKGROUND COLORS */
.bg-red, .bg-yellow, .bg-aqua, .bg-blue, .bg-light-blue, .bg-green,
	.bg-navy, .bg-teal, .bg-olive, .bg-lime, .bg-orange, .bg-fuchsia,
	.bg-purple, .bg-maroon, bg-gray, bg-black, .bg-red a, .bg-yellow a,
	.bg-aqua a, .bg-blue a, .bg-light-blue a, .bg-green a, .bg-navy a,
	.bg-teal a, .bg-olive a, .bg-lime a, .bg-orange a, .bg-fuchsia a,
	.bg-purple a, .bg-maroon a, bg-gray a, .bg-black a {
	color: #f9f9f9 !important;
}

.bg-white, .bg-white a {
	color: #999999 !important;
}

.bg-red {
	background-color: #f56954 !important;
}

.bg-yellow {
	background-color: #f39c12 !important;
}

.bg-aqua {
	background-color: #00c0ef !important;
}

.bg-blue {
	background-color: #0073b7 !important;
}

.bg-light-blue {
	background-color: #3c8dbc !important;
}

.bg-green {
	background-color: #00a65a !important;
}

.bg-navy {
	background-color: #001f3f !important;
}

.bg-teal {
	background-color: #39cccc !important;
}

.bg-olive {
	background-color: #3d9970 !important;
}

.bg-lime {
	background-color: #01ff70 !important;
}

.bg-orange {
	background-color: #ff851b !important;
}

.bg-fuchsia {
	background-color: #f012be !important;
}

.bg-purple {
	background-color: #932ab6 !important;
}

.bg-maroon {
	background-color: #85144b !important;
}

.bg-gray {
	background-color: #eaeaec !important;
}

.bg-black {
	background-color: #222222 !important;
}

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

div.responseScroll { //
	background-color: lightblue;
	max-height: 200px;
	overflow: auto;
}
</style>

</head>
<body>

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



	<div class="container-md">
		<section class="content">
			<div class="row">

				<!-- BEGIN TICKET -->
				<div class="col-md-8 offset-2">
					<div class="grid support-content rounded">
						<div class="grid-body">
							<div class="d-flex justify-content-between">

								<h1 id="back" class="rounded-circle">
									<a href="panneauAdmin_new.jsp" data-toggle="tooltip"
										data-placement="top" title="Home"><i
										class="fa fa-arrow-circle-o-left"></i></a>
								</h1>
								<h4>
									<i class="fa fa-user-circle"></i> <small>@<%=session.getAttribute("username")%></small>
									<a id="logout" href="<%=request.getContextPath()%>/Logout"
										data-toggle="tooltip" data-placement="top" title="Logout"
										class="rounded"> <i class="fa fa-sign-out fa-lg"
										aria-hidden="true"></i></a>
								</h4>


							</div>
							
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

					

							<!-- BEGIN NEW TICKET -->

							<div class="modal fade" id="newIssue" tabindex="-1" role="dialog"
								aria-labelledby="newIssue" aria-hidden="true">

								<div class="modal-dialog">
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
														placeholder="Objet" required="required">
												</div>
												<div class="form-group input-group">
													<div class="input-group-prepend">
														<span class="input-group-text"> Sévérité </span>
													</div>
													<select name="severity" id="severity">
														<option>Critique</option>
														<option>Moyen</option>
														<option>Normale</option>

													</select>
													
													<div class="input-group-prepend pull-right">
														<span class="input-group-text"> Sévérité </span>
													</div>
													<select name="severity" id="severity">
														<option>Critique</option>
														<option>Moyen</option>
														<option>Normale</option>

													</select>
												</div>
												<div class="form-group">
													<textarea name="detail" class="form-control"
														placeholder="Détail du tiquet ou question"
														style="height: 120px;" required="required"></textarea>
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
			</div>
		</section>

		<div id="semiTransparentDiv"></div>
	</div>


	<!-- ----------------------------------------Update Ticket----------------------------------------- -->
	<div class="modal fade" id="updateIssue" tabindex="-1" role="dialog"
		aria-labelledby="newIssue" aria-hidden="true">

		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-blue">
					<h4 class="modal-title pull-left">
						<i class="fa fa-edit"></i> Editer Tiquet
					</h4>
				</div>
				<form id="updateTicketForm"
					action="<%=request.getContextPath()%>/TicketManagement"
					method="post" enctype="multipart/form-data">
					<div class="modal-body">
						<div class="form-group">
							<input id="ticket_id" name="ticket_id" type="text"
								class="form-control" value="" hidden>
						</div>
						<div class="form-group">
							<input id="action" name="action" type="text" class="form-control"
								value="/UpdateTicket" hidden> <input type="text"
								name="usersession" value="<%=session.getAttribute("username")%>" hidden/>
						</div>

						<div class="form-group">
							<input id="objet" name="subject" type="text" class="form-control"
								placeholder="Objet" required="required">
						</div>
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"> Sévérité </span>
							</div>
							<select name="severity" id="severity">
								<option>Critique</option>
								<option>Moyen</option>
								<option>Normale</option>

							</select>
						</div>
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"> Etat Tiquet </span>
							</div>
							<select name="etat_ticket" id="etat_ticket" required>
								<option>créé</option>
								<option>fermer</option>			
							</select>
						</div>
						<div class="form-group">
							<textarea id="detail" name="detail" class="form-control"
								placeholder="Détail du tiquet ou question"
								style="height: 120px;" required="required"></textarea>
						</div>
						<div class="form-group">
							<div id="bigFileUpdate" class="alert alert-danger" role="alert"
								hidden></div>
							<input id="fileUpdate" type="file" name="attachment">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">
							<i class="fa fa-times"></i> Annuler
						</button>
						<button id="saveTicketUpdate" type="submit"
							class="btn btn-primary pull-right">
							<i class="fa fa-pencil"></i> Update
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- --------------------------------------------------------------------------------------------------- -->

	<!-------------------------------Planification Ticket----------------------->
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<div class="modal fade" id="PlanifModal">

					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">
									<i class="fa fa-calendar fa-lg" aria-hidden="true"></i>
									Planification
								</h5>

							</div>

							<div class="modal-body">
								<div class="col-md-8 offset-2">
									<form id="planifForm"
										action="<%=request.getContextPath()%>/TicketManagement"
										method="POST" autocomplete="off">

										<div class="form-group">
											<input type="text" name="ticket_id" id="ticket_id" value=""
												hidden />
										</div>
										<div class="form-group">
											<input type="text" name="action" id="action"
												value="/PlanifyTicket" hidden />
										</div>
										<!-- Here put Planification DatePickers -->
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i
													class="fa fa-calendar" aria-hidden="true"></i>
												</span>
											</div>
											<input type="text" class="form-control date-input"
												id="date_debut_planif" name="date_debut_planif"
												placeholder="Date Début Planification" required>

										</div>

										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i
													class="fa fa-calendar" aria-hidden="true"></i>
												</span>
											</div>
											<input type="text" class="form-control date-input"
												id="date_fin_planif" name="date_fin_planif"
												placeholder="Date Fin Planification" required>

										</div>
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i
													class="fa fa-calendar" aria-hidden="true"></i>
												</span>
											</div>
											<input type="text" class="form-control date-input"
												id="date_debut_realise" name="date_debut_realise"
												placeholder="Date Début Réalisation">

										</div>
										<div class="form-group input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i
													class="fa fa-calendar" aria-hidden="true"></i>
												</span>
											</div>
											<input type="text" class="form-control date-input"
												id="date_fin_realise" name="date_fin_realise"
												placeholder="Date Fin Réalisation">

										</div>
										<div class="form-group">
											<textarea name="observation" class="form-control"
												id="observation" placeholder="Observation"
												style="height: 120px;"></textarea>
										</div>

										<button type="submit" class="btn btn-info btn-md">
											<i class="fa fa-check"></i> Planifier
										</button>
									</form>
								</div>



							</div>

							<div class="modal-footer">


								<button id="close_model" class="btn btn-danger btn-md"
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

	<!------------------------------- Liste des Planifications ----------------------->
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<div class="modal fade" id="planifList">

					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">

								<h5 class="modal-title">
									<i class="fa fa-calendar fa-lg" aria-hidden="true"></i> Liste
									des Planifications
								</h5>


							</div>

							<div class="modal-body">
								<div class="mb-1">
									<button id="download-xlsx" class="btn btn-success btn-sm">Télécharger
										XLSX</button>
									<button id="download-pdf" class="btn btn-danger btn-sm">Télécharger
										PDF</button>
								</div>

								<div id="listPlanif"></div>

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
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/xlsx.full.min.js"></script>
	<script src="resources/js/jspdf.min.js"></script>
	<script src="resources/js/jspdf.plugin.autotable.js"></script>
	<script src="resources/js/moment.min.js"></script>
	<script src="resources/js/tabulator.min.js"></script>
	<script src="resources/js/datepicker.js"></script>
	<script src="resources/js/jquery.quicksearch.js"></script>
	<script src="resources/js/rating.js"></script>
	<script src="resources/js/popper.js"></script>
	<script src="resources/js/flash.min.js"></script>
	<script src="resources/js/bootstrap-toggle.min.js"></script>
	<script src="resources/js/bootstrap4-rating-input.min.js"></script>
	<script src="resources/js/mainTemplate.js"></script>
	<script src="resources/js/jquery.twbsPagination.min.js"></script>
	<script src="resources/js/ticketTemplate.js"></script>
	
</html>