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

$(".expander").on("click", function () {
	$(this).parent().find(".well").toggle();
	$(this).toggleClass("fa-plus");
	$(this).toggleClass("fa-minus");
})

function updateStatusData (data) {
	var html = '<div>Network Id: ' + data["network_id"] + '</div>';
	html += '<div>Params: </div><ul>';
	_.each(data["params"], function (value, name) {
		html += '<li>' + name + ': ' + value + '</li>';
	});
	html += '</ul>'
	html += '<div>Errors: </div><ol>';
	_.each(data["errors"], function (error) {
		html += '<li>' + JSON.stringify(error) + '</li>';
	});
	html += '</ol>'
	$('.page-header .well').html(html);
}

// update progress bar
function updateProgress (data, className) {
	var count = data["count"];
	var requested = data["max"];
	$( "." + className + " .progress-bar" ).html( count + " of " + requested );
	if ( count > requested ) { count = requested; }
	percentage = ( ( count / requested ) * 100 );
	$( "." + className + " .progress-bar" ).width( percentage.toString() + "%" )
	$( "." + className + " .well" ).html("");
	if ( percentage < 33 ) {
		$( "." + className + " .progress-bar" ).addClass("progress-bar-danger");
	} else if ( percentage > 99 ) {
		$( "." + className + " .progress-bar" ).removeClass("progress-bar-warning");
		$( "." + className + " .progress-bar" ).removeClass("progress-bar-danger");
		$( "." + className + " .progress-bar" ).removeClass("progress-bar-info");
		$( "." + className + " .progress-bar" ).addClass("progress-bar-success");
	} else if ( percentage > 66 ) {
		$( "." + className + " .progress-bar" ).removeClass("progress-bar-warning");
		$( "." + className + " .progress-bar" ).removeClass("progress-bar-danger");
		$( "." + className + " .progress-bar" ).addClass("progress-bar-info");
	} else {
		$( "." + className + " .progress-bar" ).removeClass("progress-bar-danger");
		$( "." + className + " .progress-bar" ).addClass("progress-bar-warning");
	}
	_.each(data["items"], function (item) {
		$( "." + className + " .well" ).append('<span class="label label-danger">' + item["name"] + '</span>')
	})
}

// check on population status
function getStatusCheck () {
	$.ajax({
		url: '/status/check',
		dataType: 'json',
		contentType: "application/json",
		success: function(data) {
			if ( data == false ) {
				window.location.replace("/error");
			} else {
				$(".loading").hide();
				updateStatusData(data);
				updateProgress(data["publishers"],"publishers-status");
				updateProgress(data["business_units"],"business-units-status");
				updateProgress(data["users"],"users-status");
				updateProgress(data["categories"],"categories-status");
				updateProgress(data["content_types"],"content-types-status");
				updateProgress(data["projects"],"projects-status");
				updateProgress(data["languages"],"languages-status");
				updateProgress(data["content"],"content-status");
			}
			if (data["all_done"]){
				console.log("All Done!")
				clearInterval(loop);
				var start = Math.round( new Date(data["start_time"]).getTime() );
				var end = Math.round( new Date(data["end_time"]).getTime() );
				$(".stopwatch").stopwatch({ "startTime":(end - start) }).stopwatch('stop');
			}
		},
		error: function(data) {
			console.debug(data);
		}
	});
}

// Execute() - send form data
function execute() {
	url = "/go";
	data = $(".settings, .secret-settings").serializeObject();
	if (data["DateMin"] > data["DateMax"]) {
		window.alert("Begin date needs to be greater than end date.");
	} else if ( ( data["DateMin"].length == 0 && data["DateMax"].length != 0 ) || ( data["DateMax"].length == 0 && data["DateMin"].length != 0 ) ) {
		window.alert("Both Begin and End Pub Dates must be set or neither.");
	} else {
		console.log(data);
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
		window.location.href = "/status";
	}
}

function playToggle(){
  document.getElementById('toggle').play();
}

function clearEmail(){
	$("#EmailAddress").val('');
}

function setDev() {
	$("#Server").val('https://dev.cpdm.oraclecorp.com');
	$("#PublisherDomain").val('dev.cpdm.oraclecorp.com');
	clearEmail();
}

function setTest() {
	$("#Server").val('https://app.test-cpdm.oraclecorp.com');
	$("#PublisherDomain").val('app.test-cpdm.oraclecorp.com');
	clearEmail();
}

function setProd() {
	$("#Server").val('https://app.compendium.com');
	$("#PublisherDomain").val('compendiumblog.com');
	clearEmail();
}

if ( window.location.pathname == "/status" || window.location.pathname == "/status/" ) {

	var loop = setInterval(getStatusCheck, 5000);

	$.ajax({
		url: '/status/check',
		dataType: 'json',
		contentType: "application/json",
		success: function(data) {
			var now = Math.round( new Date().getTime() );
			if (data["end_time"] !== null) {
				var now = Math.round( new Date(data["end_time"]).getTime() )
			}
			var start = Math.round( new Date(data["start_time"]).getTime() );
			$(".stopwatch").stopwatch({ "startTime":(now - start) }).stopwatch("start");
		},
		error: function(data) {
			console.debug(data);
		}
	});

}