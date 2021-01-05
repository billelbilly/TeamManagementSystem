function showLoader() {
		document.getElementById("semiTransparentDiv").style.display="block";
			
		}

/**
 * Option dropdowns. Slide toggle
 */
$(".option-heading").on(
		'click',
		function () {
			$(this).toggleClass('is-active').next(".option-content")
					.stop().slideToggle(500);
			showLoader();
	
			
			//Init Settings Form Here
		      $.ajax({
					
					type: "GET",
					url: "/Helpdesk/Settings",
					data: { 
					    action: "/getInitialSettings"
					  },
		
					dataType: "json",
					success: function (data) {
						$("#semiTransparentDiv").hide();
				        var settingsObj=data.settings;
				 		var isNotNull=false;
				 		for(var prop in settingsObj) {
				 		    if(settingsObj.hasOwnProperty(prop)) {
				 		    	isNotNull=true;
				 		    }
				 		  }
				 		if (isNotNull) {
				         $("#host").val(settingsObj.host);
				         $("#smtp").val(settingsObj.smtp);
				         $("#port").val(settingsObj.port);
				         $("#email").val(settingsObj.email);
				         $("#nom").val(settingsObj.nom);
				         $("#password").val(settingsObj.password);
				         $("#attchpath").val(settingsObj.attchpath);
				         
				         $('#host').attr('readonly', true);
				         $('#smtp').attr('readonly', true);
				         $('#port').attr('readonly', true);
				         $('#email').attr('readonly', true);
				         $('#nom').attr('readonly', true);
				         $('#password').attr('readonly', true);
				         $('#attchpath').attr('readonly', true);
				         $('#sauv').attr('disabled', 'disabled');
				 		}
					},
					error: function (XMLHttpRequest, textStatus, errorThrown) {
						$("#semiTransparentDiv").hide();
						alert("Init Settings Form Error: "+errorThrown);
					},
			});
			
			
		});



$("#MailingSettingForm").submit(function(e) {
		e.preventDefault(); // avoid to execute the actual submit of the form to
		var form = $(this);
		var form_data = $("#MailingSettingForm").serialize();
		showLoader();
		$.ajax({
			
			type: "POST",
			url: form.attr("action"),
			data: form_data, // serializes the form's elements.

			dataType: "json",
			success: function (data) {
				
				$("#semiTransparentDiv").hide();
				if (data.success==="true") {
					getParamTabulator();
					$('.modal').modal('hide');
					$("body").removeClass("modal-open");
					$("div.modal-backdrop").remove();
					
					flash('Paramétrage Sauvegardé Avec Succès !', {

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
					$('.modal').modal('hide');
					$("body").removeClass("modal-open");
					$("div.modal-backdrop").remove();
					
					flash('Paramétrage Echoué !', {

						// background color
						'bgColor': 'red',

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
				}

			},
			error: function (XMLHttpRequest, textStatus, errorThrown) {
				$("#semiTransparentDiv").hide();
				alert("Saving Settings Error: "+errorThrown);
			},
		});
	});

$("#EditMailingSettingForm").submit(function(e) {
	e.preventDefault(); // avoid to execute the actual submit of the form to
	var form = $(this);
	var form_data = $("#EditMailingSettingForm").serialize();
	showLoader();
	$.ajax({
		
		type: "POST",
		url: form.attr("action"),
		data: form_data, // serializes the form's elements.

		dataType: "json",
		success: function (data) {
			$("#semiTransparentDiv").hide();
			
		
			if (data.success==="true") {
				getParamTabulator();
				$('.modal').modal('hide');
				$("body").removeClass("modal-open");
				$("div.modal-backdrop").remove();
				
				flash('Paramétrage Edité Avec Succès !', {

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
				$('.modal').modal('hide');
				$("body").removeClass("modal-open");
				$("div.modal-backdrop").remove();
				
				flash('Paramétrage Echoué !', {

					// background color
					'bgColor': 'red',

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
			}

		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			$("#semiTransparentDiv").hide();
			alert("Etiting Settings Error: "+errorThrown);
		},
	});
});

var editParam = function(cell, formatterParams){ 
    var id=cell.getRow().getData(0)[0].toString();		
	return '<button id='+id+' class=" open_modal btn btn-info btn-sm" data-toggle="modal" data-target="#edit_param_modal" data-id='+id+' data-toggle="tooltip" title="Editer Paramètres"><i class="fa fa-edit fa-sm" style="color:white"></i></button>'

};


function getParamTabulator() {
	// create Tabulator on DOM element with id "example-table"
	var table = new Tabulator("#paramList", {
		height : "100%", // set height of table (in CSS or here), this
							// enables
		// the Virtual DOM and improves render speed
		// dramatically (can be any valid css height value)
		// data:get_data, //assign data to table
		ajaxURL : "/Helpdesk/Settings",
		ajaxParams:{action:"/getInitialSettingsList"},
		ajaxContentType : "application/json; charset=utf-8",
		ajaxContentType : "json",
		ajaxResponse : function(url, params, response) {
			// url - the URL of the request
			// params - the parameters passed with the request
			// response - the JSON object returned in the body of the response.
           
		

			return response.settings; // return the tableData property of a
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
			title : "Host",
			field : "1",
		
		}, {
			title : "Smtp",
			field : "2",

		}, {
			title : "Port",
			field : "3",
		

		},
		{
			title : "Email",
			field : "4",
			

		},
		{
			title : "Nom",
			field : "5",
			

		},
		{
			title : "Attachement",
			field : "6",
			

		},	
		{
			formatter:editParam, align:"center",width:51,headerSort: false, cellClick:function(e, cell){
				var settings_id=cell.getRow().getData(0)[0].toString();
				var host=cell.getRow().getData(0)[1].toString();
				var smtp=cell.getRow().getData(0)[2].toString();
				var port=cell.getRow().getData(0)[3].toString();
				var email=cell.getRow().getData(0)[4].toString();
				var nom=cell.getRow().getData(0)[5].toString();
				var attchpath=cell.getRow().getData(0)[6].toString();
				
	            $(".modal-body #settings_id").val(settings_id);
	            $(".modal-body #host").val(host);
	            $(".modal-body #smtp").val(smtp);
	            $(".modal-body #port").val(port);
	            $(".modal-body #email").val(email);
	            $(".modal-body #nom").val(nom);
	            $(".modal-body #attchpath").val(attchpath);
	        
	
			}
		}
		],


		placeholder : "Pas De Paramètrage pour le moment !",
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
getParamTabulator();