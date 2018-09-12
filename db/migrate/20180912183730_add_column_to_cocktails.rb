class AddColumnToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_reference :cocktails, :user, index: true
  end
end
