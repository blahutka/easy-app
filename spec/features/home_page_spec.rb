#encoding: utf-8
require "spec_helper"

feature "Widget management" do
  scenario "User creates a new widget", :driver => :selenium do
    user = FactoryGirl.create(:valid_user)
      visit "/users/sign_in"

      fill_in "Email", :with => "customer@easyservice.cz"
      fill_in "user_password", :with => "password"
      click_button "Vstup na účet"
      page.should have_content("Přihlášení úspěšné.")

    find('.page-header').click_link('Objednat servis')
    find('.page-header').should have_content('Objednávky přidat')
    #save_and_open_page
  end
end


def customer_login
  user = FactoryGirl.create(:valid_user)
  visit "/users/sign_in"

  fill_in "Email", :with => "customer@easyservice.cz"
  fill_in "user_password", :with => "password"
  click_button "Vstup na účet"
  save_and_open_page
  page.should have_content("Přihlášení úspěšné.")
end