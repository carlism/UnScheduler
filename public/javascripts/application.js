
$(function() {
  $( ".datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' });
  $( "#date_selector" ).change(function() {
    document.location.href = this.value;
  });
  
  $('table.room_rows.true').sortable(
    {
      axis: 'y', 
      dropOnEmpty:false, 
      cursor: 'crosshair',
      items: 'tr',
      containment: 'table.room_rows tbody',
      opacity: 0.4,
      scroll: true,
      update: function(event, ui){
        $.ajax({
            type: 'put', 
            data: $('table.room_rows').sortable('serialize'), 
            dataType: 'script'})
      }
    }
  );
  
  
	$( "div.draggable.true" ).draggable({ revert: true });
	$( "div.droppable.true" ).droppable({
	  hoverClass: "drop-state-active",
		drop: function( event, ui ) {
      $.ajax({
          type: 'post', 
          data: "from=" + ui.draggable[0].id + "&to=" + this.id, 
          dataType: 'script'})
		}
	});
	
});