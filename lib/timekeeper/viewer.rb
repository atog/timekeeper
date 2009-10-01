module Timekeeper
  
  class Viewer
  
    def config(file="timekeeper.yml")
      @config ||= YAML.load_file(file)
    end

    def all
      tables.collect{|table| 
        table.query.collect{|attrs|
          keep = Keep.new(attrs)
          keep.tracked = tracked?(keep.name, keep.pk)
          keep
        }
      }.flatten!
    end
  
    def close
      tables.each {|table| table.close}
      tracking_table.close
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
      
      def tracking_table
        @tracking_table ||= Rufus::Tokyo::Table.new(File.join(config["db_path"],"tracking-time.tct"))
      end
      
      def tracked?(name, id)
        tracking_table.query{|q|
          q.limit 1
          q.add "name", :equals, name.to_s
          q.add "keep_id", :equals, id.to_s
        }.any?
      end
      
  end    
end