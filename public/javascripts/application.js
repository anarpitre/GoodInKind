// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

  // Login div slider
  $('#login, .login_close').click(function() {
    $("#slidingDiv2").slideToggle(500);
  });

  // City change slider
  $('.city_change_icon').click(function() { 
    $("#slidingDiv").slideToggle(500);
  });

});
