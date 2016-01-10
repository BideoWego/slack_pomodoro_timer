module Support
  module Config
    def write_config(path, value)
      File.open(path, "w+") do |file|
        file.write(YAML.dump(value))
      end
    end


    def read_config(path)
      File.read(path)
    end
  end
end


