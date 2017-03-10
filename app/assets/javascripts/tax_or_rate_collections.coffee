# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#tax_or_rate_collections_table').dataTable
    pagingType: "full"
    jQueryUI: true
    processing: true
    serverSide: true
    ajax: $('#tax_or_rate_collections_table').data('source')
    columns: [
      { width: "15%" }
      { width: "20%"}
      { width: "20%" }
      { width: "15%", orderable: false }
      { width: "10%", searchable: false, orderable: false }
      { width: "10%", searchable: false, orderable: false }
      { width: "10%", searchable: false, orderable: false }
    ]
    order: [ [0,'desc'] ]