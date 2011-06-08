class TippedFormBuilder < ActionView::Helpers::FormBuilder
  def text_field(method, options = {})
    case @object_name
      when /^[a-z_]*$/; object = @template.instance_variable_get("@#{@object_name}").class.to_s.downcase
      else;            object = /^.*\[(\w*)s_attributes\]\[0\]$/.match(@object_name)[1]
    end
    options['title'] = I18n.t("activerecord.tooltips.#{object}.#{method.to_s}")
    super(method, options)
  end
  def text_area(method, options = {})
    case @object_name
      when /^[a-z_]*$/; object = @template.instance_variable_get("@#{@object_name}").class.to_s.downcase
      else;            object = /^.*\[(\w*)s_attributes\]\[0\]$/.match(@object_name)[1]
    end
    options['title'] = I18n.t("activerecord.tooltips.#{object}.#{method.to_s}")
    super(method, options)
  end
  def label(method, options = {})
    case @object_name
      when /^[a-z_]*$/; object = @template.instance_variable_get("@#{@object_name}").class.to_s.downcase
      else;            object = /^.*\[(\w*)s_attributes\]\[0\]$/.match(@object_name)[1]
    end
    options['title'] = I18n.t("activerecord.tooltips.#{object}.#{method.to_s}")
    super(method, options)
  end
end
