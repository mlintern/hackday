// scripts.js

// Prevent links with js-trigger class from firing
$('.js-trigger').on("click", function (event) {
	event.preventDefault();
});