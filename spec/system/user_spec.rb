require 'rails_helper'
RSpec.describe 'イベント管理機能', type: :system do
  describe '一覧表示機能' do
    context '操作ができるか' do

      before do
      end

      it 'マイページが見れる' do
        FactoryBot.create(:user)
        visit '/users/sign_in'
        fill_in 'メールアドレス', with: 'test1@example.com'
        fill_in 'パスワード', with: '111111'
        find(:xpath, 'id("new_user")/div[@class="actions"]/input[1]').click

        # visit 'root_path'
        visit '/events'
        click_link 'マイページ'
        expect(page).to have_content('マイページ')
        # expect(User.all).to include User.all[0]

      end
      #
      # it 'ユーザーをフォローできる' do
      # end
      #
      # it 'ユーザーにフォローされる' do
      # end
      #
      # it 'マイページを編集できる' do
      # end
      #
      # it 'マイページに主催したイベント情報が表示されている' do
      # end
      #
      # it 'マイページに参加したイベント情報が表示される' do
      # end
    end
  end
end
