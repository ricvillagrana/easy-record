module Storage
  module StoreCSV
    require 'csv'
    require 'snake_camel'

    def save
      self.class.save_record(self)
    end

    def destroy_from_csv
      self.class.destroy_record(self)
    end

    private

    def csv_filename
      "./#{class_name.snakecase}.csv"
    end

    def class_name
      self.class.name
    end

    def headers
      csv_data.to_a.shift
    end

    def body
      csv_data.to_a[1..-1]
    end

    def csv_data
      CSV.read(csv_filename, headers: true)
    end

    def attrs
      self.instance_variables.map { |var| var.to_s[1..-1] }
    end
  end
end
