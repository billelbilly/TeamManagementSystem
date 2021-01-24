	 $("#cardRadio").prop("checked", true);
	 $(".container-fluid").hide();
	 var detailsTicket = function(cell, formatterParams) {
			
			return '<button class="btn btn-primary btn-sm" data-toggle="tooltip" title="Détails du Tiquet"><i class="fa fa-info-circle fa-sm" style="color:white"></i></button>'

		};
		
   var responsesTicket = function(cell, formatterParams) {
	   var ticket_id = cell.getRow().getData(0)[0].toString();	
			return `
			<button  id="${ticket_id}" class="btn btn-primary btn-sm" data-toggle="modal" 
			data-target="#issueOfTableView"><i class="fa fa-comments"></i></button>`;

		};
		
     var attachment = function(cell, formatterParams) {
    	 var ticket_id = cell.getRow().getData(0)[0].toString();
    	 var attachPath = cell.getRow().getData(0)[7];
    	 if (attachPath!= null) {
    		 attachPath = cell.getRow().getData(0)[7].toString();
    		 return `<form action="/Helpdesk/DownloadAttachment" method="GET">
 			<input type="text" name="path" id="path-${ticket_id}"
 				value="${attachPath}" hidden/>
 			<button id="attachment-${ticket_id}" type="submit" class="btn btn-warning btn-sm pull-right" data-toggle="tooltip" title="Télécharger Attachement"  download><i class="fa fa-download"></i></button>
 			</form>`;

		  }
			
		};
		
		var Planification = function(cell, formatterParams) {
			var ticket_id = cell.getRow().getData(0)[0].toString();
	    	 var row = cell.getRow().getData(0)[3];
	    	  if ($("#userPermission").val()==3 || $("#userPermission").val()==1) {
	    		  $("#listPlanifBtnOfTableView").removeAttr("hidden");
			    	if (cell.getRow().getData(0)[3].toString()!=="fermer") {
			    		 return `<button 
			    		 id="planif-${ticket_id}" 
			    		 class="btn btn-sm btn-info pull-right mx-1 "
			    		  data-toggle="tooltip" title="Planifier Tiquet">
			    		  <i class="fa fa-calendar" style="pointer-events: none;"></i></button>`;
					}	    	
			    	
				}
	  
				
			};
		
		
		
		var editTicket = function(cell, formatterParams) {
			var id = cell.getRow().getData(0)[0].toString();
			return '<button id='
					+ id
					+ ' class=" open_modal btn btn-success btn-sm" data-toggle="modal" data-target="#updateIssueOfTableView" data-id='
					+ id
					+ ' data-toggle="tooltip" title="Editer Ticket"><i class="fa fa-edit fa-sm" style="color:white"></i></button>'

		};
		
		function showLoader() {
			document.getElementById("semiTransparentDiv").style.display="block";	
			}
		
		// Function to get list of Logiciel
		function getLogicielList() {

			$.ajax({
				type : "GET",
				url : "/Helpdesk/Settings",
				data : {
					action : "/getLogicielList"
				},
				// processData: false,
				// contentType: "text",
				dataType : "json",
				success : function(data) {

					$('#listLogicielOfTableView').empty();
					$('#listLogicielOfTableView').append(
							'<option>--Selectionnez--</option>');

					for (var i = 0; i < data.length; i++) {
						$('#listLogicielOfTableView').append(
								'<option value="' + data[i][0] + '">' + data[i][1]
										+ '</option>');

					}

					// Initialize select2
					//$("#listLogiciel").select2();

				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert("Erreur Serveur Veuillez contactez votre administrateur !");
				},
			});

		}
		getLogicielList();
		
		// ***********Function to Format the
		// CreationDateTime************//
		function getFormattedDate(datetoformat, opt) {
			var date = new Date(datetoformat);
			switch (opt) {
			case "ticket":
				 var str = date.getFullYear() + "-" + String(date.getMonth() + 1).padStart(2, '0') + "-" + String(date.getDate()).padStart(2, '0') + " " +  String(date.getHours()).padStart(2, '0') + ":" + String(date.getMinutes()).padStart(2, '0');
				break;
			case "resp":
				 var str = date.getFullYear() + "-" + String(date.getMonth() + 1).padStart(2, '0') + "-" + String(date.getDate()).padStart(2, '0') + " " +  String(date.getHours()).padStart(2, '0') + ":" + String(date.getMinutes()).padStart(2, '0');
				break;

			default:
				 var str = String(date.getDate()).padStart(2, '0') + "/" + String((date.getMonth() + 1)).padStart(2, '0') + "/" + date.getFullYear();
				break;
			}
		   
		    return str;
		}
		
	

	 function getTicketsTabulator() {
			
			
			var table = new Tabulator("#ticketTable", {
				height : "100%", 		
				locale:true,
			    langs:{
			        "fr-fr":{

			            "ajax":{
			                "loading":"Chargement ...", //ajax loader text
			                "error":"Erreur", //ajax error text
			            },

			            "pagination":{
			                "first":"Début", //text for the first page button
			                "first_title":"Premièr Page", //tooltip text for the first page button
			                "last":"Fin",
			                "last_title":"Dernièr Page",
			                "prev":"Précédent",
			                "prev_title":"Page Précédente",
			                "next":"Suivant",
			                "next_title":"Page Suivante",
			                "page_size":"Taille Page", //label for the page size select element
			            },

			        }
			    },
			    
				ajaxURL : "/Helpdesk/TicketManagement",
				ajaxParams:{
					usersession: $("#usersession").val(), 
				    action: "/getTickets"
				    },
				ajaxContentType : "application/json; charset=utf-8",
				ajaxContentType : "json",
				ajaxResponse : function(url, params, response) {
					// url - the URL of the request
					// params - the parameters passed with the request
					// response - the JSON object returned in the body of the response.

					var nbr_open = 0;
					var nbr_fermer = 0;
					var nbr_assign=0;
					var percent_open=0;
					var percent_closed=0;
					var percent_assigned=0;
					var Total_Ticket=response.ticket.length;
					response.ticket.forEach(function(ticket) {
						
						if (ticket[3] == "créé") {
							nbr_open++;

						} else if (ticket[3]=="fermer") {
							nbr_fermer++;
							
						}else {
							nbr_assign++;
							ticket[3]="assigné";
						}
						
						

					});
		            // Dump each Ticket number to The Interface.
					$("#nbr_open").text(nbr_open);
					$("#nbr_fermer").text(nbr_fermer);
					$("#nbr_assign").text(nbr_assign);
					
					if (Total_Ticket!=0) {
						// Dump each Ticket percentage to The Interface.
						percent_open=Math.round((nbr_open*100)/Total_Ticket);
						percent_closed=Math.round((nbr_fermer*100)/Total_Ticket);
						percent_assigned=Math.round((nbr_assign*100)/Total_Ticket);
					} 
					
					
					$("#percent_open_progress").css("width", percent_open*2);
					$("#percent_closed_progress").css("width", percent_closed*2);
					$("#percent_assigned_progress").css("width", percent_assigned*2);
					
					$("#percent_open").text(percent_open+"%");
					$("#percent_closed").text(percent_closed+"%");
					$("#percent_assigned").text(percent_assigned+"%");
					

					return response.ticket; // return the tableData property of a
												// response json object
				},
				ajaxError : function(xhr, textStatus, errorThrown) {
					alert("Error Occured !" + errorThrown);
				},
				// layout:"fitDataStretch", //fit columns to width of table (optional)
				layout : "fitColumns",

				columns : [
					
					// Define Table Columns
					{
						title : "N° Ticket",
						field : "0",
						headerFilter : true,
						headerFilterPlaceholder:"Recherche",
					},
				// Define Table Columns
				{
					title : "Objet",
					field : "1",
				// headerFilter : true
				},
				{
					formatter : detailsTicket,
					align : "center",
					title : "Détails",
					headerSort : false,
					cellClick : function(e, cell) {
						///********* Here Add All The Ticket Information That you want to be added **********///
						console.log("Ticket : "+cell.getRow().getData(0));
						var ticket_info;
						var creationDate=getFormattedDate(cell.getRow().getData(0)[5].toString());
					
						$("#Details").modal("show");
					   // Clear closing_info div from any paragraph first
						$("#ticket_info").empty();
						if (cell.getRow().getData(0)[3].toString()=="fermer") {
							
							var closingDate=getFormattedDate(cell.getRow().getData(0)[13].toString());
							ticket_info=`<p>créé par: <strong>@${cell.getRow().getData(0)[8].toString()}</strong>, le: <strong>${creationDate}</strong></p>
							 <p>Fermé par: <strong>@${cell.getRow().getData(0)[12].toString()}</strong> le: <strong>${closingDate}</strong></p>
							 <p>Logiciel & Version: <strong>${cell.getRow().getData(0)[9].toString()}, ${cell.getRow().getData(0)[10].toString()}</strong> </p>`;
							$("#ticket_info").html(ticket_info);
						}else if (cell.getRow().getData(0)[3].toString()=="créé") {
							ticket_info=`
								 <p>créé par: <strong>@${cell.getRow().getData(0)[8].toString()}</strong>, le: <strong>${creationDate}</strong></p>
								 <p>Logiciel & Version: <strong>${cell.getRow().getData(0)[9].toString()}, ${cell.getRow().getData(0)[10].toString()}</strong> </p>
								`;
								$("#ticket_info").html(ticket_info);
							
						}else {
							var assignDate=getFormattedDate(cell.getRow().getData(0)[14].toString());
							ticket_info=`<p>créé par: <strong>@${cell.getRow().getData(0)[8].toString()}</strong>, le: <strong>${creationDate}</strong></p>
								 <p>Assigné à: <strong>@${cell.getRow().getData(0)[11].toString()}</strong> le: <strong>${assignDate}</strong></p>
								 <p>Logiciel & Version: <strong>${cell.getRow().getData(0)[9].toString()}, ${cell.getRow().getData(0)[10].toString()}</strong> </p>
								`;
								$("#ticket_info").html(ticket_info);
						}
						
						$("#putDetail").text(cell.getRow().getData(0)[2].toString());
						
						///*********************************************************************************///

					}
				}

				, {
					title : "Etat",
					field : "3",
					headerFilter : true,
					headerFilterPlaceholder:"Recherche",

				}, {
					title : "Sévérité",
					field : "4",
					headerFilter : true,
					headerFilterPlaceholder:"Recherche",

				}, {
					title : "Date Création",
					field : "5",
					headerFilter : true,
					headerFilterPlaceholder:"Recherche",
					formatter : "datetime",
					formatterParams : {		
						outputFormat : "YYYY-MM-DD",
						invalidPlaceholder : "(invalid date format)",
					}
				}, {
					title : "créé Par",
					field : "6",
					visible : false,
				},
				{
					formatter : editTicket,
					align : "center",
					width : 51,
					headerSort : false,
					cellClick : function(e, cell) {
						var ticket_id = cell.getRow().getData(0)[0].toString();
						var objet=cell.getRow().getData(0)[1].toString();
						var detail=cell.getRow().getData(0)[2].toString();
						var etatTicket=cell.getRow().getData(0)[3].toString();
						var severity=cell.getRow().getData(0)[4].toString();

						$(".modal #ticket_id").val(ticket_id);
						$(".modal #objet").val(objet);
						$(".modal #detail").val(detail);
						$(".modal #severity").val(severity);
						
						if (etatTicket=="assigné") {
							$("#etat_ticket").remove("option");
							$("#etat_ticket").html("<option>fermer</otion><option>assigné</option>");
							$(".modal #etat_ticket").val(etatTicket);
						} else {
							$("#etat_ticket").remove("option");
							$("#etat_ticket").html("<option>créé</otion><option>fermer</option>");
							$(".modal #etat_ticket").val(etatTicket);

						}

						
					}
				}, 
			
 				{
 					formatter : Planification,
 	             	align : "center",
 					width : 60,
 					headerSort : false,
 					cellClick : function(e, cell) {
 						var ticket_id = cell.getRow().getData(0)[0].toString();
 						
 						
 						$("#PlanifModal").modal("show");
 					
 						///****** Call DatePicker
 						$('#PlanifModal').on('shown.bs.modal', function(e) {
 							$('.date-input').datepicker({ 
 								ClearBtn: true,
 								format: 'dd/mm/yyyy',
 								});
 						});
 			
 						$(".modal #ticket_id").val(ticket_id);	
 						$("#date_debut_planif").val('');
 					    $("#date_fin_planif").val('');
 					    $("#date_debut_realise").val('');
 					    $("#date_fin_realise").val('');
 					    $("#date_fin_realise").val('');
 					    $("#observation").val('');
 					    showLoader();
 						//Initialize The Form
 						
 					      $.ajax({
 								
 									type: "GET",
 									url: "/Helpdesk/TicketManagement",
 									data: { 
 									    ticket_id: ticket_id,   
 									    action: "/getPlanifByTicket"
 									  },
 						
 									dataType: "json",
 									success: function (data) {
 										$("#semiTransparentDiv").hide();
 										var objPlanif=data.ticketPlanif;
 										var isNotNull=false;
 										for(var prop in objPlanif) {
 										    if(objPlanif.hasOwnProperty(prop)) {
 										    	isNotNull=true;
 										    }
 										  }
 										if (isNotNull) {
 											//Init Planif Form Here
 											var dateDebutPlanif;
 											var dateFinPlanif;
 											var dateDebutRealise;
 											var dateFinRealise;
 											$.each(objPlanif, function(key, value) {
 												
 												dateDebutPlanif=getFormattedDate(value.dateDebutPlanif,"");
 												dateFinPlanif=getFormattedDate(value.dateFinPlanif,"");
 												dateDebutRealise=value.dateDebutRealise;
 												dateFinRealise=value.dateFinRealise;
 											    $("#date_debut_planif").val(dateDebutPlanif);
 											    $("#date_fin_planif").val(dateFinPlanif);
 											    if (dateDebutRealise!=undefined && dateFinRealise!=undefined) {
 											    	    $("#date_debut_realise").val(getFormattedDate(value.dateDebutRealise,""));
 													    $("#date_fin_realise").val(getFormattedDate(value.dateFinRealise,""));
 												}
 											   
 											    $("#observation").val(value.observation);
 											    
 											});
 										

 											
 										} else{
 											console.log("No planification for this Ticket !");
 										}
 									},
 									error: function (XMLHttpRequest, textStatus, errorThrown) {
 										$("#semiTransparentDiv").hide();
 										alert("Init Planif Form Server Error: "+errorThrown);
 									},
 							});
 						
 					}
 	 				},
 	 				
 	 				{
 	 					formatter : attachment,
 	 	             	align : "center",
 	 					width : 60,
 	 					headerSort : false,
 	 	 				},
 	 	 				{
 	 	 					formatter : responsesTicket,
 	 	 	             	align : "center",
 	 	 					width : 60,
 	 	 					headerSort : false,
 	 	 					cellClick : function(e, cell) {
 	 	 						var search_response=$('input.search_response').quicksearch('ul.media-list li');
 	 	 						var ticket_id = cell.getRow().getData(0)[0].toString();
 	 	 						var date=getFormattedDate(cell.getRow().getData(0)[5].toString(),"ticket");
 	 	 						var creator=cell.getRow().getData(0)[8].toString();
 	 	 						console.log("Creator:"+creator);
 	 	 						var detail=cell.getRow().getData(0)[2].toString();
 	 	 						console.log("Details: "+detail);
 	 	 					
 	 	 						var ticket_detail_header=`
 	 	 						<p>
 	 	 						  Tiquet <strong class="text-dark">#${ticket_id}</strong> créé par <strong class="text-dark"> @${creator}</strong>
 	 	 						   le: ${date}
 	 	 						</p>
 	 	 					    <p>${detail}</p>	
 	 	 						`;
 	 	 						$( "#ticket_detail_headerOfTableView p" ).remove();
 	 	 						$(".modal .media-list li").remove();
 	 	 						$('.response_list div').remove();
 	 	 						$('.ticket_list div').remove();
 	 	 						$('#ticket_detail_headerOfTableView').append(ticket_detail_header);
 	 	 						$(".modal #ticket_id").val(ticket_id);
 	 	 						$(".modal #responseDetail").val('');
 	 	 						
 	 	 						showLoader();
 	 	 						
 	 	 						
 	 	 						// ************ Get Responses By Ticket 
 	 	 						// Id****************//
 	 	 						
 	 	 						$.ajax({
 	 	 							type: "GET",
 	 	 							url: "/Helpdesk/ResponseManagement",
 	 	 							data: { 
 	 	 							    ticket_id: ticket_id,
 	 	 							    action: "/getResponses"
 	 	 							  },
 	 	 							dataType: "json",
 	 	 							
 	 	 							success: function (data) {
 	 	 								$("#semiTransparentDiv").hide();
 	 	 						
 	 	 								var objResponse=data.responses;
 	 	 								var userResponseSession;
 	 	 								
 	 	 								var isNotNull=false;
 	 	 								for(var prop in objResponse) {
 	 	 								    if(objResponse.hasOwnProperty(prop)) {
 	 	 								    	isNotNull=true;
 	 	 								    }
 	 	 								  }
 	 	 								
 	 	 								if (isNotNull) {
 	 	 					
 	 	 									
 	 	 									objResponse.forEach(function(response) {
 	 	 									    
 	 	 									    var date_creation_response=getFormattedDate(response[2],"resp");
 	 	 									    
 	 	 									  
 	 	 										var ticket_response=`
 	 	 										
 	 	 										<li class="media">
 	 	 											    <!--<input type="number" name="inputName" id="rating1" class="rating text-warning" data-clearable="remove"/>-->
 	 	 													<div class="media-body">
 	 	 													
 	 	 														<span class="text-muted pull-right"> <small
 	 	 															class="text-muted">Réponse le: ${date_creation_response}</small>
 	 	 														</span> <strong class="text-success">  @${response[3]}</strong>
 	 	 														<p>
 	 	 															${response[1]}
 	 	 															
 	 	 														</p>
 	 	 													</div>
 	 	 										
 	 	 									     </li>`;
 	 	 										
 	 	 										$( ".media-list" ).append(ticket_response);
 	 	 										
 	 	 									});
 	 	 									search_response.cache();
 	 	 								}else {

 	 	 									$('.response_list').append('<div class="alert alert-warning" role="alert">Pas de Réponses pour le moment !</div>');
 	 	 								}

 	 	 							},
 	 	 							error: function (XMLHttpRequest, textStatus, errorThrown) {
 	 	 								$("#semiTransparentDiv").hide();
 	 	 								alert("Error When getting Responses"+errorThrown);
 	 	 							},
 	 	 						});
 	 	 						// *****************************************************************//
 	 	 						
 	 	 					}
 	 	 	 				},

				],
				groupBy : "3",
				groupHeader : function(value, count, data, group) {
					// value - the value all members of this group share
					// count - the number of rows in this group
					// data - an array of all the row data objects in this group
					// group - the group component for the group
					if (value == "créé") {
						return "créé"
								+ "<span style='color:green; margin-left:10px;'>("
								+ count + " Tiquets)</span>";

					} else if(value =="fermer") {
						return "Fermer"
								+ "<span style='color:#d00; margin-left:10px;'>("
								+ count + " Tiquets)</span>";

					}else {
						return "Assigné"
						+ "<span style='color:#1cbfd0; margin-left:10px;'>("
						+ count + " Tiquets)</span>";
					}

				},

				placeholder : "Pas de Ticket Pour le Moment !",
				pagination : "local",
				paginationSize : 10,
				paginationSizeSelector : [ 25, 50, 100 ],
				printAsHtml : true,
			/*
			 * printHeader: "<h1>Example Table Header<h1>", printFooter: "<h2>Example
			 * Table Footer<h2>",
			 */
			});

		}
	 $('input[type=radio][name=inlineRadioOptions]').change(
				function() {
					if (this.value == 'card') {
						$(".cardCore").show();
						$(".cardHeader").show();
						$("#ticketTable").hide();
						$(".container-fluid").hide();

					} else if (this.value == 'table') {
						$(".cardCore").hide();
						$(".cardHeader").hide();
						$(".container-fluid").show();
						$("#ticketTable").show();
						getTicketsTabulator();
						
					} 
						
					
				});
	 
		// *************************** Submit Response ***************************//
		$("#responseFormOfTableView").submit(function(e) {
			e.preventDefault(); // avoid to execute the actual submit of the form to
			var form = $(this);
			var form_data = $("#responseFormOfTableView").serialize();
			showLoader();
			$.ajax({
				
				type: "POST",
				url: form.attr("action"),
				data: form_data, // serializes the form's elements.

				dataType: "json",
				success: function (data) {
					$("#semiTransparentDiv").hide();
						
					if (data.success) {
						$('.modal').modal('hide');
						$("body").removeClass("modal-open");
						$("div.modal-backdrop").remove();
						getTicketsTabulator();
						flash('Réponse Ajoutée Avec Succès', {

							// background color
							'bgColor': 'green',

							// text color
							'ftColor': 'white',

							// or 'top'
							'vPosition': 'top',

							// or 'left'
							'hPosition': 'right',

							// duration of animation
							'fadeIn': 400,
							'fadeOut': 400,

							// click to close
							'clickable': true,

							// auto hides after a duration time
							'autohide': true,

							// timout
							'duration': 4000

						});
					}else {
						alert("Error occured when saving the Response !");
					}

				},
				error: function (XMLHttpRequest, textStatus, errorThrown) {
					$("#semiTransparentDiv").hide();
					alert("Submit Response Error: "+errorThrown);
				},
			});
		});
		// *********************************************************************//
		
		// *************************** Update Ticket ***************************//
		$("#updateTicketFormOfTableView").submit(function(e) {
			e.preventDefault(); // avoid to execute the actual submit of the form to
			
			var form = $(this);
			var url = form.attr("action");
			var formData = new FormData($(this)[0]);
			showLoader();

			$.ajax({
				type : "POST",
				enctype : 'multipart/form-data',
				url : url,
				data : formData, // serializes the form's elements.
				processData : false,
				contentType: false,

				dataType: "json",
				success: function (data) {
					
					$("#semiTransparentDiv").hide();
					if (data.success) {	
						$('.modal').modal('hide');
						$("body").removeClass("modal-open");
						$("div.modal-backdrop").remove();
						getTicketsTabulator();
					}else {
						alert("Error occured when Updating Ticket!");
					}

				},
				error: function (XMLHttpRequest, textStatus, errorThrown) {
					$("#semiTransparentDiv").hide();
					alert("Update Ticket Error: "+errorThrown);
				},
			});
		});
		// *********************************************************************//
	 
	