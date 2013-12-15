class ContactsNoSti < ActiveRecord::Migration
  def up
    PeopleStructure.destroy_all
    drop_table :contacts
    drop_table :venue_infos
#    drop_table :schedulings

    create_table :contacts do |t|
      t.belongs_to  :contactable, polymorphic: true
      t.string      :name
      t.string      :network_tags
      t.string      :custom_tags
      t.text        :remark

      t.integer :account_id


      t.timestamps
    end
    add_index :contacts, :contactable_id
    add_index :contacts, :account_id

    create_table :structures do |t|
      t.belongs_to :structurable, polymorphic:true
      t.string  :avatar
      t.integer :account_id

      t.timestamps
    end
    add_index :structures, :structurable_id

    create_table :people do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :avatar
      t.integer :account_id

      t.timestamps
    end
    add_index :people, :account_id

    create_table :venues do |t|
      t.string :kind
      # t.string :opening_months
      t.integer :start_season
      t.integer :end_season
      t.boolean :residency
      t.boolean :accompaniment
      t.string  :avatar
      t.integer :account_id
      t.timestamps
    end
    add_index :venues, :account_id
  end

  def down
  end
end
