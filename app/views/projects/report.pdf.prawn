prawn_document(:filename=>"report_#{@project.id}.pdf", :page_layout => :portrait, :page_size => 'A4', :top_margin => 130) do |pdf|
  
  pdf.on_page_create do
    pdf.bounding_box([0,770], :width => 530, :height => 100) do
      pdf.image "#{Rails.root}/public/images/logo.jpg" , :at => [400,100]
      pdf.text "\n\nReport for Project: #{@project.id}\n#{@project.title}\n\n",
        :size => 12,
        :style => :bold
    end
  end
  
  pdf.bounding_box([0,770], :width => 530, :height => 200) do
    pdf.image "#{Rails.root}/public/images/logo.jpg" , :at => [400,200]
    pdf.text "#{Configuration.find_by_key('sender').value}\n\n",
      :size => 8,
      :align => :left,
      :style => :normal
    pdf.text "#{@project.contact.location.name}
      #{@project.contact.firstname} #{@project.contact.lastname}
      #{@project.contact.location.street}\n
      #{@project.contact.location.zip} #{@project.contact.location.city}\n\n\n\n", :size => 10
    
    pdf.text "Report for Project: #{@project.id}\n#{@project.title}\n\n",
      :size => 12,
      :style => :bold
    pdf.text "#{@project.description}\n\n", :size => 10
    
    pdf.text "Stored Work, ordered by month",
      :size => 10,
      :style => :bold
    pdf.horizontal_line 0, 530
  end

  data = @works.map do |work|
    ["#{work.started_at.strftime('%Y-%m-%d')}\n#{work.user.firstname} #{work.user.lastname}",
      work.text_template.title+"\n"+work.description,
      "#{(work.duration / 60).to_f * work.fee} h",
      number_to_currency((work.duration.to_f / 60 * work.fee), :unit => @currency)]
  end
  pdf.table(data, :column_widths => {0 => 100, 1 => 310, 2 => 50, 3 => 65}, :width => 525) do
    column(2..3).align = :right 
    cells.style do |c|
      c.border_width = 1.0
      c.size = 10
      c.border_color = "b3b3b3"
      c.borders=[:bottom]
      c.padding_bottom +=5
    end
  end
  # :row_colors => %w[cccccc ffffff]
  
  pdf.text "\n\n"
  pdf.text "Stored Expenses, ordered by month",
    :size => 10,
    :style => :bold
  pdf.horizontal_line 0, 530
  pdf.text "\n\n"
  
  summary = [["Working hours / Total sum", "#{@project.work_hour_sum} hrs", number_to_currency(@project.work_net_sum, :unit => @currency)],
    ["Working hours / Total sum to pay", "#{@project.work_hour_sum} hrs", number_to_currency(@project.work_net_sum, :unit => @currency)]]
  summary.push(["Discount", "", number_to_currency(@project.work_discount_sum, :unit => @currency)]) if @project.discount > 0
  summary.push(["Expenses", "", number_to_currency(@project.expense_sum, :unit => @currency)]) unless @project.expenses.empty?
  summary.push(["Sum net", "", number_to_currency(@project.full_net_sum, :unit => @currency)],
    ["Add #{@project.tax}% tax", "", number_to_currency(@project.tax_sum, :unit => @currency)],
    ["Sum total", "", number_to_currency(@project.full_tax_sum, :unit => @currency)])
  
  pdf.table(summary, :column_widths => {0 => 410, 1 => 50, 2 => 65}, :width => 525) do
    column(1..2).align = :right
    cells.style do |c|
      c.border_width = 1.0
      c.size = 10
      c.border_color = "b3b3b3"
      c.borders=[:bottom]
      c.padding_bottom = 3
    end
    rows(4..6).style do |r|
      r.style(:font_style => :bold)
    end
  end
    
  pdf.page_count.times do |i|
     pdf.go_to_page(i)
     pdf.text_box("Page #{pdf.page_count - i} of #{pdf.page_count}",
      :size => 10,
      :width => 300,
      :at => [0,10])
  end
end