var validateIcon = function(cell, formatterParams) {
	if (cell.getRow().getData(0)[6] == 0) {
		var id = cell.getRow().getData(0)[0].toString();
		return '<button id='
				+ id
				+ ' class=" open_modal btn btn-success btn-sm" data-toggle="modal" data-target="#validate_user_modal" data-id='
				+ id
				+ ' data-toggle="tooltip" title="Validater User"><i class="fa fa-check fa-sm" style="color:white"></i> Valider</button>'

	} else {
		return '<img src="resources/images/Check_24x24.png" alt="IMG">';
	}

};

var deleteUser = function(cell, formatterParams) {
	var id = cell.getRow().getData(0)[0].toString();
	return '<button id='
			+ id
			+ ' class=" open_modal btn btn-danger btn-sm" data-toggle="modal" data-target="#delete_user_modal" data-id='
			+ id
			+ ' data-toggle="tooltip" title="Delete User"><i class="fa fa-trash fa-sm" style="color:white"></i></button>'

};

var editUser = function(cell, formatterParams) {
	var id = cell.getRow().getData(0)[0].toString();
	return '<button id='
			+ id
			+ ' class=" open_modal btn btn-info btn-sm" data-toggle="modal" data-target="#edit_user_modal" data-id='
			+ id
			+ ' data-toggle="tooltip" title="Editer User"><i class="fa fa-edit fa-sm" style="color:white"></i></button>'

};

function showLoader() {
	document.getElementById("semiTransparentDiv").style.display = "block";
}

// ***********Function to Format the
// CreationDateTime************//
function getFormattedDate(datetoformat) {
	var date = new Date(datetoformat);
	var str = String(date.getDate()).padStart(2, '0') + "/"
			+ String((date.getMonth() + 1)).padStart(2, '0') + "/"
			+ date.getFullYear();

	return str;
}

function getUsersTabulator() {
	// create Tabulator on DOM element with id "example-table"
	var table = new Tabulator("#usersList", {
		height : "100%", // set height of table (in CSS or here), this
							// enables
		// the Virtual DOM and improves render speed
		// dramatically (can be any valid css height value)
		// data:get_data, //assign data to table
		ajaxURL : "/Helpdesk/UserManagement",
		ajaxParams : {
			action : "/getAllUsers"
		},
		ajaxResponse : function(url, params, response) {
			// url - the URL of the request
			// params - the parameters passed with the request
			// response - the JSON object returned in the body of the response.



			return response; // return the tableData property of a response
								// json object
		},
		ajaxError : function(xhr, textStatus, errorThrown) {
			alert("Error Occured !");
		},
		// layout:"fitDataStretch", //fit columns to width of table (optional)
		layout : "fitColumns",

		columns : [
				// Define Table Columns
				{
					title : "Prénom",
					field : "1",
					headerFilter : true,
					headerFilterPlaceholder : "Recherche",
				},
				{
					title : "Nom",
					field : "2",
					headerFilter : true,
					headerFilterPlaceholder : "Recherche",
				},
				{
					title : "Email",
					field : "3",
					headerFilter : true,
					headerFilterPlaceholder : "Recherche",

				},
				{
					title : "Téléphone",
					field : "4",
					headerFilter : true,
					headerFilterPlaceholder : "Recherche",

				},
				{
					title : "Username",
					field : "5",
					headerFilter : true,
					headerFilterPlaceholder : "Recherche",
				},
				{
					title : "Type User",
					field : "6",
					visible : false,
				},
				// {
				// formatter:validateIcon, align:"center",title:
				// "Validé",headerSort: false, cellClick:function(e, cell){
				//				
				// var id=cell.getRow().getData(0)[0].toString();
				// $(".modal-body #username_id").val(id);
				//	            
				//			
				// }
				// },

				{
					formatter : deleteUser,
					align : "center",
					width : 51,
					headerSort : false,
					cellClick : function(e, cell) {
						var id = cell.getRow().getData(0)[0].toString();
						$(".modal-footer #username_id").val(id);

					}
				},

				{
					formatter : editUser,
					align : "center",
					width : 51,
					headerSort : false,
					cellClick : function(e, cell) {
						var user_id = cell.getRow().getData(0)[0].toString();
						var prenom_id = cell.getRow().getData(0)[1].toString();
						var nom_id = cell.getRow().getData(0)[2].toString();
						var email_id = cell.getRow().getData(0)[3].toString();
						var phone_id = cell.getRow().getData(0)[4].toString();
						var username_id = cell.getRow().getData(0)[5]
								.toString();
						var userType_id = cell.getRow().getData(0)[6]
								.toString();
						var dateExpiration = cell.getRow().getData(0)[7];
						dateExpiration=String(dateExpiration.day).padStart(2, '0')+
						"/"+String(dateExpiration.month).padStart(2, '0')+
						"/"+dateExpiration.year;

						$(".modal-body #user_id").val(user_id);
						$(".modal-body #prenom_id").val(prenom_id);
						$(".modal-body #nom_id").val(nom_id);
						$(".modal-body #email_id").val(email_id);
						$(".modal-body #phone_id").val(phone_id);
						$(".modal-body #username_id").val(username_id);
						$(".modal-body #userType_id").val(userType_id);
						$(".modal-body #date_expiration_compte_EditUser").val(
								dateExpiration);

					}
				} ],
		groupBy : "6",
		groupHeader : function(value, count, data, group) {
			// value - the value all members of this group share
			// count - the number of rows in this group
			// data - an array of all the row data objects in this group
			// group - the group component for the group
			if (value == "1") {
				value = "Admins"

			} else if (value == "2") {
				value = "Client";
			} else {
				value = "User Entreprise";
			}

			return value + "<span style='color:#d00; margin-left:10px;'>("
					+ count + " Utilisateurs)</span>";
		},
		placeholder : "Pas d'utilisateur pour le moment !",
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
getUsersTabulator();

/*
 * 
 * //trigger download of data.xlsx file document
 * .getElementById("download-xlsx") .addEventListener("click", function () {
 * table.download("xlsx", "data.xlsx", { sheetName: "List Débit" }); });
 * 
 * //trigger download of data.pdf file document .getElementById("download-pdf")
 * .addEventListener("click", function () { table.download("pdf", "data.pdf", {
 * orientation: "portrait", //set page orientation to portrait title: "List
 * Débit", //add title to report }); });
 * 
 * //print button document .getElementById("print-table")
 * .addEventListener("click", function () { table.print(false, true); });
 */

$("#validateForm")
		.submit(
				function(e) {
					e.preventDefault(); // avoid to execute the actual submit of
										// the form to the server and use Ajax
										// instead.

					var form = $(this);
					var url = form.attr("action");
					var form_data = $("#validateForm").serialize();
					showLoader();

					$
							.ajax({
								type : "POST",
								url : url,
								data : form_data, // serializes the form's
													// elements.
								processData : false,
								// contentType: "text",
								dataType : "json",
								success : function(data) {
									$("#semiTransparentDiv").hide();

									if (data.success) {
										getUsersTabulator();

										$('.modal').modal('hide');
										$("body").removeClass("modal-open");
										$("div.modal-backdrop").remove();

										$("#" + data.id)
												.replaceWith(
														'<img src="resources/images/Check_24x24.png" alt="IMG">');

									} else {
										alert("Validation Failed !");
									}

								},
								error : function(XMLHttpRequest, textStatus,
										errorThrown) {
									$("#semiTransparentDiv").hide();
									alert(errorThrown);
								},
							});
				});

$("#DeleteUserForm").submit(function(e) {
	e.preventDefault(); // avoid to execute the actual submit of the form.

	var form = $(this);
	var url = form.attr("action");
	var form_data = $("#DeleteUserForm").serialize();
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
				getUsersTabulator();
				getTicketsTabulator();
				$('.modal').modal('hide');
				$("body").removeClass("modal-open");
				$("div.modal-backdrop").remove();

			} else {
				alert("Delete User Failed !");
			}

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			$("#semiTransparentDiv").hide();
			alert(errorThrown);
		},
	});
});

$("#editForm").submit(function(e) {
	e.preventDefault(); // avoid to execute the actual submit of the form.

	var form = $(this);
	var url = form.attr("action");
	var form_data = $("#editForm").serialize();
	showLoader();

	$.ajax({
		type : "POST",
		url : url,
		data : form_data, // serializes the form's elements.
		processData : false,
		// contentType: "text",
		dataType : "text",
		success : function(data) {
			$("#semiTransparentDiv").hide();

			if (data == "userupdated") {
				getUsersTabulator();
				$('.modal').modal('hide');
				$("body").removeClass("modal-open");
				$("div.modal-backdrop").remove();
				// location.reload(true);
			} else if (data == "usernameexist") {
				$("input").change(function() {
					$("#username_id").css("border", "");
				}).trigger("change");
				$("#username_id").css("border", "1px solid red");
				flash('Utilisateur existe déjà !', {

					// background color
					'bgColor' : 'red',

					// text color
					'ftColor' : 'white',

					// or 'top'
					'vPosition' : 'top',

					// or 'left'
					'hPosition' : 'right',

					// duration of animation
					'fadeIn' : 400,
					'fadeOut' : 400,

					// click to close
					'clickable' : true,

					// auto hides after a duration time
					'autohide' : true,

					// timout
					'duration' : 4000

				});

			} else if (data == "emailexist") {
				$("input").change(function() {
					$("#email_id").css("border", "");
				}).trigger("change");
				$("#email_id").css("border", "1px solid red");
				flash('Email Exist déjà !', {

					// background color
					'bgColor' : 'red',

					// text color
					'ftColor' : 'white',

					// or 'top'
					'vPosition' : 'top',

					// or 'left'
					'hPosition' : 'right',

					// duration of animation
					'fadeIn' : 400,
					'fadeOut' : 400,

					// click to close
					'clickable' : true,

					// auto hides after a duration time
					'autohide' : true,

					// timout
					'duration' : 4000

				});
			} else {
				alert("Update User Failed !")
			}

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			$("#semiTransparentDiv").hide();
			alert(errorThrown);
		},
	});
});


//Show List of Users Div here
$("#gestionUtilisateur").on("click",function(){
	$("#usersListDiv").removeAttr("hidden");

})

