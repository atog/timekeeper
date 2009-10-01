class Keep
  YES = ["YES", "Y", "y", "yes", "true", true]
  NO = ["NO", "N", "n", "no", "false", false, nil]
  
  attr_accessor :name, :time, :title, :description, :target, :date, :pk, :track
  
  def initialize(attributes)
    set_attributes(attributes) if attributes
  end
  
  def update(attributes)
    set_attributes(attributes) if attributes
  end  
  
  def date=(value)
    if value.is_a?(Date)
      @date = value
    else
      @date = Date.parse(value)
    end
  end
  
  def track=(value)
    if YES.include?(value)
      @track = true
    elsif NO.include?(value)
      @track = false
    end
  end
  
  def to_hash
    {:name => name, :time => time, :title => title, :description => description,
      :target => target, :date => date, :track => track}
  end
  
  def to_s
    "#{pk}|#{name}|#{target}|#{title}|#{description}|#{date}|#{time}|#{track}"
  end
  
  private
    
    def set_attributes(attributes)
      attributes.each do |key, value|
        respond_to?("#{key}=") ? send("#{key}=", value) : raise(StandardError, "unknown attribute: #{key}")
      end
    end
  
end
