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

function menu() {
		$('.nav-toggle').click(function() {
			if($(".nav").hasClass("side-closed")) {
				$('.nav').animate({
				    left: "0px",
				}, 10.0, function() {
				    $(".nav").removeClass("side-closed");
				});
			}
			else {
				$('.nav').animate({
				    left: "-201px",
				}, 100, function() {
				    $(".nav").addClass("side-closed");
				});
			}
		});
	}
	
	//Menu Sidebar
	$(window).resize(function() {
		var windowSize = $(window).width();
		$(".nav-toggle").remove();
		
		if (windowSize < 800) { 
			$('.nav').css('left', '-201px').addClass('side-closed');
			$('.nav').append( "<div class='nav-toggle'>Menu</div>" );
		} else {
			$('.nav').css('left', '0px').addClass('side-closed');
		}
		
		menu();
	});
	
	$(document).ready(function() {
		var windowSize = $(window).width();
		$(".nav-toggle").remove();
		
		if (windowSize < 800) { 
			$('.nav').css('left', '-201px').addClass('side-closed');
			$('.nav').append( "<div class='nav-toggle'>Menu</div>" );
		} else {
			$('.nav').css('left', '0px').addClass('side-closed');
		}
		
		menu();
	});
	
function showPosition(position)
  {
  	$("#localization").val("Latitude: " + position.coords.latitude + " Longitude: " + position.coords.longitude);	
  }
  
function getLocation()
  {
  	if (navigator.geolocation)
    {
    navigator.geolocation.getCurrentPosition(showPosition);
    }
	else{$("#localization").val("Geolocation is not supported by this browser.");}
  }

