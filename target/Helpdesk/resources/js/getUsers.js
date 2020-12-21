//create Tabulator on DOM element with id "example-table"
var table = new Tabulator("#usersList", {
	height : "100%", // set height of table (in CSS or here), this enables
						// the Virtual DOM and improves render speed
						// dramatically (can be any valid css height value)
	//data:get_data, //assign data to table
	ajaxURL : "/Helpdesk/getUsers",
	ajaxError : function(xhr, textStatus, errorThrown) {
		alert("Error Occured !");
	},
	// layout:"fitDataStretch", //fit columns to width of table (optional)
	layout : "fitColumns",

	columns : [
	// Define Table Columns
	{
		title : "First Name",
		field : "0",
		headerFilter : true
	}, {
		title : "Last Name",
		field : "1",
		headerFilter : true
	}, {
		title : "Email",
		field : "2",
		headerFilter : true,

	}, {
		title : "Phone",
		field : "3",
		headerFilter : true,

	},

	{
		title : "Username",
		field : "4",
		headerFilter : true
	},
	{
		title : "Password",
		field : "5",
		headerFilter : true
	},
  ],
	//groupBy : "3",
	placeholder : "No Data Set",
	pagination : "local",
	paginationSize : 5,
	paginationSizeSelector : [ 25, 50, 100 ],
	printAsHtml : true,
/*
 * printHeader: "<h1>Example Table Header<h1>", printFooter: "<h2>Example
 * Table Footer<h2>",
 */
});
//table.setData("/getUsers");


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