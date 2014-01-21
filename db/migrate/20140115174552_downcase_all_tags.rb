class DowncaseAllTags < ActiveRecord::Migration
  def up
    Style.unscoped.destroy_all
    Network.unscoped.destroy_all
    Custom.unscoped.destroy_all
    Venue.unscoped.find_each do |v|
      Account.current_id = v.account_id
      v.schedulings.find_each {|s| s.format_styles; s.update_styles; s.save}
    end
    Festival.unscoped.find_each do |v|
      Account.current_id = v.account_id
      v.schedulings.find_each {|s| s.format_styles; s.update_styles; s.save}
    end
    ShowBuyer.unscoped.find_each do |v|
      Account.current_id = v.account_id
      v.schedulings.find_each {|s| s.format_styles; s.update_styles; s.save}
    end

    Contact.unscoped.find_each {|c| Account.current_id=c.account_id; c.format_customs; c.format_networks; c.update_customs; c.update_networks; c.save}
  end

  def down
  end
end
