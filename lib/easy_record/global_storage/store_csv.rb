module GlobalStorage
  module StoreCSV
    require 'csv'
    require 'snake_camel'

    def save_as_csv
      CSV.open(csv_filename, 'wb') do |csv|
        csv << attrs
        self.all.each do |record|
          csv << attrs.map { |attr| record.send(attr) }
        end
      end
    end

    def load_from_csv
      records = body.map { |record| Hash[headers.zip(record)] }
      records.each do |record|
        self.new(record)
      end
    end

    def csv_exist?
      File.exist?(csv_filename)
    end

    def csv_filename
      "./#{class_name.snakecase}.csv"
    end

    private

    def headers
      csv_data.to_a.shift
    end

    def body
      csv_data.to_a[1..-1]
    end

    def class_name
      self.name
    end

    def csv_data
      CSV.read(csv_filename, headers: true)
    end

    def attrs
      self.first.instance_variables.map { |var| var.to_s[1..-1] }
    end
  end
end
