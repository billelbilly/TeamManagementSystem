$(document).ready(function () {
	function showLoader() {
		document.getElementById("semiTransparentDiv").style.display="block";	
		}
	
	var message = function(cell, formatterParams) {
		
		return '<button class="btn btn-warning btn-sm"   data-toggle="tooltip" title="Ouvrir Message"><i class="fa fa-envelope fa-sm" style="color:white"></i></button>'

	};

	var deleteContact = function(cell, formatterParams) {
		var id = cell.getRow().getData(0)[0].toString();
		return '<button id='
				+ id
				+ ' class=" open_modal btn btn-danger btn-sm" data-toggle="modal" data-target="#delete_contact_modal" data-id='
				+ id
				+ ' data-toggle="tooltip" title="Supprimer Contact"><i class="fa fa-trash fa-sm" style="color:white"></i></button>'

	};
	
	function getContactTabulator() {
		// create Tabulator on DOM element with id "example-table"
		var table = new Tabulator("#contactList", {
			height : "100%", // set height of table (in CSS or here), this
								// enables
			// the Virtual DOM and improves render speed
			// dramatically (can be any valid css height value)
			// data:get_data, //assign data to table
			ajaxURL : "/Helpdesk/Contacts",
			ajaxParams:{action:"/getContacts"},
			ajaxContentType : "application/json; charset=utf-8",
			ajaxContentType : "json",
			ajaxResponse : function(url, params, response) {
				// url - the URL of the request
				// params - the parameters passed with the request
				// response - the JSON object returned in the body of the response.

			

				return response.contacts; // return the tableData property of a
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
				title : "Nom",
				field : "1",
				headerFilter : true,
				headerFilterPlaceholder:"Recherche",
			}, {
				title : "Email",
				field : "2",
				headerFilter : true,
				headerFilterPlaceholder:"Recherche",
			}, {
				title : "Objet",
				field : "3",
				headerSort : false,

			}, {
				formatter : message,
				align : "center",
				title : "Message",
				headerSort : false,
				cellClick : function(e, cell) {
					$("#Message").modal("show");
					$("#putMessage").text(cell.getRow().getData(0)[4].toString());

				}
			},
			{
				formatter : deleteContact,
				align : "center",
				width : 51,
				headerSort : false,
				cellClick : function(e, cell) {
					var id = cell.getRow().getData(0)[0].toString();
					$(".modal-footer #contact_id").val(id);

				}
			}
			],


			placeholder : "Pas De Contact pour le moment !",
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
	getContactTabulator();



$("#idForm").submit(function (e) {
	e.preventDefault(); // avoid to execute the actual submit of the form.

	var form = $(this);
	var url = form.attr("action");
	var form_data = $("#idForm").serialize();
	showLoader();
	
	$.ajax({
		type: "POST",
		url: url,
		data: form_data, // serializes the form's elements.
		processData: false,
		//contentType: "text",
		dataType: "json",
		success: function (data) {
			
		
			$("#semiTransparentDiv").hide();


		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			$("#semiTransparentDiv").hide();
			alert(errorThrown);
		},
	});
});

$("#DeleteContactForm").submit(function(e) {
	e.preventDefault(); // avoid to execute the actual submit of the form.

	var form = $(this);
	var url = form.attr("action");
	var form_data = $("#DeleteContactForm").serialize();
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
				getContactTabulator();
				$('.modal').modal('hide');
				$("body").removeClass("modal-open");
				$("div.modal-backdrop").remove();

			} else {
				alert("Delete Contact Failed !");
			}

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			$("#semiTransparentDiv").hide();
			alert("Error Occured when Deleting the Contact: " + errorThrown);
		},
	});
});




});