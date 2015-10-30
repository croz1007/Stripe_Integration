// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// Used temporarily for Navigation background
$(document).ready(function() {
  var menuToggle = $('#js-mobile-menu').unbind();
  $('#js-navigation-menu').removeClass("show");

  menuToggle.on('click', function(e) {
    e.preventDefault();
    $('#js-navigation-menu').slideToggle(function(){
      if($('#js-navigation-menu').is(':hidden')) {
        $('#js-navigation-menu').removeAttr('style');
      }
    });
  });

  $("#btn_new_card").on("click", function(){
    createStripeToken();
  });
});

function createStripeToken(){
  Stripe.setPublishableKey('pk_test_8Watr62QvzgQHnLtBbf1yR0Q');
  Stripe.card.createToken({
    number: $("#number").val(),
    cvc: $("#cvc").val(),
    exp_month: $("#exp_month").val(),
    exp_year: $("#exp_year").val(),
    name: $("#name").val(),
    address_line1: $("#address_line1").val(),
    address_line2: $("#address_line2").val(),
    address_city: $("#address_city").val(),
    address_state: $("#address_state").val(),
    address_zip: $("#address_zip").val(),
    address_country: $("#address_country").val()
  }, stripeResponseHandler);
}

function stripeResponseHandler(status, response){
  $("#token").val(response.id);
  formSubmit();
}

function formSubmit(){
  $("#form_new_card").submit();
}
