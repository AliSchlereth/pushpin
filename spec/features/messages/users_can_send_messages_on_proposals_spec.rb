require 'rails_helper'

feature "A user can send messages on a proposal" do
  context "When a requester visits a proposal" do
    scenario "they can send a message" do
      user1, user2 = create_list(:user, 2)
      requester, professional= create_list(:role, 2)
      user1.roles << requester
      user2.roles << professional
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      project = create(:project, user: user1)
      proposal = create(:proposal, user: user2, project: project)

      visit requester_proposal_path(proposal)
      message = "Would you like some iced tea, dearie?"

      fill_in "message_body", with: message
      click_button "Submit"

      expect(page).to have_content(message)
    end
  end

  context "When a requester visits a proposal" do
    scenario "they can send a message" do
      user1, user2 = create_list(:user, 2)
      requester = create(:role, title: "requester")
      professional = create(:role, title: "professional")
      user1.roles << requester
      user2.roles << professional
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
      project = create(:project, user: user1)
      proposal = create(:proposal, user: user2, project: project)

      visit professional_proposal_path(proposal)
      message = "No thanks."

      fill_in "message_body", with: message
      click_button "Submit"

      expect(page).to have_content(message)
    end
  end

  scenario "A professional can see a requester's messages" do
      user1, user2 = create_list(:user, 2)
      requester = create(:role, title: "requester")
      professional = create(:role, title: "professional")
      user1.roles << requester
      user2.roles << professional
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
      project = create(:project, user: user1)
      proposal = create(:proposal, user: user2, project: project)
      message = proposal.messages.create(body: "test body", user: user1)

      visit professional_proposal_path(proposal)

      expect(page).to have_content(message.body)
  end

  scenario "A requester can see a professional's messages" do
      user1, user2 = create_list(:user, 2)
      requester = create(:role, title: "requester")
      professional = create(:role, title: "professional")
      user1.roles << requester
      user2.roles << professional
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      project = create(:project, user: user1)
      proposal = create(:proposal, user: user2, project: project)
      message = proposal.messages.create(body: "test body", user: user2)

      visit requester_proposal_path(proposal)

      expect(page).to have_content(message.body)
  end
end
