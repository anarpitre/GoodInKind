
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
    
    this.tags.clear     = this.div({'class': 'clear'});
    this.tags.s_image   = this.image(service.thumbnail, {'class': 'fs_box_pic' });
    this.tags.tag_spots = spot_content ? this.div({'class': 'tag_spots'}, spot_content) : null;
    this.tags.tag_day   = day_content ? this.div({'class': 'tag_day'}, day_content) : null;
    this.tags.fs_price  = this.div({'class': 'fs_price'}, '$' + service.amount );
    this.tags.fs_head   = this.span({'class': 'fs_head'}, service_title);
    this.tags.fs_for    = this.span({'class': 'fs_for'}, 'for');
    this.tags.fs_disc   = this.span({'class': 'fs_disc'}, service.nonprofit.name);
    this.tags.fs_left   = this.div({'class': 'fs_left'}, [this.tags.fs_head, this.tags.fs_for, this.tags.fs_disc]);
    this.tags.fs_box    = this.div({'class': 'fs_box'}, [this.tags.tag_spots, this.tags.tag_day, this.tags.s_image,
        this.tags.fs_left, this.tags.fs_price, this.tags.clear ] );

    this.tags.service_view = this.link('/services/' + service.to_param ,{'title': service.title}, this.tags.fs_box);

    return this.tags.service_view;
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

