
jQuery(document).ready(function($) {

    $('#category_list li:gt(4)').hide();
    $('#nonprofit_list li:gt(4)').hide();

    $('#category_more, #nonprofit_more').click(function(e){

      e.preventDefault();
      $('#' + this.id.replace('more', 'list li')).fadeIn(400);
      $(this).hide();

     });


   $('#category_all, #nonprofit_all, #price_all').closest('ul').children().find(':checkbox').attr('checked', true);

   $('#category_all, #nonprofit_all, #price_all').click(function(){
     $(this).closest('ul').children().find(':checkbox').attr('checked', $(this).is(':checked'));
   });

   serviceRenderInit();

});

function serviceRenderInit(){

  var spots = function(service){
    if(!service.booking_capacity) return null;

    var spot_count = service.booking_capacity - service.booked_seats;
    if(spot_count <= 3){
       return  spot_count + (spot_count == 1 ? ' Spot Left' : ' Spots Left');
    }
    return null;
  };

  var day_left = function(service){
    if(service.is_schedulelater) return null;
    var d = service.start_date.split('-');
    var days = Math.round((new Date(d[0],d[1] - 1, d[2]) - new Date())/86400000);

    if(days <= 3){
      if(days == 0) return 'Last Day';
      else if(days == 1) return '1 Day Left';
      else if(days > 1) return days + ' Days Left';
    }

    return null;
  };

  var view = function(service){
    var spot_content = spots(service);
    var day_content = day_left(service);
    var service_title = service.title.length < 21 ? service.title : service.title.substring(0,21) +'...';
    
    clear     = this.div({'class': 'clear'});
    s_image   = this.div({'class': 'fs_box_pic'}, this.image(service.thumbnail));
    tag_spots = spot_content ? this.div({'class': 'tag_spots'}, spot_content) : null;
    tag_day   = day_content ? this.div({'class': 'tag_day'}, day_content) : null;
    fs_price  = this.div({'class': 'fs_price'}, '$' + service.amount );
    fs_head   = this.span({'class': 'fs_head'}, service_title);
    fs_for    = this.span({'class': 'fs_for'}, 'for');
    fs_disc   = this.span({'class': 'fs_disc'}, service.nonprofit.name);
    fs_left   = this.div({'class': 'fs_left'}, [fs_head, fs_for, fs_disc]);
    fs_box    = this.div({'class': 'fs_box'}, [tag_spots, tag_day, s_image, fs_left, fs_price, clear ] );

    return this.link('/services/' + service.to_param ,{'title': service.title}, fs_box);
  };

  var settings = {
      filter_criteria: {
          category: ['#category_list input:checkbox .EVENT.click .SELECT.:checked', 'service_categories.ARRAY.category_id'],
          nonprofit: ['#nonprofit_list input:checkbox .EVENT.click .SELECT.:checked' , 'nonprofit.nonprofit_categories.ARRAY.category_id'],
          price: ['#price_list input:checkbox .EVENT.click .SELECT.:checked .TYPE.range', 'amount']
          }
      };

  var tJS = new tagJS(services, "#service_list", view, settings);
}

