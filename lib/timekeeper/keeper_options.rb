module Timekeeper
  
  class KeeperOptions < Hash
    attr_reader :opts

    def initialize(args)
      super()

      @opts = OptionParser.new do |o|
        o.banner = "Usage: #{File.basename($0)} [options]"

        o.on("--config FILE", "location of your configuration file - default is ./timekeeper.yml") do |file|
          self[:config] = file
        end

        o.on('-t', '--title TITLE', 'What do you want to register?') do |title|
          self[:title] = title
        end

        o.on('-c', '--target TARGET', 'Who is going to pay?') do |target|
          self[:target] = target
        end

        o.on('-s', '--time TIME', 'How long did it take?') do |time|
          self[:time] = time
        end

        o.on('-m', '--description DESCRIPTION', 'More? You want to be more specific?') do |description|
          self[:description] = description
        end

        o.on('-d', '--date DATE', 'When exactly did it happen?') do |date|
          self[:date] = date
        end

        o.on('--remove ID', 'Remove a record.') do |id|
          self[:remove] = id
        end
        
        o.on('--update ID', 'Remove a record.') do |id|
          self[:update] = id
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