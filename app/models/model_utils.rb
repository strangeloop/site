class ModelUtils
  def self.validate_presence(list)
    list.each do |field|
      ActiveRecord::Base.validates field, :presence => true
    end
  end
end
