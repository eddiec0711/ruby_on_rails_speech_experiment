class AddInputFromCheckboxToClickResponses < ActiveRecord::Migration[6.0]
  def change
    add_column :click_responses, :from_checkbox, :boolean, default: false
  end
end
