Factory.define :category do |c|
  c.name  {Faker::Name.name}
  c.category_type 1
  c.image_path "Arts_crafts.jpg"
end

Factory.define :s_category, :class => Category do |c|
  c.name  {Faker::Name.name}
  c.category_type 2
  c.image_path "Arts_crafts.jpg"
end

