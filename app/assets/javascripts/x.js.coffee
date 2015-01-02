$ ->
$(document).on "ready", ->
  $(".fadein").hide()
  $(window).scroll ->
  	$(".fadein").each ->
  	  $(this).fadeIn()    


