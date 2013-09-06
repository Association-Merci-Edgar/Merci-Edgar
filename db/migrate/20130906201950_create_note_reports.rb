class CreateNoteReports < ActiveRecord::Migration
  def change
    create_table :note_reports do |t|
      t.text :content

      t.timestamps
    end
  end
end
