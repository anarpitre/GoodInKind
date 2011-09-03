class JoshForm < ActionView::Helpers::FormBuilder  
  CSS = {
    :label => 'form_lbl',
    :hint => 'hint',
    :hint_ptr => 'hint-pointer',
    :error => 'error',            # style for error text
    :field_error => 'in_error'    # style for error field
  }

  def required(name)
    object.class.validators_on(name).map(&:class).include?(ActiveModel::Validations::PresenceValidator) rescue nil
  end

  def cancel(options={})
    link = options.fetch(:return, "/")
    @template.content_tag(:a, "Cancel", :href => link, :class => "btn_form button np_cancel_btn #{options[:class]}")
  end

  def submit(value="Save", options={})
    options[:class] = "btn_form button form_post_btn #{options[:class]}"
    super
  end

  # Optional arguments that are processed with form_fields
  # :hint 
  # :skip
  def self.create_tagged_field(method_name)
    define_method(method_name) do |attribute, *args|

      #default args (an array with the hash as the last argument)
      args = [{}] unless args.last

      # Bypass form-builder and do your own custome stuff!
      return super if args.last.is_a?(Hash) && args.last.delete(:skip)

      # ASSUMPTION: that last args is always a Hash!
      if args.last.is_a?(Hash)
        hint = args.last[:hint]
        css_class = args.last[:class]
        label_txt = args.last[:label]
        spinner = args.last[:spinner]  # a spinner class gets added 
        pre = args.last[:pre]          # container is ignored
      end

      if ['password_field', 'text_field', 'text_area', 'file_field', 'email_field'].include?(method_name)
        args.last[:class] = "form_input_full #{css_class}"
      end

      if @object and @object.errors.any?
        # special handling for file_field
        if method_name == 'file_field'
          error = @object.errors["#{attribute.to_s}_file_name"] | @object.errors["#{attribute.to_s}_file_size"] | @object.errors["#{attribute.to_s}_content_type"]
        else
          error = @object.errors[attribute]
        end

        if error.present?
          error_tag = @template.content_tag(:label, error.first.humanize, {:class => CSS[:error]})

          args.last[:class] = "#{args.last[:class]} in_error"
        end
      end

      base_tag = super(attribute, *args)
      
      # Incase its a mandatory field, the '*' is added to the field.
      label_tag = label(attribute, "#{label_txt or attribute.to_s.titleize} #{"*" if required(attribute)}", :class => CSS[:label]) 

      if hint
        hint_pointer = @template.content_tag(:span, '', :class => CSS[:hint_ptr])
        hint_tag = @template.content_tag(:span, hint + hint_pointer, { :class => CSS[:hint] }, false) 
      end

      if spinner
        # TODO: add the spinner image in the class spinner in CSS
        spinner_tag = @template.image_tag('spinner.gif', :class => 'spinner',:id => 'spinner') if args.last[:spinner]
      end

      all_tags = label_tag + base_tag + spinner_tag + hint_tag + error_tag

      # TODO: Remove the css_class special fix -- use :pre instead
      if css_class =~ /input_small|input_tiny/ or pre
        all_tags
      else
        # Wrap all the form fields inside a <p> tag and add a lable to them
        @template.content_tag(:p, all_tags) 
      end
    end
  end

  helpers = %w[text_field text_area password_field select file_field collection_select email_field autocomplete_field ]
  helpers.each do |name|
    create_tagged_field(name)
  end
end
