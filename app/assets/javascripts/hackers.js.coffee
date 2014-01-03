# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('td:contains("Accepted")').addClass("accepted")
  $('td:contains("Rejected")').addClass("rejected")
  $('td:contains("TAccepted")').addClass("taccepted")
  $('td:contains("Waitlisted")').addClass("waitlisted")
