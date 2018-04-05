// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$( document ).on('turbolinks:load', function() {
  $('body').fadeIn(2000);
  $('#flash-msg').fadeIn(3000);
  $('#flash-msg').fadeOut(8000);
  $('#search-field').on('input', function() {
    Rails.fire(this.form, 'submit');
  });
  // $('#search-form').on('submit', function(e) {
  //   e.preventDefault();
  // });
});