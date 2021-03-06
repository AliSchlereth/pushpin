require 'rails_helper'

RSpec.describe Proposal, type: :model do
  context "relationships" do
    it "responds to project" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      proposal = Proposal.create(project: project, user: user)

      expect(proposal).to respond_to(:project)
    end

    it "responds to user" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      proposal = Proposal.create(project: project, user: user)

      expect(proposal).to respond_to(:user)
    end

    it "responds to messages" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      proposal = Proposal.create(project: project, user: user)
      message = Message.create(user: user, proposal: proposal, image_url: "http", body: "body of text")

      expect(proposal).to respond_to(:messages)
    end

    it "responds to users" do
      user = User.create(status: "active", name: "Name", username: "Uname", location: "Place", email: "e@email.com", phone: "12345667890", password_digest: "password")
      project = Project.create(name: "Name", user: user, status: "active")
      proposal = Proposal.create(project: project, user: user)
      message = Message.create(user: user, proposal: proposal, image_url: "http", body: "body of text")

      expect(proposal).to respond_to(:users)
    end
  end

  context "methods" do
    context "#messages_by_most_recent" do
      it "returns the messages in order of recency" do
        proposal = create(:proposal)
        proposal.messages.create(body: "test1")
        proposal.messages.create(body: "test2")
        messages = proposal.messages_by_most_recent

        expect(messages.first.body).to eq("test2")
      end
    end
  end
end
