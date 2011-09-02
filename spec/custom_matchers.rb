RSpec::Matchers.define :protect_attribute do |attribute, value|
  match do |record|
    old_value = record[attribute]
    record.update_attributes(attribute.to_sym => value)
    record[attribute] == old_value
  end

  failure_message do
    "#{subject.class} should protect attribute #{attribute.inspect}"
  end
end

