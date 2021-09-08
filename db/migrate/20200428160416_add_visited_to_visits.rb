class AddVisitedToVisits < ActiveRecord::Migration[6.0]
  def change
    add_column :visits, :visited, :boolean, default: false
  end
end
