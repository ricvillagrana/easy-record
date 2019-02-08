module Storage
  module StoreCSV
    require 'csv'
    require 'snake_camel'

    def save_as_csv
      CSV.open("./#{self.name.snakecase}.csv", 'wb') do |csv|
        # Headers
        csv << attrs
        self.all.each do |record|
          csv << attrs.map { |attr| record.send(attr) }
        end
      end
    end

    def load_from_csv
      data = csv_data.to_a
      headers = data.shift

      records = data.map { |record| Hash[headers.zip(record)] }

      records.each do |record|
        self.new(record)
      end
    end

    private

    def csv_data
      CSV.read("./#{self.name.snakecase}.csv", headers: true)
    end

    def attrs
      self.first.instance_variables.map { |var| var.to_s[1..-1] }
    end
  end
end
