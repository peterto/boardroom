$(function() {
	if ($("#all_statuses").length > 0) {
		setTimeout(updateTableStatus, 5000);
		$("#alert_message a").click(function(){
			$("#alert_message").hide('fast');
		});
	}
});

function updateTableStatus () {
	var url = "/";
	
	$.getJSON(url, function(data) {
		for (var key in data) {
			var name = key;
			
			// First, get the image from the database
			var image = "/assets/"+data[name][0].image;
			
			// Now, make sure to remove white spaces because we do this on the front end
			id = name.replace(/ /g, '');
			
			// Check if the status image is different
			element = $("#"+id+" img.image0");
			if (element.attr("src") != image) {
				element.attr("src", image);
				$("#alert_message").hide();
				$("#alert_message h4").text("Status has changed for "+name+"!");
				$("#alert_message p").text(data[name][0].description);
				
				switch(data[name][0].status_name) {
					case 'Up':
					$("#alert_message").attr("class", "alert alert-success");
					break;
					
					case 'Down':
					$("#alert_message").attr("class", "alert alert-error");
					break;
					
					case 'Warning':
					$("#alert_message").attr("class", "alert");
					break;
					
					default:
					$("#alert_message").attr("class", "alert alert-info");
				}
				$("#alert_message").show('fast');
			}
		}
		
		setTimeout(updateTableStatus, 5000);
	});
	
}