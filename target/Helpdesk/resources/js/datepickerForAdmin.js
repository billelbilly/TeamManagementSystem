
function getSystemDate() {
	var date = new Date();
	var systemDate =
		String(date.getDate()+1).padStart(2, '0')+ 
		"/" + 
		String((date.getMonth() + 1)).padStart(2, '0')
		+ 
		"/" + 
		date.getFullYear();
	return systemDate;	
}

function process(date){
	   var parts = date.split("/");
	   return new Date(parts[2], parts[1] - 1, parts[0]);
	}
$('.date-input').datepicker({
	ClearBtn : true,
	format : 'dd/mm/yyyy',
});

$('#date_expiration_compte').datepicker({
	ClearBtn : true,
	format : 'dd/mm/yyyy',
	startDate: getSystemDate(),
});

$('#date_expiration_compte_EditUser').datepicker({
	ClearBtn : true,
	format : 'dd/mm/yyyy',
	startDate: getSystemDate(),
});

$("#date_expiration_compte_EditUser").on("change",function(){

	var dateExpiration=$("#date_expiration_compte_EditUser").val();
	if (process(dateExpiration) < process(getSystemDate())) {
		$("#date_expiration_compte_EditUser").css("border", "1px solid red");
		$("#date_expiration_compte_EditUser").val('');
		$("#date_expiration_compte_EditUser").attr("placeholder", "Date D\'expiration doit être postérieure à aujourd\'hui");
	}else {
		$("#date_expiration_compte_EditUser").css("border", "");
	}
	
	
});

$("#date_expiration_compte").on("change",function(){

	var dateExpiration=$("#date_expiration_compte").val();
	if (process(dateExpiration) < process(getSystemDate())) {
		$("#date_expiration_compte").css("border", "1px solid red");
		$("#date_expiration_compte").val('');
		$("#date_expiration_compte").attr("placeholder", "Date D\'expiration Invalid");
	}else {
		$("#date_expiration_compte").css("border", "");
	}
	
	
});

