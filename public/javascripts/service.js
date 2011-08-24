
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

   serviceRenderInit();

});

function serviceRenderInit(){

  var view = function(service){
    //var s =  service.service;
    var s =  service;

    this.tags.clear     = this.div({'class': 'clear'});
    this.tags.s_image   = this.image(s.thumbnail, {'class': 'fs_box_pic' });
    this.tags.tag_spots = this.div({'class': 'tag_spots'});
    this.tags.fs_price  = this.div({'class': 'fs_price'}, '$' + s.amount );
    this.tags.fs_head   = this.span({'class': 'fs_head'}, s.title);
    this.tags.fs_for    = this.span({'class': 'fs_for'}, 'for');
    this.tags.fs_disc   = this.span({'class': 'fs_disc'}, s.nonprofit.name);
    this.tags.fs_left   = this.div({'class': 'fs_left'}, [this.tags.fs_head, this.tags.fs_for, this.tags.fs_disc]);
    this.tags.fs_box    = this.div({'class': 'fs_box'}, [this.tags.tag_spots, this.tags.s_image,
        this.tags.fs_left, this.tags.fs_price, this.tags.clear ] );

    this.tags.service_view = this.link('/services/' + s.to_param , {}, this.tags.fs_box);

    return this.tags.service_view;
  };

  var settings = {
      filter_criteria: {
          category: ['#category_list input:checkbox .EVENT.click .SELECT.:checked', 'service_categories.ARRAY.category_id'],
          nonprofit: ['#nonprofit_list input:checkbox .EVENT.click .SELECT.:checked' , 'nonprofit_id'],
          price: ['#price_list input:checkbox .EVENT.click .SELECT.:checked .TYPE.range', 'amount']
          }
      };

  tJS = new tagJS(services, "#service_list", view, settings);
}
