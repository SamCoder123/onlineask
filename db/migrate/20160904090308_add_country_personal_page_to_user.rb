class AddCountryPersonalPageToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :country, :string
    add_column :users, :outside_page_link, :string  
  end
end
