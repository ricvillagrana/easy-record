Gem::Specification.new do |s|
  s.name        = 'easy-record'
  s.version     = '0.1.1.alpha2'
  s.summary     = "Easy Record"
  s.description = "Easy Record allows you to create associations between models and store them in disk"
  s.authors     = ["Ricardo Rafael Villagrana Larios"]
  s.email       = 'ricardovillagranal@gmail.com '
  s.homepage    = 'https://ricvillagrana.github.io/easy-record/'
  s.metadata    = { "source_code_uri" => "https://github.com/ricvillagrana/easy-record" }
  s.files       = [
    "lib/easy_record.rb",
    "lib/easy_record/association.rb",
    "lib/easy_record/record.rb",
    "lib/easy_record/storage",
    "lib/easy_record/global_storage/store_csv.rb",
    "lib/easy_record/storage/store_csv.rb",
  ]
end
