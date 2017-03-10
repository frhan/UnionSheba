# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#trade_organizations_table').dataTable
    pagingType: "full"
    jQueryUI: true
    processing: true
    serverSide: true
    ajax: $('#trade_organizations_table').data('source')
    columns: [
      { width: "22%" }
      { width: "23%"}
      { width: "23%" }
      { width: "22%", orderable: false }
      { width: "5%", orderable: false }
      { width: "5%", orderable: false }
      ]