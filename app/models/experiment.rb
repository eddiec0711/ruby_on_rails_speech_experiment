class Experiment < ApplicationRecord
  before_create :set_slug

  belongs_to :user
  has_many :tasks, as: :taskable, dependent: :destroy
  has_one_attached :results, dependent: :destroy
  validates :name, presence: true

  def link
    if complete
      'http://' + Rails.application.config.app_url + '/' + slug + '/home'
    else
      'Link will be generated on experiment completion'
    end
  end

  def allowed_tasks
    ['QuestionTask', 'SampleTask']
  end

  def completion_errors
    @experiment_errors = {warnings: Array.new, errors: Array.new}
    # task errors
    has_calibration = false
    has_reaction = false
    self.tasks.each do |task|
      @experiment_errors[:warnings].concat task.specific.completion_errors[:warnings]
      @experiment_errors[:errors].concat task.specific.completion_errors[:errors]
      # detect reaction and calibration tasks
      if task.actable_type == "SampleTask"
        if task.specific.calibration
          has_calibration = true
        else
          task.specific.tasks.each do |t|
            if t.actable_type == "ClickTask"
              has_reaction = true
            end
          end
        end
      end
    end
    # own errors
    if self.tasks.empty?
      @experiment_errors[:errors] << "Cannot publish an empty experiment."
    end
    if has_reaction and not has_calibration
      @experiment_errors[:warnings] << "Experiment contains reaction tasks but does not contain any calibration samples."
    end
    if self.terms.nil? or self.terms == ""
      @experiment_errors[:errors] << "Cannot publish an experiment with empty consent terms"
    end
    return @experiment_errors
  end

  #number of all responses
  def total_responses
    if !self.complete
      return nil
    else
      question_tasks = self.tasks.select{|t| t.specific.class.name == 'QuestionTask'}
      sample_tasks = self.tasks.select{|t| t.specific.class.name == 'SampleTask'}
      
      qts_inside_sample = []
      click_tasks = []
      sample_tasks.each do |st|
        qts_inside_sample += st.specific.tasks.select{|t| t.specific.class.name == 'QuestionTask' }
        click_tasks += st.specific.tasks.select{|t| t.specific.class.name == 'ClickTask' }
      end
      max = get_max_number_of_responses_from_tasks(question_tasks + qts_inside_sample + click_tasks)

      if max.nil? then return 0 else return max end
    end
  end

  #number of responses that completed all question tasks
  def finished_responses
    if !self.complete
      return nil
    else
      question_tasks = self.tasks.select{|t| t.specific.class.name == 'QuestionTask'}
      sample_tasks = self.tasks.select{|t| t.specific.class.name == 'SampleTask' and !t.specific.calibration}
      
      qts_inside_sample = []
      click_tasks = []
      sample_tasks.each do |st|
        qts_inside_sample += st.specific.tasks.select{|t| t.specific.class.name == 'QuestionTask' }
        click_tasks += st.specific.tasks.select{|t| t.specific.class.name == 'ClickTask' }
      end

      min = get_min_number_of_responses_from_tasks(question_tasks + qts_inside_sample + click_tasks)

      if min.nil? then return 0 else return min end
    end
  end


 def last_response_date
    if !self.complete
      return nil
    else
      question_tasks = self.tasks.select{|t| t.specific.class.name == 'QuestionTask'}
      sample_tasks = self.tasks.select{|t| t.specific.class.name == 'SampleTask'}
      
      qts_inside_sample = []
      click_tasks = []
      sample_tasks.each do |st|
        qts_inside_sample += st.specific.tasks.select{|t| t.specific.class.name == 'QuestionTask' }
        click_tasks += st.specific.tasks.select{|t| t.specific.class.name == 'ClickTask' }
      end

      max_date = get_last_response_date_from_tasks(question_tasks + qts_inside_sample + click_tasks)

      return max_date 
    end
  end

  private
    def get_last_response_date_from_tasks(tasks)
      max_date = nil
      tasks.each do |t|
        latest = nil
        if t.specific.class.name == 'QuestionTask'
          latest = t.specific.responses.distinct.pluck(:created_at).max
        elsif t.specific.class.name == 'ClickTask' 
          latest = t.specific.click_responses.distinct.pluck(:created_at).max
        end

        if max_date.nil? or (!latest.nil? and latest > max_date)
          max_date = latest
        end
      end
      return max_date
    end

    def get_max_number_of_responses_from_tasks(tasks)
      max = nil
      tasks.each do |t|
        ids = nil
        if t.specific.class.name == 'QuestionTask'
          ids = t.specific.responses.distinct.pluck(:participant_id)
        elsif t.specific.class.name == 'ClickTask'
          ids = t.specific.click_responses.distinct.pluck(:participant_id)
        end

        if max.nil? or ids.length() > max
          max = ids.length()
        end
      end
      return max
    end

    def get_min_number_of_responses_from_tasks(tasks)
      min = nil
      tasks.each do |t|
        ids = nil
        if t.specific.class.name == 'QuestionTask'
          ids = t.specific.responses.distinct.pluck(:participant_id)
        elsif t.specific.class.name == 'ClickTask'
          ids = t.specific.click_responses.distinct.pluck(:participant_id)
        end

        if min.nil? or ids.length() < min
          min = ids.length()
        end
      end
      return min
    end

  
    def set_slug
      loop do
        self.slug = SecureRandom.uuid
        break unless Experiment.where(slug: slug).exists?
      end
    end
end
