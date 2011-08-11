class JoshForm < ActionView::Helpers::FormBuilder  
  CSS = {
    :label => 'form_lbl',
    :hint => 'hint',
    :hint_ptr => 'hint-pointer'
  }

  def required(name)
    object.class.validators_on(name).map(&:class).include?(ActiveModel::Validations::PresenceValidator) rescue nil
  end

  # Optional arguments that are processed with form_fields
  # :hint 
  # :skip
  def self.create_tagged_field(method_name)
    define_method(method_name) do |attribute, *args|

      # Bypass form-builder and do your own custome stuff!
      return super if args.last.is_a?(Hash) && args.last.delete(:skip)

      # ASSUMPTION: that last args is always a Hash!
      if args.last.is_a?(Hash)
        hint = args.last[:hint]
        css_class = args.last[:class]
      end

      if ['text_field', 'text_area'].include?(method_name)
        args.last[:class] = "form_input_full #{css_class}"
      end

      base_tag = super
      # Incase its a mandatory field, the '*' is added to the field.
      label_tag = label("#{attribute.to_s.titleize} #{"*" if required(attribute)}", :class => CSS[:label]) 

      if hint
        hint_pointer = @template.content_tag(:span, '', :class => CSS[:hint_ptr])
        hint_tag = @template.content_tag(:span, hint + hint_pointer, { :class => CSS[:hint] }, false) 
      end

      all_tags = label_tag + base_tag + hint_tag
      
      if css_class =~ /input_small/
        all_tags
      else
        # Wrap all the form fields inside a <p> tag and add a lable to them
        @template.content_tag(:p, all_tags)
      end
    end
  end

  helpers = %w[text_field text_area password_field check_box select file_field collection_select radio_button]
  helpers.each do |name|
    create_tagged_field(name)
  end
end
