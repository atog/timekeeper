module Timekeeper
  
  class Viewer
  
    def config(file="timekeeper.yml")
      @config ||= YAML.load_file(file)
    end

    def all
      tables.collect{|table| table.query.collect{|attrs| Keep.new(attrs)}}.flatten!
    end
  
    def close
      tables.each {|table| table.close}
    end
  
    def self.export(records, name="timekeeper", type= :csv)
      if records.any?
        case type.to_s
        when "csv"
          FasterCSV.open("#{name}.#{type}", "w") do |csv|    
            csv << Keep::FIELDS
            records.each do |record|
              csv << record.values
            end
          end
        end
      end
    end
      
    private
  
      def tables
        @tables ||= config["team"].collect{|t| Rufus::Tokyo::Table.new(File.join(config["db_path"],"#{t}-time.tct"))}   
      end
      
  end    
end