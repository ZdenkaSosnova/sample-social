require 'rails_helper'

RSpec.describe "Polls", type: :system do
  # =======================================================================
  # ASSIGNMENT: Implement factories to make the setup below work.
  # You need to create factories for: poll, poll_option, poll_vote
  # The test logic is NOT part of this assignment - only the factory setup.
  # =======================================================================

  describe "viewing a poll with custom options" do
    let(:poll) do
      create(:poll,
             question: "What is your favourite programming language?",
             options: ["Ruby", "Python", "JavaScript"]
      )
    end

    it "displays poll question and options" do
      skip "Factory setup assignment - test implementation not required"

      # Factory implementation should result in:
      expect(poll.question).to eq("What is your favourite programming language?")
      expect(poll.poll_options.count).to eq(3)
      expect(poll.poll_options.map(&:option_text)).to eq(["Ruby", "Python", "JavaScript"])
    end
  end

  describe "user can vote only once per poll" do
    let(:poll) { create(:poll) }
    let!(:custom_option) { create(:poll_option, poll: poll, option_text: "Custom option") }
    let(:voter) { create(:user) }
    let!(:vote) { create(:poll_vote, user: voter, poll_option: custom_option) }

    it "prevents duplicate voting" do
      skip "Factory setup assignment - test implementation not required"

      # Factory implementation should result in:
      expect(poll.question).to eq("Sample poll question?")
      expect(poll.poll_options.reload.map(&:option_text)).to include("Custom option")
      expect(vote.user).to eq(voter)
      expect(vote.poll_option).to eq(custom_option)
      expect(poll.voted_by?(voter)).to be true
    end
  end
end