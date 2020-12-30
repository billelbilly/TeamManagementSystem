/*
 *  ticketId => cell.getRow().getData(0)[0]
 *  Objet => cell.getRow().getData(0)[1]
 *  detail => cell.getRow().getData(0)[2]
 *  etat => cell.getRow().getData(0)[3]
 *  Severity => cell.getRow().getData(0)[4]
 *  date => cell.getRow().getData(0)[5]
 *  AssignedTo => cell.getRow().getData(0)[6]
 */

function showLoader() {
document.getElementById("semiTransparentDiv").style.display="block";	
}
var deleteTicket = function(cell, formatterParams) {
	var id = cell.getRow().getData(0)[0].toString();
	return '<button id='
			+ id
			+ ' class=" open_modal btn btn-danger btn-sm" data-toggle="modal" data-target="#delete_ticket_modal" data-id='
			+ id
			+ ' data-toggle="tooltip" title="Supprimer Tiquet"><i class="fa fa-trash fa-sm" style="color:white"></i></button>'

};

var assignTicket = function(cell, formatterParams) {
	var id = cell.getRow().getData(0)[0].toString();

	if (cell.getRow().getData(0)[6]!== null) {
		
		// return the assigned User
		return '<p>'+cell.getRow().getData(0)[6].toString()+'</p>'


	} else if(cell.getRow().getData(0)[3]==="fermer") {
		
		$("assign"+id+"").hide();
	}
	
	else{

		return '<button id=assign'+id+' class=" open_modal btn btn-info btn-sm btn-assign" data-toggle="modal" data-target="#assign_ticket_modal" data-id='
				+ id
				+ ' data-toggle="tooltip" title="Assigner Tiquet" onclick="getUsersEntreprise()"><i class="fa fa-tasks fa-sm" style="color:white"></i></button>'
	}

};

var detailsTicket = function(cell, formatterParams) {
	
	return '<button class="btn btn-primary btn-sm" data-toggle="tooltip" title="Détails du Tiquet"><i class="fa fa-info-circle fa-sm" style="color:white"></i></button>'

};

// Function to get list of Users Entreprise
function getUsersEntreprise() {

	$.ajax({
		type : "GET",
		url : "/Helpdesk/UserManagement",
		data : {
			action : "/getUsersEntreprise"
		},
		// processData: false,
		// contentType: "text",
		dataType : "json",
		success : function(data) {

			$('#userEntreprise').empty();

			for (var i = 0; i < data.length; i++) {
				$('#userEntreprise').append(
						'<option value="' + data[i][0] + '">' + data[i][5]
								+ '</option>');

			}

			// Initialize select2
			$("#userEntreprise").select2();

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("Error Occured when Populating UserEntreprise List: "
					+ errorThrown);
		},
	});

}
function getTicketsTabulator() {
	// create Tabulator on DOM element with id "example-table"
	var table = new Tabulator("#ticketList", {
		height : "100%", // set height of table (in CSS or here), this
							// enables
		// the Virtual DOM and improves render speed
		// dramatically (can be any valid css height value)
		// data:get_data, //assign data to table
		ajaxURL : "/Helpdesk/TicketManagement",
		ajaxParams:{action:"/getAllTickets"},
		ajaxContentType : "application/json; charset=utf-8",
		ajaxContentType : "json",
		ajaxResponse : function(url, params, response) {
			// url - the URL of the request
			// params - the parameters passed with the request
			// response - the JSON object returned in the body of the response.

			var nbr_open = 0;
			var nbr_fermer = 0;
			nbr_assign=0;
			response.tickets.forEach(function(ticket) {
				
				if (ticket[3] == "open") {
					nbr_open++;
					ticket[3]="crée";
				} else if (ticket[3]=="fermer") {
					nbr_fermer++;
					
				}else {
					nbr_assign++;
					ticket[3]="assigné";
				}
				
//				if (ticket[6]) {
//					nbr_assign++;	
//				}

			});

			$("#nbr_open").text(nbr_open);
			$("#nbr_fermer").text(nbr_fermer);
			$("#nbr_assign").text(nbr_assign);

			return response.tickets; // return the tableData property of a
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
		}, {
			formatter : detailsTicket,
			align : "center",
			title : "Détails",
			headerSort : false,
			cellClick : function(e, cell) {
				$("#Details").modal("show");
			// Clear closing_info div from any paragraph first
				if (cell.getRow().getData(0)[3].toString()=="fermer" &&  cell.getRow().getData(0)[7].toString()!="null") {
					var colosing_info=`<p>Fermé par: <strong>@${cell.getRow().getData(0)[7].toString()}</strong> le _/_/_</p>`;
					$("#closing_info").html(colosing_info);
				}
				
				$("#putDetail").text(cell.getRow().getData(0)[2].toString());

			}
		}, {
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
			sorter:"date",
			headerFilter : true,
			headerFilterPlaceholder:"Recherche",
			formatter : "datetime",
			formatterParams : {		
				outputFormat : "DD/MM/YYYY",
				invalidPlaceholder : "(invalid date format)",
			}
		}, {
			title : "Crée Par",
			field : "6",
			visible : false,
		}, {
			title : "Assign à",
			formatter : assignTicket,
			align : "center",
			headerSort : false,
			cellClick : function(e, cell) {
				var id = cell.getRow().getData(0)[0].toString();
				$(".modal-body #ticket_id").val(id);

			},
			
		}, 
		
		{
			formatter : deleteTicket,
			align : "center",
			width : 51,
			headerSort : false,
			cellClick : function(e, cell) {
				var id = cell.getRow().getData(0)[0].toString();
				$(".modal-footer #ticket_id").val(id);

			}
		},

		],
		groupBy : "3",
		groupHeader : function(value, count, data, group) {
			// value - the value all members of this group share
			// count - the number of rows in this group
			// data - an array of all the row data objects in this group
			// group - the group component for the group
			if (value == "crée") {
				return "Crée"
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
getTicketsTabulator();

$("#DeleteTicketForm").submit(function(e) {
	e.preventDefault(); // avoid to execute the actual submit of the form.

	var form = $(this);
	var url = form.attr("action");
	var form_data = $("#DeleteTicketForm").serialize();
	showLoader();

	$.ajax({
		type : "POST",
		url : url,
		data : form_data, // serializes the form's elements.
		processData : false,
		// contentType: "text",
		dataType : "json",
		success : function(data) {
			$("#semiTransparentDiv").hide();
			if (data.success) {
				getTicketsTabulator();
				$('.modal').modal('hide');
				$("body").removeClass("modal-open");
				$("div.modal-backdrop").remove();

			} else {
				alert("Delete Ticket Failed !");
			}

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			$("#semiTransparentDiv").hide();
			alert("Error Occured when Deleting the Ticket: " + errorThrown);
		},
	});
});

$("#AssignTicketForm").submit(function(e) {
	e.preventDefault(); // avoid to execute the actual submit of the form to the
						// server and use Ajax instead.

	var form = $(this);
	var url = form.attr("action");
	var form_data = $("#AssignTicketForm").serialize();
	showLoader();

	$.ajax({
		type : "POST",
		url : url,
		data : form_data, // serializes the form's elements.
		processData : false,
		// contentType: "text",
		dataType : "json",
		success : function(data) {
			$("#semiTransparentDiv").hide();

			if (data.success === "true") {

				$('.modal').modal('hide');
				$("body").removeClass("modal-open");
				$("div.modal-backdrop").remove();
				getTicketsTabulator();

			} else {
				console.log("Ticket Already Assigned !");
			}

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			$("#semiTransparentDiv").hide();
			alert("Assign Ticket Error: " + errorThrown);
		},
	});
});