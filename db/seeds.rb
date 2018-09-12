require 'open-uri'
require 'json'
require "nokogiri"

puts "Dropping database!"
Ingredient.destroy_all
Cocktail.destroy_all
User.destroy_all
puts "Done."
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

doc.search('h2').each do |title|
  new_cocktail = Cocktail.new({
    name: title.text.strip
  })
  new_cocktail.save!
end

puts "Create #{Cocktail.count} cocktails."
puts "Have a sip."

# puts "Creating cocktail #{@recipes_urls.index(url)}...."
# new_cocktail = Cocktail.new({
#   name: doc.search('.thrv_wrapper .thrv_text_element').text.strip,
# })
# new_cocktail.save!

# puts "Created #{Cocktail.last.name} - total #{Cocktail.count}"
