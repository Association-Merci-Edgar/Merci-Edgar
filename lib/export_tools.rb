
module ExportTools
  def self.build_list(list)
    list.map(&:to_s).join(', ')
  end
end
