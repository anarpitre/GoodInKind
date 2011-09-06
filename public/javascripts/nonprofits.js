jQuery(document).ready(function($) {

   $('#category_all').closest('ul').children().find(':checkbox').attr('checked', true);

   var tJS = serviceRenderInit();

   $('#category_all').click(function(e){
     e.preventDefault();
     $(this).closest('ul').children().find(':checkbox').attr('checked', true);
     tJS.filter();
   });

   $('#category_none').click(function(e){
     e.preventDefault();
     $(this).closest('ul').children().find(':checkbox').attr('checked', false);
     tJS.filter();
   });


   $(".np_results_list").hover(function(){
     $(this).stop().animate({height:"160px"},{queue:false,duration:200});
   },
   function() {
     $(this).stop().animate({height:"70px"},{queue:false,duration:200});
   });


});

function serviceRenderInit(){
  var view = function(nonprofit){
    var nonprofit_show_link = this.content_tag('b', {}, this.link("/nonprofits/" + nonprofit.to_param, {}, nonprofit.name));
    var description = nonprofit.short_description + " <a href=/nonprofits/" + nonprofit.to_param + ">read more</a>"
    var browse_service_btn = null;
    var admin_update = null;

    if (nonprofit.service_count > 0) {
      browse_service = "Browse Services (" + nonprofit.service_count + ")";
      browse_service_btn = this.link("/service/search?text=" + nonprofit.name.split(' ').join('+'), {'class':'button'}, browse_service);
    }

    if (nonprofit.is_admin) {
      admin_btn = this.link("/nonprofits/" + nonprofit.to_param + '/edit', {'class':'button'}, "Update");
    }

    offer_btn = this.link("/services/new?id=" + nonprofit.id, {'class':'button'}, "Offer a Service");
    np_logos = this.div({'class':'np_logos'}, this.image(nonprofit.thumbnail));
    np_rel_span = this.span({}, nonprofit_show_link);
    np_rel_text = this.content_tag('p', {'class':'np_rel_text'}, [$(np_rel_span).append(" " + nonprofit.full_address), this.content_tag('p', {}, description)]);
    np_rel_btns = this.content_tag('p', {'class':'np_rel_btns'}, [browse_service_btn, offer_btn]);
    np_results_list = this.div({'class': 'np_results_list'}, [np_logos, np_rel_text, np_rel_btns]);

    return np_results_list;
  };

  var settings = {
      filter_criteria: {
          category: ['#category_list input:checkbox .EVENT.click .SELECT.:checked', 'nonprofit_categories.ARRAY.category_id']
          }
      };

  var tJS = new tagJS(nonprofits, "#np_results", view, settings);

  obj_map = tJS.settings.object_map
  for (name in obj_map) {
      $('#' + name + '_list li:gt(0)').hide();

      $.each(obj_map[name], function(el) {
         $('#' + name + "_" + el).next().append(" (" + obj_map[name][el].length +")"); 
         $('#' + name + "_" + el).parent().show();
         $('#' + name + "_" + el).parent().attr('count', obj_map[name][el].length);
      });

      $('#' + name + '_list li:gt(0)').each(function() { 
        if(!$(this).attr('count')) $(this).remove();
      });
  }
  return tJS;
}
