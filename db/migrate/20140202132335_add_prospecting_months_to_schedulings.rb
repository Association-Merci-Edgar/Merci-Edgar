class AddProspectingMonthsToSchedulings < ActiveRecord::Migration
  def up
    add_column :schedulings, :prospecting_months, :string_array
    Scheduling.reset_column_information
    Scheduling.find_each do |s|
      months = []
      s.prospectings.each {|p| months.push(*ModuloRange.new(p.start_month,p.end_month))}
      if months.present?
        s.update_attributes!(:prospecting_months => months.map(&:to_s))
        puts "#{s.id} // months added: #{s.prospecting_months}"
      end
    end    
  end
  
  def down
    remove_column :schedulings, :prospecting_months
  end
end
