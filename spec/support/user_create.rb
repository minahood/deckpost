RSpec.shared_context "user_setup" do
    let(:user) { create(:user) }
    let(:other_user) { create(:other_user) }
    let(:admin_user) {create(:admin_user)}
    let(:users) { create_list(:other_user, 30) }
    
    let(:mike) { create(:mike) }
    let(:riko) { create(:riko) }
    let(:aya) { create(:aya) }
end
