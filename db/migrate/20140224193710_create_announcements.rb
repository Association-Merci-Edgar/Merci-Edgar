class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.string :link
      t.datetime :published_at

      t.timestamps
    end
  end
end
