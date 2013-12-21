class RemoveArtistsKindToFestivals < ActiveRecord::Migration
  def up
    remove_column :festivals, :artists_kind
  end

  def down
    add_column :festivals, :artists_kind, :string
  end
end
