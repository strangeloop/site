class AddConfYear

  #conditionally sets the conf_year field, assuming
  #current year, unless a value has already been supplied
  def self.before_create(model)
    model.conf_year= Time.now.year unless model.conf_year
  end
end  
