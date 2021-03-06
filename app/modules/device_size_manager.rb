module OneHundred
  module DeviceSizeManager
    module_function

    def select_sizes
      case UIDevice.currentDevice.model
        when /iPhone/; SizesIPhone.new
        when /iPod/;   SizesIPhone.new
        when /iPad/  ; SizesIPad.new
        else
          puts "Unsupported Device [#{UIDevice.currentDevice.model}] is detected." if BW2.debug?
          SizesIPhone.new
      end
    end
  end
end

OH = OneHundred unless defined?(OH)