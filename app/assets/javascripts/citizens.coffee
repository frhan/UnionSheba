# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#citizens').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#citizens').data('source')
    columns: [
      { width: "23%" }
      { width: "23%"}
      { width: "22%" }
      { width: "22%", orderable: false }
      { width: "5%", orderable: false }
      { width: "5%", orderable: false }
    ]