module OneHundred
  module DeviceSizeManager
    module_function

    def select_sizes
      case UIDevice.currentDevice.name
        when /iPhone/; SizesIPhone.new
        when /iPad/  ; SizesIPad.new
        else         ; raize "Unsupported Device [#{UIDevice.currentDevice.name}]"
      end
    end
  end
end

OH = OneHundred unless defined?(OH)
