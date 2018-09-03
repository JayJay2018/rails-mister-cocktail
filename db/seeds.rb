require 'open-uri'
require 'json'

puts "Dropping database!"
Ingredient.destroy_all
puts "Done."
url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
file = open(url).read
ingredients = JSON.parse(file)

puts "Creating ingredients!"

ingredients["drinks"].each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end
puts "Finished! #{Ingredient.all.count} Ingredients have been created."
