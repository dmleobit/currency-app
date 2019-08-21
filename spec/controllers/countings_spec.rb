require "rails_helper"

RSpec.describe CountingsController, type: :controller do
  scenario "Check not login user" do
    visit countings_path
    expect(page).to have_link("Sign In/Sign Up")
  end

  scenario "Chech counting index not login" do
    get :index
    expect(response.code).to eq("302")
  end

  scenario "Chech counting index login" do
    user = create(:user)
    get :index, session: { user_id: user.id }

    expect(response.code).to eq("200")
  end
end
