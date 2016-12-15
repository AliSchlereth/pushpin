require 'rails_helper'

feature "Only admin should be able to view admin dashboard" do
  scenario "a guest visits admin dashboard" do
    random_number = rand(1..10)
    visit "/admin/dashboard/#{random_number}"

    expect(page).to have_content("The page you were looking for doesn't exist (404)")
    expect(page).to_not have_content("admin")
  end

  scenario "a requester visits admin dashboard" do
    requester_role = create(:role, title: "requester")
    requester = create(:user)
    requester.roles << requester_role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(requester)

    visit "/admin/dashboard/#{requester.id}"

    expect(page).to have_content("The page you were looking for doesn't exist (404)")
    expect(page).to_not have_content("admin")
  end

  scenario "a professional visits admin dashboard" do
    professional_role = create(:role, title: "professional")
    professional = create(:user)
    professional.roles << professional_role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(professional)

    visit "/admin/dashboard/#{professional.id}"

    expect(page).to have_content("The page you were looking for doesn't exist (404)")
    expect(page).to_not have_content("admin")
  end
end
