class AddConfYear

  def self.before_create(model)
    model.conf_year = Time.now.year
  end
  
end  
