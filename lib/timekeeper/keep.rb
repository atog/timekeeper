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
    if value
      if value.is_a?(Date)
        @date = value
      else
        @date = parse_date(value.to_s)
      end
    end
  end
  
  def track=(value)
    if YES.include?(value)
      @track = true
    elsif NO.include?(value)
      @track = false
    end
  end
  
  def validate
    mandatory(%w(name target title date time))
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
      validate
      self
    end
    
    def parse_date(value)
      case value
      when "today"    : Date.today
      when "yesterday": Date.today - 1
      when "tomorrow" : Date.today + 1
      else
        Date.parse(value)
      end
    end
    
    def mandatory(attributes)
      attributes.each do |attribute|
        raise(StandardError, "#{attribute} is mandatory") unless send(attribute)
      end
    end
  
end
