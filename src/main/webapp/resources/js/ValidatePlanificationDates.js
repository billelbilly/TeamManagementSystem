function process(date){
	   var parts = date.split("/");
	   return new Date(parts[2], parts[1] - 1, parts[0]);
	}

var dateDebutPlanif;
var dateFinPlanif;
var dateDebutRealise;
var dateFinRealise;

$("#date_debut_planif").on("change",function(){
	var dateDebutPlanif=$("#date_debut_planif").val();
	var dateFinPlanif=$("#date_fin_planif").val();
	var dateDebutRealise=$("#date_debut_realise").val();
	var dateFinRealise=$("#date_fin_realise").val();
	var planif_submit_btn = document.getElementById("planifTicketByUserOrAdmin")
	.hasAttribute("disabled");
	if (planif_submit_btn) {
		$("#planifTicketByUserOrAdmin").attr('disabled', false);
	}
	
	$("#date_debut_planif").css("border", "");
	$("#date_fin_planif").css("border", "");
	$("#date_debut_realise").css("border", "");
	$("#date_fin_realise").css("border", "");
//	debugger;
	
	
		if (process(dateFinPlanif) < process(dateDebutPlanif)) {
			$("#date_fin_planif").css("border", "1px solid red");
			$("#date_fin_planif").val('');
			$("#date_fin_planif").attr("placeholder", "Date invalide");
			$("#planifTicketByUserOrAdmin").attr('disabled', true);
		}
		
		else if (process(dateFinRealise) < process(dateDebutRealise)) {
			$("#date_fin_realise").css("border", "1px solid red");
			$("#date_fin_realise").val('');
			$("#date_fin_realise").attr("placeholder", "Date invalide");
			$("#planifTicketByUserOrAdmin").attr('disabled', true);
		}

	
});

$("#date_fin_planif").on("change",function(){
	var dateDebutPlanif=$("#date_debut_planif").val();
	var dateFinPlanif=$("#date_fin_planif").val();
	var dateDebutRealise=$("#date_debut_realise").val();
	var dateFinRealise=$("#date_fin_realise").val();
	var planif_submit_btn = document.getElementById("planifTicketByUserOrAdmin")
	.hasAttribute("disabled");
	if (planif_submit_btn) {
		$("#planifTicketByUserOrAdmin").attr('disabled', false);
	}
	
	$("#date_debut_planif").css("border", "");
	$("#date_fin_planif").css("border", "");
	$("#date_debut_realise").css("border", "");
	$("#date_fin_realise").css("border", "");
//	debugger;
	
	
		if (process(dateFinPlanif) < process(dateDebutPlanif)) {
			$("#date_fin_planif").css("border", "1px solid red");
			$("#date_fin_planif").val('');
			$("#date_fin_planif").attr("placeholder", "Date invalide");
			$("#planifTicketByUserOrAdmin").attr('disabled', true);
		}
		
		else if (process(dateFinRealise) < process(dateDebutRealise)) {
			$("#date_fin_realise").css("border", "1px solid red");
			$("#date_fin_realise").val('');
			$("#date_fin_realise").attr("placeholder", "Date invalide");
			$("#planifTicketByUserOrAdmin").attr('disabled', true);
		}
	
});

$("#date_debut_realise").on("change",function(){
	var dateDebutPlanif=$("#date_debut_planif").val();
	var dateFinPlanif=$("#date_fin_planif").val();
	var dateDebutRealise=$("#date_debut_realise").val();
	var dateFinRealise=$("#date_fin_realise").val();
	var planif_submit_btn = document.getElementById("planifTicketByUserOrAdmin")
	.hasAttribute("disabled");
	if (planif_submit_btn) {
		$("#planifTicketByUserOrAdmin").attr('disabled', false);
	}
	
	$("#date_debut_planif").css("border", "");
	$("#date_fin_planif").css("border", "");
	$("#date_debut_realise").css("border", "");
	$("#date_fin_realise").css("border", "");
//	debugger;
	
	
		if (process(dateFinPlanif) < process(dateDebutPlanif)) {
			$("#date_fin_planif").css("border", "1px solid red");
			$("#date_fin_planif").val('');
			$("#date_fin_planif").attr("placeholder", "Date invalide");
			$("#planifTicketByUserOrAdmin").attr('disabled', true);
		}
		
		else if (process(dateFinRealise) < process(dateDebutRealise)) {
			$("#date_fin_realise").css("border", "1px solid red");
			$("#date_fin_realise").val('');
			$("#date_fin_realise").attr("placeholder", "Date invalide");
			$("#planifTicketByUserOrAdmin").attr('disabled', true);
		}
	
});

$("#date_fin_realise").on("change",function(){
	var dateDebutPlanif=$("#date_debut_planif").val();
	var dateFinPlanif=$("#date_fin_planif").val();
	var dateDebutRealise=$("#date_debut_realise").val();
	var dateFinRealise=$("#date_fin_realise").val();
	var planif_submit_btn = document.getElementById("planifTicketByUserOrAdmin")
	.hasAttribute("disabled");
	if (planif_submit_btn) {
		$("#planifTicketByUserOrAdmin").attr('disabled', false);
	}
	
	$("#date_debut_planif").css("border", "");
	$("#date_fin_planif").css("border", "");
	$("#date_debut_realise").css("border", "");
	$("#date_fin_realise").css("border", "");
//	debugger;
	
	if (process(dateFinPlanif) < process(dateDebutPlanif)) {
		$("#date_fin_planif").css("border", "1px solid red");
		$("#date_fin_planif").val('');
		$("#date_fin_planif").attr("placeholder", "Date invalide");
		$("#planifTicketByUserOrAdmin").attr('disabled', true);
	}
	
	else if (process(dateFinRealise) < process(dateDebutRealise)) {
		$("#date_fin_realise").css("border", "1px solid red");
		$("#date_fin_realise").val('');
		$("#date_fin_realise").attr("placeholder", "Date invalide");
		$("#planifTicketByUserOrAdmin").attr('disabled', true);
	}
});