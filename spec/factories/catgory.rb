Factory.define :category do |c|
  c.name  {Faker::Name.name}
  c.category_type 1
end

