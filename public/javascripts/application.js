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
    donation = parseInt($('#booking_additional_donation_amount').val());
    if (isNaN(seats) || seats == 0) {return;}
    if (isNaN(donation)) { donation = 0; }

    total = (seats * per_seat);
    cc_amt = (total + donation) * fg_cc_rate / 100
    $('#total_donation').html(total + donation + cc_amt);
    $('#booking_donation_amount').val(total);
    $('#total_cc_charges').html(cc_amt)
    $('#booking_CC_charges').val(cc_amt);
  });

});
