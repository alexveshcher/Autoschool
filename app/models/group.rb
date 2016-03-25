class Group < ActiveRecord::Base
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |group|
        csv << group.attributes.values_at(*column_names)
      end
    end
  end

end