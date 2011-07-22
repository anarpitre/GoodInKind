Factory.define :service_category do |sc|
  sc.association :category
  sc.association :service
end
