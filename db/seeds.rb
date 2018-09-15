require 'open-uri'
require 'json'
require "nokogiri"


puts "Dropping database!"
Ingredient.destroy_all
Cocktail.destroy_all
User.destroy_all
puts "Done."

puts "Resetting id's..."
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
puts "Done!"

puts "Creating user..."
User.create!([{
  email: 'negroni@cool.com',
  password: '123456',
  first_name: 'Wolfgang',
  last_name: "Petry",
},
{
  email: 'thirsty@cool.com',
  password: '123456',
  first_name: 'Thirsty',
  last_name: "Thursday",
},
{
  email: 'dry@3.com',
  password: '123456',
  first_name: 'Dry',
  last_name: "Martini",
}
]);

puts "Create #{User.count} User."

# url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
# file = open(url).read
# ingredients = JSON.parse(file)

# puts "Creating ingredients!"

# ingredients["drinks"].each do |ingredient|
#   Ingredient.create(name: ingredient["strIngredient1"])
# end
# puts "Finished! #{Ingredient.all.count} Ingredients have been created."

url = "https://www.cocktaildb.com/cocktail-recipes-collections/"
html_file = open(url).read
doc = Nokogiri::HTML(html_file)

puts "Creating cocktails..."

doc.search('h2').take(6).each do |title|
  new_cocktail = Cocktail.new({
    name: title.text.strip,
    user_id: rand(1..3),
  })
  new_cocktail.save!
end

puts "Create #{Cocktail.count} cocktails."
# puts "Assigning images to #{Cocktail.count} cocktails."

puts "Have a sip."

# puts "Creating cocktail #{@recipes_urls.index(url)}...."
# new_cocktail = Cocktail.new({
#   name: doc.search('.thrv_wrapper .thrv_text_element').text.strip,
# })
# new_cocktail.save!

# puts "Created #{Cocktail.last.name} - total #{Cocktail.count}"
