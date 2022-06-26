require 'rails_helper'

describe 'Cart', :js do
  let(:user) { FactoryBot.create :user }
  let(:lead_magnets) { FactoryBot.create_list(:lead_magnet, 2) }

  before do
    sign_in user
  end

  it 'can be added to' do
    add_lead_magnet_to_cart(lead_magnets.first)
    find('h1', text: 'Cart')
    expect(page).to have_content 'Successfully added Item to Cart'
    expect(page).to have_content lead_magnets.first.title
  end

  it 'does not support duplicates' do
    3.times { add_lead_magnet_to_cart(lead_magnets.first) }
    expect(page).to have_content 'This Item is already in your Cart'
    expect(page).to have_content lead_magnets.first.title
  end

  scenario 'allows items to be removed from the cart' do
    add_lead_magnet_to_cart(lead_magnets.first)
    click_on 'Remove'
    expect(page).to have_content 'Successfully removed Item from Cart'
    expect(page).to have_content 'Your Cart is Empty.'
  end
end
