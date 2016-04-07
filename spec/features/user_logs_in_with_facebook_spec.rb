require 'rails_helper'

RSpec.feature "UserLogsInWithFacebook", type: :feature do

  before do
    stub_omniauth
  end

  scenario "user logs in with facebook" do
    Capybara.app = MakingTheBand::Application

    visit '/'
    click_link "login"
    assert page.has_content?("Horace")
    assert page.has_link?("logout")

  end
end
