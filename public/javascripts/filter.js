var tagJS = function(dataModel, parentNode, view, settings){
  this.dataModel = dataModel;
  this.tags = {};
  this.view = view;
  this.parentNode = parentNode;
  this.settings = settings || {};

  for(name in this.dataModel[0]) { this.settings.root = name;}

  if(this.parentNode) this.render();
  this.category_map(dataModel, this.settings);
  this.filter_event(this.settings);
};

tagJS.prototype = {

render: function(parentNode){
          var parentObj = this;

          if(!this.view) return false; 
          if(!(parentNode || this.parentNode)) return false;

          var node = $(parentNode || this.parentNode);

          if (this.dataModel.constructor == Array){ 

            this.dataModel.forEach(function(dm) { 
                dm = dm[parentObj.settings.root];
                var el =  parentObj.view(dm);
                el.id = parentObj.settings.root + '_' + dm.id;
                el.setAttribute('tagjs', 'yes');
                node.append(el);
                });
          }
          else{
            node.append(parentObj.view(this.dataModel));
          }
        },

content_tag: function(tag, attrs, content) {
               var el = document.createElement(tag);

               if(attrs) $(el).attr(attrs);
               if(content){
                 if(content.constructor == Array) {
                   content.forEach(function(c) { if(c) $(el).append($(c)); });
                 }
                 else{
                   $(el).html(content);
                 }
               }
               return el;
             },

link: function(url, attrs, content){
        attrs = attrs || {};
        attrs['href'] = url;
        return this.content_tag('a', attrs, content)
      },

image: function(url, attrs){
         attrs = attrs || {};
         attrs['src'] = url;
         return this.content_tag('img', attrs)
       },
div: function(attrs, content){
       return this.content_tag('div', attrs, content);
     },
span: function(attrs, content){
        return this.content_tag('span', attrs, content);
      },

li: function(attrs, content){
      return this.content_tag('li', attrs, content);
    },
ul: function(attrs, content){
      return this.content_tag('ul', attrs, content);
    },


filter_event: function(settings){

                var parentObj = this;

                settings.selector.forEach(function(selector, index) {

                    $(selector.element).bind(selector.events, function(e){
                      var filter_out = settings.all_object.slice();
                      var selected_count = 0;

                      settings.selector.forEach(function(s){
                        var out = $(s.element).filter(s.select).map(function(){ return $(this).val(); });
                        selected_count += out.length;

                        if(out.length) {
                          filter_out = parentObj.grep(filter_out, parentObj.get_view_object(s.name, out, s.type));
                          }
                        });

                       parentObj.hideShow((selected_count ? filter_out : []));

                      });
                    });
              },

grep: function(filter_out, value) {
        return jQuery.grep(filter_out,
            function(p, i) {
            return (jQuery.inArray(p, value) != -1);
            });
      },

get_view_object: function(filter_name, categories, filter_type){
                   var out = [];
                   var parentObj = this;

                   $.each(categories, function(index,category) {
                       var cat;

                       if(filter_type == 'range'){
                       var range = category.split('-');

                       if(range.length == 2){
                       if(range[0] == 'below') range[0] = -Infinity; 
                       if(range[1] == 'above') range[1] = Infinity;

                       cat = $.map(parentObj.settings.object_map[filter_name],function(n,v){
                         if(Number(v) >= range[0] && Number(v) <= range[1]) return parentObj.settings.object_map[filter_name][v];
                         });
                       }
                       }
                       else{
                       cat = parentObj.settings.object_map[filter_name][category];
                       }

                       if(cat){ out = out.concat(cat);}
                       });

                   return out;
                 },

parse_map: function(field_map, root){
             var fields = field_map.split('.ARRAY.');
             var eval_out_str = root + '.' + fields[0];  

             for(i = 1; i < fields.length; i++){  
               eval_out_str += ".filter_collect('" + fields[i] + "')";
             }

             return eval_out_str;
           },

map_objects: function(settings){
               var parentObj = this;
               var filter_criteria = settings.filter_criteria;
               var object_map = {};
               settings.selector = [];

               for(name in filter_criteria){ 
                 var selector = {};

                 selector.element = filter_criteria[name][0].split(/.EVENT.|.SELECT.|.TYPE./)[0];
                 selector.events = (filter_criteria[name][0].match(/.EVENT.(\S*)/) || [])[1];
                 selector.select = (filter_criteria[name][0].match(/.SELECT.(\S*)/) || [])[1]
                 selector.type   = (filter_criteria[name][0].match(/.TYPE.(\S*)/) || [])[1];
                 selector.name   = name;

                 settings.selector.push(selector);

                 filter_criteria[name].push(parentObj.parse_map(filter_criteria[name][1], settings.root));
                 object_map[name] = {};
               }

               return object_map;
             },

category_map: function(data, settings){

                var filter_criteria = settings.filter_criteria;
                var object_map = this.map_objects(settings);
                settings.all_object = [];

                data.forEach(function(dm){
                    settings.all_object.push(dm[settings.root].id);
                    for(name in filter_criteria){
                    var eval_out = eval('dm.' + filter_criteria[name][2]);
                    var obj = object_map[name];

                    if(eval_out.constructor.name == 'Array'){
                    eval_out.forEach(function(x){

                      if(obj[x]){
                        obj[x].push(dm[settings.root].id);
                      }
                      else{
                        obj[x] = [dm[settings.root].id];
                      }
                      });
                    }
                    else{
                      if(obj[eval_out]){
                        obj[eval_out].push(dm[settings.root].id);
                    }
                    else{
                      obj[eval_out] = [dm[settings.root].id];
                    }
                    }
                    }
                });

                settings.object_map = object_map;

                return object_map;
              },

hideShow: function(id_arr){
            var id_str = "#" + this.settings.root + '_';
            $(this.parentNode + " > *[tagjs]").hide();

            id_arr.forEach(function(id){
                $(id_str + id).show();
                });
          }
};

Array.prototype.filter_collect =  function(field, out_arr) {
  var out_arr = out_arr || [];  
  this.forEach(function(obj){ 
      if(obj.constructor.name == 'Array'){
      obj.filter_collect(field, out_arr);
      }
      else{
      out_arr.push( obj[field]);
      }
      });
  return out_arr;
};

// IE doesn't define forEach! (WTF)
if (!('forEach' in Array.prototype)) {
   Array.prototype.forEach= function(action, that /*opt*/) {
     for (var i= 0, n= this.length; i<n; i++)
       if (i in this)          
         action.call(that, this[i], i, this);    
   };                
}
