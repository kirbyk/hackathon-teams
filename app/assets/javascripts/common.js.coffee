$ ->
  $('td:contains("Accepted")').addClass("accepted")
  $('td:contains("Rejected")').addClass("rejected")
  $('td:contains("TAccepted")').addClass("taccepted")
  $('td:contains("Waitlisted")').addClass("waitlisted")

  $('.dp-sel').datepicker()
