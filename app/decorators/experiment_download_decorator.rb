require 'axlsx'

class ExperimentDownloadDecorator < BaseDecorator

  def generate_results
    @sheet_count = 1
    doc = Axlsx::Package.new
    book = doc.workbook
    self.tasks.each do |t|
      case t.specific.class.name
      when "QuestionTask"
        question_page(book, t.specific)
      when "SampleTask"
        sample_page(book, t.specific)
      end
    end
    filename = self.name.downcase.gsub(' ', '_') + '_results.xlsx'
    self.results.attach(io: doc.to_stream, filename: filename, content_type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
  end
    
  def question_page(book, question_task, name=nil)
    if name.nil?
      name = question_task.name
    end
    
    book.add_worksheet(:name => sheet_name(name)) do |sheet|
      headings = ['_uid']
      rowhash = Hash.new
      rowhash[0] = nil
      question_task.questions.order(:sort).each do |q|
        headings << col_name(q.prompt)
        rowhash[q.id] = nil
      end
      sheet.add_row headings
      ids = question_task.responses.distinct.pluck(:participant_id)
      responses = Array.new(ids.length) {rowhash.clone}
      for i in 0..ids.length-1 do
        responses[i][0] = ids[i]
        question_task.responses.where(:participant_id => ids[i]).each do |response|
          responses[i][response.question_id] = response.answer
        end
      end
      responses.each do |row|
        sheet.add_row row.values
      end
    end
  end

  def sample_page(book, sample_task)
    sample_task.tasks.order(:sort).each do |task|
      case task.specific.class.name
      when "QuestionTask"
        q_sheet_name = task.name + ' ' + sample_task.name
        question_page(book, task.specific, q_sheet_name)
      when "ClickTask"
        c_sheet_name = task.name + ' ' + sample_task.name
        click_task(book, task.specific, c_sheet_name)
      end
    end
  end

  def click_task(book, task, name)
    book.add_worksheet(:name => sheet_name(name)) do |sheet|
      headings = ['_time', '_uid', '_comment', '_dk', '_accident', '_no_click']
      responses = ClickResponse.where(click_task_id: task.actable.id).order(:participant_id, :time)
      sheet.add_row headings
      responses.each do |response|
        sheet.add_row parse_response(response)
      end
    end
  end

  def sheet_name(name)
    new_name = @sheet_count.to_s + '_' + name.downcase.gsub(' ', '_')
    @sheet_count += 1
    return new_name[0..30]
  end

  def col_name(name)
    '_' + name.downcase.gsub(' ', '_')
  end

  def parse_response(response)
    if response.no_clicks_explanation
      return [nil, response.participant_id, response.answer, nil, nil, 'true']
    elsif response.from_checkbox
      case response.answer
      when 'I clicked at that time by an accident'
        return [response.time, response.participant_id, nil, nil, 'true', nil]
      when "I don't know"
        return [response.time, response.participant_id, nil, 'true', nil, nil]
      end
    else
      return [response.time, response.participant_id, response.answer, nil, nil, nil]
    end
  end
end
