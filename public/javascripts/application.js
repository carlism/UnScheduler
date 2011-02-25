
$(function() {
  $( ".datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' });
  $( "#date_selector" ).change(function() {
    document.location.href = this.value;
  });
});