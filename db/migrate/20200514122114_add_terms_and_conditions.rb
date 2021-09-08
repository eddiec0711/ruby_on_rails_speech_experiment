class AddTermsAndConditions < ActiveRecord::Migration[6.0]
  def change
    add_column :experiments, :terms, :text
  end
end
