class WorkValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] =I18n.t(:works_error_higher, :field1 => Work.human_attribute_name('ended_at'), :field2 => Work.human_attribute_name('started_at')) unless end_is_higher_then_start(record)
    record.errors[:base] = I18n.t(:works_error_exist) unless no_other_record_exist(record)
  end

  private
  def end_is_higher_then_start(record)
    record.ended_at > record.started_at ? true : false
  end
  def no_other_record_exist(record)
    # 15:00 to 15:30 // 14:45 to 15:15
    no_other_record_exist = Work.where(:user_id => record.user_id).where("started_at > '#{record.started_at}' AND started_at < '#{record.ended_at}'").empty? ? true : false
    if no_other_record_exist
      # 15:00 to 15:45 // 15:15 to 15:30
      no_other_record_exist = Work.where(:user_id => record.user_id).where("started_at < '#{record.ended_at}' AND ended_at > '#{record.ended_at}'").empty? ? true : false
      if no_other_record_exist
        # 15:00 to 15:30 // 15:15 to 15:45
        # no_other_record_exist = Work.where(:user_id => record.user_id).where("started_at < '#{record.started_at.strftime('%Y-%m-%d %H:%M')}' AND ended_at < '#{record.ended_at.strftime('%Y-%m-%d %H:%M:00')}'").empty? ? true : false
      end
    end
    return no_other_record_exist
  end
end

