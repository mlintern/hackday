// scripts.js

$.fn.serializeObject = function()
{
		var o = {};
		var a = this.serializeArray();
		$.each(a, function() {
				if (o[this.name] !== undefined) {
						if (!o[this.name].push) {
								o[this.name] = [o[this.name]];
						}
						o[this.name].push(this.value || '');
				} else {
						o[this.name] = this.value || '';
				}
		});
		return o;
};

// Prevent links with js-trigger class from firing
$('.js-trigger').on("click", function (event) {
	event.preventDefault();
});

// update progress bar
function updateProgress (data, className) {
	percentage = ( ( data["count"] / data["max"] ) * 100 );
	$( "." + className + " .progress-bar" ).width( percentage.toString() + "%" )
}

// check on population status
function getStatusCheck () {
	$.ajax({
		url: '/status/check',
		dataType: 'json',
		contentType: "application/json",
		success: function(data) {
			updateProgress(data["publishers"],"publishers-status");
			updateProgress(data["business_units"],"business-units-status");
			updateProgress(data["users"],"users-status");
			updateProgress(data["categories"],"categories-status");
			updateProgress(data["content_types"],"content-types-status");
			updateProgress(data["projects"],"projects-status");
			updateProgress(data["languages"],"languages-status");
			updateProgress(data["content"],"content-status");
		},
		error: function(data) {
			console.debug(data);
		}
	});
}

// Execute() - send form data
function execute() {
	url = "/go";
	data = $(".settings").serializeObject();
	$.ajax({
		url: url,
		data: JSON.stringify(data),
		dataType: 'json',
		contentType: "application/json",
		type: 'POST',
		success: function(response) {
			console.log(response);
		},
		error: function(response) {
			console.log(response);
		}
	});
	window.location.replace("/status");
}

if ( window.location.pathname == "/status" || window.location.pathname == "/status/" ) {
	setInterval(getStatusCheck, 2000);
}