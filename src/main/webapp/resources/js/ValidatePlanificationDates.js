function process(date){
	   var parts = date.split("/");
	   return new Date(parts[2], parts[1] - 1, parts[0]);
	}

$("#date_debut_planif").on("change",function(){

	var dateExpiration=$("#date_debut_planif").val();
	if (process(dateExpiration) < process(getSystemDate())) {
		$("#date_debut_planif").css("border", "1px solid red");
		$("#date_debut_planif").val('');
		$("#date_debut_planif").attr("placeholder", "Date D\'expiration doit être postérieure à aujourd\'hui");
	}else {
		$("#date_debut_planif").css("border", "");
	}
	
	
});

$("#date_fin_planif").on("change",function(){

	var dateExpiration=$("#date_fin_planif").val();
	if (process(dateExpiration) < process(getSystemDate())) {
		$("#date_fin_planif").css("border", "1px solid red");
		$("#date_fin_planif").val('');
		$("#date_fin_planif").attr("placeholder", "Date D\'expiration doit être postérieure à aujourd\'hui");
	}else {
		$("#date_fin_planif").css("border", "");
	}
	
	
});

$("#date_debut_realise").on("change",function(){

	var dateExpiration=$("#date_debut_realise").val();
	if (process(dateExpiration) < process(getSystemDate())) {
		$("#date_debut_realise").css("border", "1px solid red");
		$("#date_debut_realise").val('');
		$("#date_debut_realise").attr("placeholder", "Date D\'expiration doit être postérieure à aujourd\'hui");
	}else {
		$("#date_debut_realise").css("border", "");
	}
	
	
});

$("#date_fin_realise").on("change",function(){

	var dateExpiration=$("#date_fin_realise").val();
	if (process(dateExpiration) < process(getSystemDate())) {
		$("#date_fin_realise").css("border", "1px solid red");
		$("#date_fin_realise").val('');
		$("#date_fin_realise").attr("placeholder", "Date D\'expiration doit être postérieure à aujourd\'hui");
	}else {
		$("#date_fin_realise").css("border", "");
	}
	
	
});