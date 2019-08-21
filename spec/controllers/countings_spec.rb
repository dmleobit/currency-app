require "rails_helper"

RSpec.describe CountingsController, type: :controller do
  scenario "Check not login user" do
    visit countings_path
    expect(page).to have_link("Sign In/Sign Up")
  end
end
