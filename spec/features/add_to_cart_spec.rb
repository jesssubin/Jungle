require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
   # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
   
    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

  scenario "Number of items in cart increase by 1 when add to cart button was clicked"
  #ACT
    visit root_path 
    expect(page).to have_text 'My Cart (0)'

    first('button.btn.btn-primary').clicked
    puts page.html

    expect(page).to have_text 'My Cart(1)'
end
