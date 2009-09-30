class Timeviewer
  
  def config(file="timekeeper.yml")
    @config ||= YAML.load_file(file)
  end

  def all
    tables.collect{|t| t.query.collect{|k| k} }.flatten!
  end
  
  def to_csv(records, file="export.csv")
    if records.any?
      FasterCSV.open(file, "w") do |csv|    
        csv << records[0].keys
        records.each do |t|
          csv << t.values
        end
      end
    end
  end
      
  private
  
    def tables
      @ts ||= config["team"].collect{|t| Rufus::Tokyo::Table.new(File.join(config["db_path"],"#{t}-time.tct"))}   
    end
    
end