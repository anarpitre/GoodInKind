// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

  // Login div slider
  $('#login, .login_close').click(function() {
    $("#slidingDiv2").slideToggle(500);
  });

  // City change slider
  $('.city_change_icon, #city_close').click(function() { 
    $("#slidingDiv").slideToggle(500);
  });

  $('#booking_additional_donation_amount, #booking_seats_booked').keyup(function() {
    seats = parseInt($('#booking_seats_booked').val());
    donation = parseFloat($('#booking_additional_donation_amount').val());
    if (isNaN(seats) || seats == 0) {return;}
    if (isNaN(donation)) { donation = 0; }

    donation = parseFloat(donation.toFixed(2))
    total = parseFloat((seats * per_seat).toFixed(2));
    $('#total_donation').html(total + donation);
    $('#booking_donation_amount').val(total);
  });

});
