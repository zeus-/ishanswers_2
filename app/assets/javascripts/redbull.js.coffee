$ ->
$(document).on "ready", ->
  $(".fadein").hide()
  $(window).scroll ->
  	$(".fadein").each ->
  	  $(this).fadeIn()    
  $(".hello").effect "slide", { direction: "left" }, 1500
  
  $(document).click ->
    setInterval ->
      x = Math.floor Math.random() * $(document).width()
      y = Math.floor Math.random() * $(document).height()
      $('.loo').css
        position:  'absolute', left: "600px", top: y
    , 400
    setInterval ->
      x = Math.floor Math.random() * $(document).width()
      y = Math.floor Math.random() * $(document).height()
      $('.loo2').css
        position:  'absolute', left: "600px", top: y
    , 400
    setInterval ->
      x = Math.floor Math.random() * $(document).width()
      y = Math.floor Math.random() * $(document).height()
      $('.loo3').css
        position:  'absolute', left: "600px", top: y
    , 500
