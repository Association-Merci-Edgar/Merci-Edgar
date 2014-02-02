class AddProspectingMonthsToSchedulings < ActiveRecord::Migration
  def change
    add_column :schedulings, :prospecting_months, :string_array
    Scheduling.find_each do |s|
      months = []
      s.prospectings.each {|p| months.push(*ModuloRange.new(p.start_month,p.end_month))}
      s.update_attributes(:prospecting_months => months) if months.present?
    end    
  end
end
