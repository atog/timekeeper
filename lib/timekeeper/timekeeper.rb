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
    table[table.genuid] = Keep.new(attributes).to_hash
  end
    
  def table
    @t ||= Rufus::Tokyo::Table.new(File.join(config["db_path"],"#{config["name"]}-time.tct"))    
  end
    
end