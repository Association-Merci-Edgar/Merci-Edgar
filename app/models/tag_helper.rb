class TagHelper
  def self.clean(tags)
    tags.split(',').map(&:strip).map(&:downcase).uniq.join(',')
  end
end
