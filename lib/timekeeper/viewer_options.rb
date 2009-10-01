module Timekeeper
  
  class ViewerOptions < Hash
    attr_reader :opts

    def initialize(args)
      super()

      @opts = OptionParser.new do |o|
        o.banner = "Usage: #{File.basename($0)} [options]"

        o.on("--config FILE", "location of your configuration file - default is ./timekeeper.yml") do |file|
          self[:config] = file
        end
        
        o.on("--csv [FILE]", "export to csv") do |file|
          self[:output] = [(file || "timekeeper"), :csv]
        end        
        
        o.on('-n', '--name NAME', 'Query on name') do |title|
          self[:title] = title
        end        

        o.on('-t', '--title TITLE', 'Query on title') do |title|
          self[:title] = title
        end

        o.on('-c', '--target TARGET', 'Query on target') do |target|
          self[:target] = target
        end

        o.on('-m', '--description DESCRIPTION', 'Query on description') do |description|
          self[:description] = description
        end

        o.on('-d', '--date DATE', 'Query on date') do |date|
          self[:date] = date
        end

        o.on_tail('-h', '--help', 'Display this help and exit') do
          puts @opts
          exit
        end        

      end

      begin
        @opts.parse!(args)
      rescue OptionParser::InvalidOption => e
        self[:invalid_argument] = e.message
      end
    end
    
  end
end