$ ->
  # add colors to statuses
  $('td:contains("Accepted")').addClass("accepted")
  $('td:contains("Rejected")').addClass("rejected")
  $('td:contains("TAccepted")').addClass("taccepted")
  $('td:contains("Waitlisted")').addClass("waitlisted")

  # add date picker to _form's
  $('.dp-sel').datepicker()

  # make index rows clickable to cooresponding show 
  $('.clickable').click ->
    href = $(this).attr('href')
    window.location = href if href

  $(".clickable").hover (->
    $(this).addClass("hover")
  ), ->
      $(this).removeClass("hover")
