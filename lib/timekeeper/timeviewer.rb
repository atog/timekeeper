class Timeviewer
  
  def config(file="timekeeper.yml")
    @config ||= YAML.load_file(file)
  end

  def all
    tables.collect{|table| table.query}.flatten!
  end
  
  def close
    tables.each {|table| table.close}
  end
  
  def self.export(records, name="export", type= :csv)
    if records.any?
      case type
      when :csv
        FasterCSV.open("#{name}.#{type}", "w") do |csv|    
          csv << records[0].keys
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