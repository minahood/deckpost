RSpec.shared_context "micropost_setup" do
    let(:user_post) {create(:micropost,user: user)} 
    let(:user_posts) {create_list(:micropost,3,user: user)} 
    let(:other_user_post) { create(:other_micropost,user: other_user) }
    let(:other_user_posts) { create_list(:other_micropost,30,user: other_user) }
    let(:user_post_recent) { create(:micropost_recent,user: user) }

    let(:mike_post) { create(:mike_micropost,user: mike) }
    let(:riko_post) { create(:riko_micropost,user: riko) }
    let(:aya_post) { create(:aya_micropost,user: aya) }

    #メモ
    #create_listで第3引数(user: --)を指定しないとuserを3回作ろうとしてエラーになる。
end
