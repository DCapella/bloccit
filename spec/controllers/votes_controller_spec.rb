require 'rails_helper'
include SessionsHelper

RSpec.describe VotesController, type: :controller do
  let(:my_topic) { create(:topic) }
  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:user_post) { create(:post, topic: my_topic, user: other_user) }
  let(:my_vote) { Vote.create!(value: 1) }

  context "guest" do
    describe "POST up_vote" do
      it "redirects the user to the sign in view" do
        # Goes to up_vote with id of no current user
        post :up_vote, post_id: user_post.id
        # because of the response it should go to the new_session_path
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "POST down_vote" do
      it "redirects the user to the sign in view" do
        delete :down_vote, post_id: user_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context "signed in user" do
    before do
      # creating a session with a user
      create_session(my_user)
      # 'HTTP_REFERER' is an HTTP header set by the browser in the request containing
      # the address of the previous web page,
      # from which a link to the currently requested page was followed. It will
      # not be set when directly navigating to a page
      request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
    end

    describe "POST up_vote" do
      it "the users first vote increases number of post votes by one" do
        # Set votes to the count of votes from user_post
        votes = user_post.votes.count
        # Goes to up_vote with post_id of user_post.id
        post :up_vote, post_id: user_post.id
        expect(user_post.votes.count).to eq(votes + 1)
      end

      it "the users second vote does not increase the number of votes" do
        # Goes to up_vote with post_id of user_post.id
        post :up_vote, post_id: user_post.id
        # Set votes to the count of votes from user_post
        votes = user_post.votes.count
        # Goes a second time to up_vote with post_id of user_post.id
        post :up_vote, post_id: user_post.id
        # Vote should not have went up
        expect(user_post.votes.count).to eq(votes)
      end

      it "increases the sum of post votes by one" do
        # Set points to the attribute points of user_post
        points = user_post.points
        # Goes to up_vote with post_id of user_post.id
        post :up_vote, post_id: user_post.id
        # Total points should have gone up by one
        expect(user_post.points).to eq(points + 1)
      end

      it ":back redirects to posts show page" do
        # HTTP_REFERER is an HTTP header set by the browser in the request containing
        # the address of the previous web page
        # from which a link to the currently  requested page was followed. It will
        # not be set when directly navigating to a page.
        request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
        # Goes to up_vote with post_id of user_post.id
        post :up_vote, post_id: user_post.id
        expect(response).to redirect_to([my_topic, user_post])
      end

      it ":back redirects to post topic show" do
        # HTTP_REFERER is an HTTP header set by the browser in the request containing the
        # address of the previous web page from which a link to the currently requested
        # page was followed. It will not be set when directly navigating to a page
        request.env["HTTP_REFERER"] = topic_path(my_topic)
        # Goes to up_vote with post_id of user_post.id
        post :up_vote, post_id: user_post.id
        expect(response).to redirect_to(my_topic)
      end
    end

    describe "POST down_vote" do
      it "the users first vote increases number of post votes by one" do
        votes = user_post.votes.count
        post :down_vote, post_id: user_post.id
        expect(user_post.votes.count).to eq(votes + 1)
      end

      it "the users second vote does not increase the number of votes" do
        post :down_vote, post_id: user_post.id
        votes = user_post.votes.count
        post :down_vote, post_id: user_post.id
        expect(user_post.votes.count).to eq(votes)
      end

      it "decreases the sum of post votes by one" do
        points = user_post.points
        post :down_vote, post_id: user_post.id
        expect(user_post.points).to eq(points - 1)
      end

      it ":back redirects to posts show page" do
        request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
        post :down_vote, post_id: user_post.id
        expect(response).to redirect_to([my_topic, user_post])
      end

      it ":back redirects to posts topic show" do
        request.env["HTTP_REFERER"] = topic_path(my_topic)
        post :down_vote, post_id: user_post.id
        expect(response).to redirect_to(my_topic)
      end
    end
  end
end
