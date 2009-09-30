class Keep
  attr_accessor :name, :time, :title, :description, :target, :date, :pk
  
  def initialize(attributes)
    attributes.each do |k, v|
      respond_to?("#{k}=") ? send("#{k}=", v) : raise(StandardError, "unknown attribute: #{k}")
    end
  end
  
  def date=(value)
    if value.is_a?(Date)
      @date = value
    else
      @date = Date.parse(value)
    end
  end
  
  def to_hash
    {:name => name, :time => time, :title => title, :description => description,
      :target => target, :date => date}
  end
  
  def to_s
    "#{pk}|#{name}|#{target}|#{title}|#{description}|#{date}|#{time}"
  end
  
end
