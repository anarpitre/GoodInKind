jQuery(document).ready(function($) {

    $('#category_list li:gt(4)').hide();
    $('#nonprofit_list li:gt(4)').hide();

    $('#category_more, #nonprofit_more').click(function(e){

      e.preventDefault();
      $('#' + this.id.replace('more', 'list li')).fadeIn(400);
      $(this).hide();

     });

    $('#category_all, #nonprofit_all, #price_all').click(function(){
        $(this).closest('ul').children().find(':checkbox').attr('checked', $(this).is(':checked'));
     });

});
