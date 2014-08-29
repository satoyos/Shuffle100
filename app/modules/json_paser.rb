module OneHundred
  module JSONParser

    module_function

    # read JSON file from path_str in /resources folder
    def parse(json_str)
      e = Pointer.new(:object)
      NSJSONSerialization.JSONObjectWithData(
          json_str.dataUsingEncoding(NSUTF8StringEncoding),
          options: 0,
          error: e)
    end

    def parse_from_file(path_str)
      path = NSBundle.mainBundle.resourcePath.stringByAppendingPathComponent path_str
      self.parse(File.read(path))
    end

  end
end

OH = OneHundred unless defined?(OH)