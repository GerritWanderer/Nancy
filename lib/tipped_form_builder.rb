class TippedFormBuilder < ActionView::Helpers::FormBuilder
  def text_field(method, options = {})
    options['title'] = I18n.t("helpers.form.#{method.to_s}")
    super(method, options)
  end
end
