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
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require d3
//= require metrics-graphics-rails
  $( document ).ready(function() {
    $("#directions").hide();
    $("#inputs").hide();
    $("#errors").hide();

    var slideLeft = new Menu({
      wrapper: '#o-wrapper',
      type: 'slide-left',
      menuOpenerClass: '.c-button',
      maskId: '#c-mask'
    });

    var slideLeftBtn = document.querySelector('#c-button--slide-left');

    slideLeftBtn.addEventListener('click', function(e) {
      e.preventDefault();
      slideLeft.open();
    });
    
  });

  window.onload = (function(){
        $(".waiting").hide();
        $("#map").show();
      });
