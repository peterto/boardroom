$(function() {
	if ($("#all_statuses").length > 0) {
		setTimeout(updateTableStatus, 5000);
		$("#alert_message").click(function(){
			$("#alert_message").hide('fast');
		});
	}
});

function updateTableStatus () {
	var url = "/";
	
	$.getJSON(url, function(data) {
		for (var key in data) {
			// First, get the image from the database
			var image = "/assets/"+data[key][0].image;
			
			// Now, make sure to remove white spaces because we do this on the front end
			key = key.replace(/ /g, '');
			
			// Check if the status image is different
			element = $("#"+key+" img.image0");
			if (element.attr("src") != image) {
				element.attr("src", image);
				$("#alert_message").show('fast');
			}
		}
		
		//setTimeout(updateTableStatus, 5000);
	});
}