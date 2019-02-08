module GlobalStorage
  module StoreCSV
    require 'csv'
    require 'snake_camel'

    def write_to_csv(headers, records)
      CSV.open(csv_filename, 'wb') do |csv|
        csv << headers
        records.each do |record|
          if record.is_a?(Array)
            csv << record
          else
            csv << headers.map { |attr| record.send(attr) }
          end
        end
      end
    end

    def save_as_csv
      write_to_csv(instance_headers, self.all)
    end

    def load_from_csv
      read_from_csv.each do |record|
        self.new(record)
      end
    end

    def read_from_csv
      csv_body.map { |record| Hash[csv_headers.zip(record)] }
    end

    def save_record(record)
      records = csv_body
      index = csv_index_of(record)
      if index
        records[index] = record
      else
        records << record
      end
      write_to_csv(csv_headers, records)
    end

    def destroy_record(record)
      records = csv_body
      if records.delete_at(csv_index_of(record))
        write_to_csv(csv_headers, records)
      end
    end

    def csv_index_of(record)
      csv_body.index(csv_body.find { |row| row[csv_headers.index('id')].to_i == record.id.to_i } )
    end

    def csv_exist?
      File.exist?(csv_filename)
    end

    def csv_contains?(record)
      csv_contains_id?(record.id)
    end

    def csv_cantains_id?(id)
      csv_body.any? { |row| row[csv_headers.index('id')] == id }
    end

    def csv_filename
      "./#{class_name.snakecase}.csv"
    end

    def csv_raw
      { headers: csv_headers, body: csv_body }
    end

    private

    def csv_headers
      csv_data.to_a.shift
    end

    def csv_body
      csv_data.to_a[1..-1]
    end

    def class_name
      self.name
    end

    def csv_data
      CSV.read(csv_filename, headers: true)
    end

    def instance_headers
      self.first.instance_variables.map { |var| var.to_s[1..-1] }
    end
  end
end
