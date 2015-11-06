class Resource
  def self.build(data)
    fail data['status_message'] if data.key?('status_code')
    object = new
    data.each do |method_name, value|
      send(:attr_accessor, method_name) unless method_defined?(method_name)
      object.send("#{method_name}=", convert_decimal(value))
    end
    object
  end

  def self.convert_decimal(value)
    return value unless (value.is_a? String) && (value =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/)
    value.to_d
  end
end
