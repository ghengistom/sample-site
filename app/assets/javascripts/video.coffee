$ ->
  $('.video_link').on "click", "a", (e)->
    e.preventDefault()
    $('.video_frame iframe').attr 'src', $(@).attr 'href'
  
  $("[data-toggle='tooltip']").tooltip()