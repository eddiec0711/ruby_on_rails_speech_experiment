class ClickResponsesController < ApplicationController
    #skip_before_action :verify_authenticity_token 
    skip_before_action :authenticate_user!
    def new
        @click_response = ClickResponse.new
    end

    def create
        click_response_params[:_json].each do |response|
            @click_response = ClickResponse.new(response)
            @click_response.save!
        end
    end
  
    private
        def click_response_params
            params.permit(:_json => [:participant_id, :time, :answer, :click_task_id, :no_clicks_explanation, :from_checkbox])
        end
end
