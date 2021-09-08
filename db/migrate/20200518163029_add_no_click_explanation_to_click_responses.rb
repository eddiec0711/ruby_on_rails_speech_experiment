class AddNoClickExplanationToClickResponses < ActiveRecord::Migration[6.0]
  def change
    add_column :click_responses, :no_clicks_explanation, :boolean, default: false
  end
end
