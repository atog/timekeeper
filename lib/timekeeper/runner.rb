module Timekeeper
  
  class Runner
    
    def self.tk(args)
      options = KeeperOptions.new(args)
      if options.any?
        tk = Keeper.new
        tk.config(options.delete(:config)) if options[:config]
        
        if id = options[:remove]
          tk.delete(id)
        elsif id = options.delete(:update)
          tk.update(id, options)
        else        
          tk.store(options)          
        end
      else
        puts options.opts
      end
    end
    
    def self.tv(args)
      options = ViewerOptions.new(args)
      tv = Viewer.new
      tv.config(options.delete(:config)) if options[:config]      
      records = tv.all
      if output = options.delete(:output)
        Viewer.export(records, output[0], output[1])
      else
        puts records
      end
    end
    
  end
  
end