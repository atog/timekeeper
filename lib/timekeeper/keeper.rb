module Timekeeper
  
  class Keeper
  
    def config(file="timekeeper.yml")
      @config ||= YAML.load_file(file)
    end
  
    def delete(id)
      table.delete(id)
    end
  
    def delete_all
      table.clear
    end
  
    def close
      table.close
    end
    
    def count
      table.count
    end
  
    def store(attributes)
      attributes.store(:name, config["name"])
      attributes.store(:date, Date.today) unless (attributes["date"] || attributes[:date])
      table[table.genuid] = Keep.new(attributes).to_hash
    end
  
    def get(id)
      if attributes = table.lget(id.to_s).values.first
        Keep.new(attributes)
      end
    end
  
    def update(id, attributes_to_update)
      if attributes = table.lget(id.to_s).values.first
        table[id] = Keep.new(attributes).update(attributes_to_update).to_hash
      end
    end
    
    def track(id, name)
      tracking_table = Rufus::Tokyo::Table.new(File.join(config["db_path"],"tracking-time.tct"))
      tracking_table[tracking_table.genuid] = {:keep_id => id, :name => name}
      tracking_table.close
    end
    
    private
    
      def table
        @table ||= Rufus::Tokyo::Table.new(File.join(config["db_path"],"#{config["name"]}-time.tct"))    
      end
    
  end
end