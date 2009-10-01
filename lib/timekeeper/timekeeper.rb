class Timekeeper
  
  def config(file="timekeeper.yml")
    @config ||= YAML.load_file(file)
  end
  
  def delete(id)
    table.delete(id)
  end
  
  def delete_all
    table.clear
  end
  
  def store(attributes)
    attributes.store("name", config["name"])
    attributes.store("date", Date.today) unless attributes["date"]
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
    
  def table
    @table ||= Rufus::Tokyo::Table.new(File.join(config["db_path"],"#{config["name"]}-time.tct"))    
  end
    
end