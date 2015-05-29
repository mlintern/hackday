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