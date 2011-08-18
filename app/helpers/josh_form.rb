class JoshForm < ActionView::Helpers::FormBuilder  
  CSS = {
    :service => {
    :label => 'form_lbl',
    :hint => 'hint',
    :hint_ptr => 'hint-pointer'
  },
    :profile => {
    :label => 'my_pro_lbl'
  }
  }

  def required(name)
    object.class.validators_on(name).map(&:class).include?(ActiveModel::Validations::PresenceValidator) rescue nil
  end

  def cancel(options={})
    link = options.fetch(:return, "/")
    if options[:type] == "service"
      @template.content_tag(:a, "Cancel", :href => link, :class => "btn_form button np_cancel_btn")
    else
      @template.content_tag(:input, "", :href => link, :class => "button btn_form #{options[:class]}", :type => "reset", :value => "Cancel")
    end
  end

  def submit(value="Save", options={})
    options[:type] = "submit"
    if options[:type] == "service"
      options[:class] = "btn_form button #{options[:class]}"
    else
      options[:class] = "button btn_form #{options[:class]}"
    end
    value = options.delete(:label) if options[:label] 
    super
  end

  # Optional arguments that are processed with form_fields
  # :hint 
  # :skip
  def self.create_tagged_field(method_name)
    define_method(method_name) do |attribute, *args|

      #default args (an array with the hash as the last argument)
      args = [{}] unless args

      # Bypass form-builder and do your own custome stuff!
      return super if args.last.is_a?(Hash) && args.last.delete(:skip)

      # ASSUMPTION: that last args is always a Hash!
      if args.last.is_a?(Hash)
        hint = args.last[:hint]
        css_class = args.last[:class]
        label_txt = args.last[:label]
        type = args.last[:type].to_sym
      end

      if ['password_field', 'text_field', 'text_area'].include?(method_name)
        args.last[:class] = "form_input_full #{css_class}" if type.to_s == "service"
        args.last[:class] = "my_edit_input #{css_class}" if type.to_s == "profile"
      end

      if ['file_field'].include?(method_name)
        args.last[:type] = 'file'
      end
      
      base_tag = super(attribute, *args)
      
      # Incase its a mandatory field, the '*' is added to the field.
      label_tag = label("#{label_txt or attribute.to_s.titleize} #{"*" if required(attribute)}", :class => CSS[type][:label]) 

      if hint
        hint_pointer = @template.content_tag(:span, '', :class => CSS[type][:hint_ptr])
        hint_tag = @template.content_tag(:span, hint + hint_pointer, { :class => CSS[type][:hint] }, false) 
      end

      all_tags = label_tag + base_tag + hint_tag
      
      if css_class =~ /input_small/
        all_tags
      elsif  type.to_s == "service"
        # Wrap all the form fields inside a <p> tag and add a lable to them
        @template.content_tag(:p, all_tags) 
      else
        @template.content_tag(:p, all_tags, :class => "my_pro_p") #if type.to_s == "profile"
      end
    end
  end

  helpers = %w[text_field text_area password_field select file_field collection_select ]
  helpers.each do |name|
    create_tagged_field(name)
  end
end
