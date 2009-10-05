module Timekeeper
  
  class Viewer
  
    def config(file="timekeeper.yml")
      @config ||= YAML.load_file(file)
    end
    
    def by_month(m=nil)
      today = Date.today
      y, m = today.year, m || today.month
      select{|q|
        q.add "date", :starts_with, "#{y}-#{sprintf("%02d", m)}"
      }.sort!{|x,y| y.date <=> x.date }
    end
    
    def by_name(name)
      select{|q|
        q.add "name", :eq, name
      }.sort!{|x,y| y.date <=> x.date }
    end
    
    def select(&block)
      tables.collect{|table|
        table.query{|q|
          yield q     
        }.collect{|attrs|
          keep = Keep.new(attrs)
          keep.tracked = tracked?(keep.name, keep.pk)
          keep
        }
      }.flatten
    end

    def all
      tables.collect{|table|
        table.query.collect{|attrs|
          keep = Keep.new(attrs)
          keep.tracked = tracked?(keep.name, keep.pk)
          keep
        }
      }.flatten.sort!{|x,y| y.date <=> x.date }
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