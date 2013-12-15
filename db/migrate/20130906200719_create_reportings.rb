class CreateReportings < ActiveRecord::Migration
  def change
    create_table :reportings do |t|
      t.belongs_to :report, polymorphic: true
      t.belongs_to :asset, polymorphic: true
      t.belongs_to :project
      t.belongs_to :user

      t.timestamps
    end
    add_index :reportings, :report_id
    add_index :reportings, :asset_id
    add_index :reportings, :project_id
    add_index :reportings, :user_id
  end
end
