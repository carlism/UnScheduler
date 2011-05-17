
$(function() {
  $( ".datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' });
  $( "#date_selector" ).change(function() {
    document.location.href = this.value;
  });
  
  $('table.room_rows.true tbody').sortable(
    {
      axis: 'y', 
      dropOnEmpty:false, 
      cursor: 'crosshair',
      handle: 'th',
      items: 'tr',
      opacity: 0.4,
      scroll: true,
      update: function(event, ui){
        $.ajax({
            type: 'put', 
            data: $('table.room_rows.true tbody').sortable('serialize'), 
            dataType: 'script'})
      }
    }
  );
  
	$( "div.draggable.true" ).draggable({ 
      handle: '.handle'
	  revert: true, 
	  helper: 'clone' });
	$( "div.droppable.true" ).droppable({
	  hoverClass: "drop-state-active",
	  accept: "div.draggable.true",
		drop: function( event, ui ) {
      $.ajax({
          type: 'post', 
          data: "from=" + ui.draggable[0].id + "&to=" + this.id, 
          dataType: 'script'})
		}
	});
	
});