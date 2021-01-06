
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
$('.date-input').datepicker({
	ClearBtn : true,
	format : 'dd/mm/yyyy',
});

$('#date_expiration_compte').datepicker({
	ClearBtn : true,
	format : 'dd/mm/yyyy',
	startDate: getSystemDate(),
});

