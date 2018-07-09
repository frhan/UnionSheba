# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#expenses_table').dataTable
    pagingType: "full"
    jQueryUI: true
    processing: true
    serverSide: true
    ajax: $('#expenses_table').data('source')
    columns: [
      { width: "15%" }
      { width: "20%"}
      { width: "20%", orderable: false }
      { width: "15%", searchable: false, orderable: false }
      { width: "15%", searchable: false, orderable: false }
      { width: "15%", searchable: false, orderable: false }
    ]
    order: [ [0,'desc'] ]