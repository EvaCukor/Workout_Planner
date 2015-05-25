// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//= require_tree .

//= require bootstrap-sprockets

var registration_welcome = '<p class="homepage_desc homepage_text">Welcome! Here you can create completely customized workouts and share them with other users. If you have yet to experience what this website offers, then please register below. Otherwise, follow the link to the login page.</p>';
var login_welcome = '<p class="homepage_desc homepage_text">Welcome! Here you can create completely customized workouts and share them with other users. If you are an existing user of this website, please log in below. Otherwise, follow the link to the registration page.</p>'

$(document).ready(function() {
  $('div#form_title').addClass('form_title');
  
  $('button.close').click(function(){
    $('span#login_text').html(login_welcome);
    $('span#registration_text').html(registration_welcome);
  });
  
  $(".custom-close").on('click', function() {
    $('#deleteModal').modal('hide');
  });
});