
function getLogicielListChart() {

	$.ajax({
		type : "GET",
		url : "/Helpdesk/Settings",
		data : {
			action : "/getLogicielList"
		},

		dataType : "json",
		success : function(data) {

			$('#listLogicielChart').empty();
			$('#listLogicielChart').append(
			'<option>--Selectionnez--</option>');

			for (var i = 0; i < data.length; i++) {
				$('#listLogicielChart').append(
						'<option value="' + data[i][0] + '">' + data[i][1]
								+ '</option>');
			}

			// Initialize select2
			$("#listLogicielChart").select2();

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("Erreur Serveur Veuillez contactez votre administrateur !");
		},
	});

}
getLogicielListChart();


function successCallBack(data) {
	//BEGIN PIE CHART ============================================
	var pieCtx = document.getElementById('pie_chart');
	var pieData=data.nbrTickets;
	var pieChart = new Chart(pieCtx, {
	    type: 'pie',
	    data: {
	        labels: ['Fermés', 'Assignés', 'Créés'],
	        datasets: [{
	            data: pieData,
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.5)',
	                'rgba(54, 162, 235, 0.5)',
	                'rgba(75, 192, 192, 0.5)',
	       
	            ],
	            borderColor: [
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(75, 192, 192, 1)',
	              
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	      //Boolean - Whether we should show a stroke on each segment
	      segmentShowStroke: true,
	    
	      //String - The colour of each segment stroke
	      segmentStrokeColor: "#fff",
	    
	      //Number - The width of each segment stroke
	      segmentStrokeWidth: 1,
	    
	      //Number - The percentage of the chart that we cut out of the middle
	      percentageInnerCutout: 0, // This is 0 for Pie charts
	    
	      //Number - Amount of animation steps
	      animationSteps: 100,
	    
	      //String - Animation easing effect
	      animationEasing: "easeOutExpo",
	    
	      //Boolean - Whether we animate the rotation of the Doughnut
	      animateRotate: true,
	    
	      //Boolean - Whether we animate scaling the Doughnut from the centre
	      animateScale: false,
	    
	      //String - A legend template
	     // legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
	    
	       
	    }
	});
	//END PIE CHART ============================================

}
	$.ajax({
		type : "GET",
		url : "/Helpdesk/Statistics",
		data : {
			action : "/getNumberTickets"
		},
		dataType : "json",
		success : successCallBack,
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("Erreur Serveur Veuillez Contacter Votre Administrateur !");
		},
	});
	
	$("#listLogicielChart").on("change",function(){
		   var logiciel_id=$("#listLogicielChart").val();
		  if (logiciel_id!=="--Selectionnez--") {
				$.ajax({
					type : "GET",
					url : "/Helpdesk/Settings",
					data : {
						logiciel_id:logiciel_id,
						action : "/getVersionListByLogiciel"
					},
					// processData: false,
					// contentType: "text",
					dataType : "json",
					success : function(data) {

						$('#listVersionChart').empty();

						for (var i = 0; i < data.length; i++) {
							$('#listVersionChart').append(
							'<option value="' + data[i][0] + '">' + data[i][1]
									+ '</option>');

						}

						// Initialize select2
						$("#listVersionChart").select2();

					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						alert("Erreur Serveur Veuillez contactez votre administrateur !");
					},
				});
				
				//Here put Ajax To Fill the Bar Chart
				var version_id=$("#listVersionChart").val();
				console.log("Logiciel: "+logiciel_id);
				console.log("Version: "+version_id);
			
		}else {
			$("#listVersionChart").empty();
			}

		
	});
	


