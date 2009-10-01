module Timekeeper

  class Keep
  
    attr_accessor :name, :time, :title, :description, :target, :date, :pk
  
    def initialize(attributes)
      set_attributes(attributes)
    end
  
    def update(attributes)
      set_attributes(attributes)
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
    
    def validate
      mandatory(%w(name target title date time))
    end      
  
    def to_hash
      {:name => name, :time => time, :title => title, :description => description,
        :target => target, :date => date}
    end
  
    def to_s
      "#{pk}|#{name}|#{target}|#{title}|#{description}|#{date}|#{time}"
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
end