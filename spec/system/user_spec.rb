require 'rails_helper'
RSpec.describe 'イベント管理機能', type: :system do
  describe '一覧表示機能' do
    context '操作ができるか' do

      before do
        FactoryBot.create(:user)
        visit '/users/sign_in'
        fill_in 'メールアドレス', with: 'test1@example.com'
        fill_in 'パスワード', with: '111111'
        find(:xpath, 'id("new_user")/div[@class="actions"]/input[1]').click
      end

      it 'マイページが見れる' do
        click_link 'マイページ'
        expect(page).to have_content('マイページ')
      end


      it 'マイページを編集できる' do
        visit '/events'
        click_link 'マイページ'
        click_link 'マイページを編集する'
        fill_in 'user_name', with: 'テスト3'
        click_on 'Update ユーザ'
        expect(page).to have_content('テスト3')
      end

      it 'マイページに主催したイベント情報が表示されている' do
        FactoryBot.create(:event, title:'event345', user_id: User.first.id)
        visit '/events'
        click_link 'マイページ'
        expect(page).to have_content('event345')
      end

      it 'マイページに参加したイベント情報が表示される' do
        user3 = User.create(id:5, name: 'test2', email: 'test2@example.com',password: '111111',user_content: '222', address: '222'  )
        FactoryBot.create(:event, title:'event100',participat_id:user3.id, user_id: User.first.id)
        click_link 'ログアウト'
        fill_in 'メールアドレス', with: "#{user3.email}"
        fill_in 'パスワード', with: '111111'
        find(:xpath, 'id("new_user")/div[@class="actions"]/input[1]').click
        click_link 'マイページ'
        expect(page).to have_content('event100')
      end

      context 'フォロー機能' do
        before do
          user2 = User.create(id:4, name: 'test2', email: 'test2@example.com',password: '111111',user_content: '222', address: '222'  )
          FactoryBot.create(:event, title:'event2', user_id: user2.id)
          visit '/events'
          click_link "#{User.first.events.first.title}の詳細を確認"
          click_link "#{User.first.name}"
          click_on 'このユーザーをフォローする'
        end

        it 'ユーザーをフォローできる' do
          expect(page).to have_button('フォローを解除')
        end

        it 'ユーザーにフォローされる' do
          click_link 'ログアウト'
          fill_in 'メールアドレス', with: "#{User.first.email}"
          fill_in 'パスワード', with: '111111'
          find(:xpath, 'id("new_user")/div[@class="actions"]/input[1]').click
          click_link 'マイページ'
          expect(page).to have_content('あなたをフォローしたユーザー')
        end
      end

    end
  end
end
