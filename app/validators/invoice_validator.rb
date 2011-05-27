class InvoiceValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] =I18n.t(:invoice_error_higher, :field1 => Invoice.human_attribute_name('ended_at'), :field2 => Invoice.human_attribute_name('started_at')) unless end_is_higher_then_start(record)
  end

  private
  def end_is_higher_then_start(record)
    record.ended_at >= record.started_at ? true : false
  end
end

