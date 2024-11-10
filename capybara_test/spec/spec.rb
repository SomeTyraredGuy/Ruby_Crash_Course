# frozen_string_literal: true

require 'selenium-webdriver'
require 'capybara/rspec'
require_relative 'spec_helper'

RSpec.describe 'Tests' do
  include Capybara::DSL

  before(:each) do
    visit @url
  end

  it "Adding 2 items to cart" do
    username = 'standard_user'
    password = 'secret_sauce'

    fill_in 'user-name', visible: true, with: username
    fill_in 'password', visible: true, with: password
    click_button 'login-button'

    add_to_cart_buttons = page.all('button', text: 'Add to cart')
    expect(add_to_cart_buttons.size).to be >= 2
    
    add_to_cart_buttons[0].click
    add_to_cart_buttons[1].click
    shopping_cart_badge = find('[data-test="shopping-cart-badge"]')
    expect(shopping_cart_badge.text).to eq("2")

  end

  context "Negative login tests" do
    usernames = ['error_user', 'locked_out_user']
    password = 'secret_sauce'
    usernames.each do |username|
      it "#{username} shouldn't be able to login" do
        fill_in 'user-name', visible: true, with: username
        fill_in 'password', visible: true, with: password
        click_button 'login-button'

        expect(page).to have_css('h3[data-test="error"]')
      end
    end
  end
end