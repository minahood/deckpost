require 'rails_helper'

RSpec.describe "User_relationship", type: :request do
    include_context "user_setup"
    before do
        user
        users
        users.each do |u|
            u.follow(user)
            user.follow(u)
        end
        other_user
    end
    
    describe "when not_logged_in," do
        it "redirect login_path if follow" do
            expect do
               post relationships_path
            end.to change(Relationship,:count).by(0)
            expect(response).to redirect_to login_path
        end
    
        it "redirect login_path if unfollow" do
            expect do
                delete relationship_path(1)
            end.to change(Relationship,:count).by(0)
            expect(response).to redirect_to login_path
        end
    end

    describe "when logged_in," do
        before do 
            log_in_as(user)
        end

        it "follow a user standard way" do
            expect do
                post relationships_path, params: { followed_id: other_user.id }
            end.to change(Relationship,:count).by(1)
        end

        it "follow a user with Ajax" do
            expect do
                post relationships_path, params: { followed_id: other_user.id }
            end.to change(Relationship,:count).by(1)
        end

        it "unfollow a user standard way" do
            user.follow(other_user)
            relationship = user.active_relationships.find_by(followed_id: other_user.id)
            expect do
                delete relationship_path(relationship)
            end.to change(Relationship,:count).by(-1)
        end

        it "unfollow a user with Ajax" do
            user.follow(other_user)
            relationship = user.active_relationships.find_by(followed_id: other_user.id)
            expect do
                delete relationship_path(relationship), xhr: true
            end.to change(Relationship,:count).by(-1)
        end
    end
end
