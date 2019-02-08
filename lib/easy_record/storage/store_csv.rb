module Storage
  module StoreCSV
    require 'csv'
    require 'snake_camel'

    def save_as_csv

    end

    def load_from_csv
    end

    private

    def csv_filename
      "./#{class_name.snakecase}.csv"
    end

    def class_name
      self.class.name
    end

    def csv_data
      CSV.read(csv_filename, headers: true)
    end

    def attrs
      self.instance_variables.map { |var| var.to_s[1..-1] }
    end
  end
end
