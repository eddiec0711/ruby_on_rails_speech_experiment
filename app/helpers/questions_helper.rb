module QuestionsHelper
    def question_edit_partial(questions)
        customize_partial_path(questions, ->(model){"tasks/question_tasks/questions/#{model.class.model_name.singular.gsub('question_', '')}/edit"})
    end

    def question_view_partial(questions)
        customize_partial_path(questions, ->(model){"tasks/question_tasks/questions/#{model.class.model_name.singular.gsub('question_', '')}/view"})
    end
end
