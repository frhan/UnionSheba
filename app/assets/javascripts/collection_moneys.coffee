jQuery ->
  $('#collection_moneys_table').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    columns: [
      { width: "5%" }
      { width: "20%"}
      { width: "20%" }
      { width: "20%", orderable: false }
      { width: "10%", orderable: false }
      { width: "5%", orderable: false }
      { width: "5%", orderable: false }
      { width: "5%", orderable: false }
      { width: "10%", orderable: false }
    ]