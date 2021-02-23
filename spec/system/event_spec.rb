require 'rails_helper'
RSpec.describe 'イベント管理機能', type: :system do
  describe '一覧表示機能' do
    context '操作ができるか' do

      before do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user, name:'test2', email:'test2@example.com', )
        visit '/users/sign_in'
        fill_in 'メールアドレス', with: 'test1@example.com'
        fill_in 'パスワード', with: '111111'
        find(:xpath, 'id("new_user")/div[@class="actions"]/input[1]').click
        FactoryBot.create(:event, date:'2021-02-28',title:'event100', status:"乗",start_point:'梅田',goal_point:'十三',user_id: User.first.id)
        FactoryBot.create(:event, date:'2022-02-28',title:'event101', status:"車",start_point:'中津',goal_point:'茨城',user_id: User.first.id)
        FactoryBot.create(:event, date:'2023-02-28',title:'event102', status:"乗",start_point:'下新庄',goal_point:'上新庄',user_id: user2.id)
        FactoryBot.create(:event, date:'2024-02-28',title:'event103', status:"車",start_point:'三宮',goal_point:'天満',user_id: user2.id)
      end

      it 'ログインできる' do
        expect(page).to have_content('マイページ')
      end

      it 'イベント登録ができる（車側）' do
        FactoryBot.create(:event, title:'event345', status:"車",user_id: User.first.id)
        visit '/events'
        expect(page).to have_content('event345')
      end

      it 'イベント登録ができる（乗る側）' do
        FactoryBot.create(:event, title:'event345', status:"乗",user_id: User.first.id)
        visit '/events'
        expect(page).to have_content('event345')
      end
      #
      it 'タイトル検索' do
        visit '/events'
        fill_in 'q_title_cont', with: '101'
        click_on '検索'
        expect(page).to have_content('event101')
      end
      #
      it 'ゴールから検索' do
        visit '/events'
        fill_in 'q_goal_point_cont', with: '十三'
        click_on '検索'
        expect(page).to have_content('event100')
      end
      #
      it 'スタートから検索' do
        visit '/events'
        fill_in 'q_start_point_cont', with: '中津'
        click_on '検索'
        expect(page).to have_content('event101')
      end

      it 'typeから検索' do
        visit '/events'
        choose 'q_status_eq_1'
        click_on '検索'
        expect(page).to have_content('event101')
        expect(page).to have_content('event103')
        expect(page).to_not have_content('event100')
        expect(page).to_not have_content('event102')

      end

      it '日付から検索' do
        visit '/events'
        fill_in 'q_date_gteq', with: '2023-02-26'.to_date
        click_on '検索'
        expect(page).to have_content('event103')
        expect(page).to_not have_content('event100')
        expect(page).to_not have_content('event101')
        expect(page).to_not have_content('event102')
      end
      #
      it 'イベント情報が見れる' do
        visit '/events'
        expect(page).to have_content('event100')
        expect(page).to have_content('event101')
        expect(page).to have_content('event102')
        expect(page).to have_content('event103')
      end
      #
      it 'イベント情報を削除できる' do
        visit '/events'
        click_link "#{Event.first.title}のイベントを削除する"
        page.driver.browser.switch_to.alert.accept
        expect(page).to_not have_content("#{Event.first.title}")
      end
      #
      it 'イベントに申し込みできる' do
        visit '/events'
        click_link 'ログアウト'
        fill_in 'メールアドレス', with: "#{User.last.email}"
        fill_in 'パスワード', with: '111111'
        find(:xpath, 'id("new_user")/div[@class="actions"]/input[1]').click
        click_link "#{User.first.events.first.title}の詳細を確認"
        click_link "申し込みする"
        page.driver.browser.switch_to.alert.accept
        visit '/events'
        click_link "マイページ"
        expect(page).to have_content("#{User.first.events.first.title}")
      end
      #
      it 'イベント情報をキャンセルできる' do
        visit '/events'
        click_link 'ログアウト'
        fill_in 'メールアドレス', with: "#{User.last.email}"
        fill_in 'パスワード', with: '111111'
        find(:xpath, 'id("new_user")/div[@class="actions"]/input[1]').click
        click_link "#{User.first.events.first.title}の詳細を確認"
        click_link "申し込みする"
        page.driver.browser.switch_to.alert.accept
        visit '/events'
        click_link "マイページ"
        click_link "#{User.first.events.first.title}をキャンセルする"
        expect(page).to_not have_content("#{User.first.events.first.title}")
      end

      it 'イベント情報をソートできる' do
        visit '/events'
        click_link '日付'
        sleep 0.5
        expect(all("tr")[2]).to have_content 'event100'
      end
      #
      it '自分が参加したイベント情報をみることができる' do
        visit '/events'
        click_link 'ログアウト'
        fill_in 'メールアドレス', with: "#{User.last.email}"
        fill_in 'パスワード', with: '111111'
        find(:xpath, 'id("new_user")/div[@class="actions"]/input[1]').click
        click_link "#{User.first.events.first.title}の詳細を確認"
        click_link "申し込みする"
        page.driver.browser.switch_to.alert.accept
        visit '/events'
        click_link "マイページ"
        expect(page).to have_content("#{User.first.events.first.title}")
      end
      #
      it '自分が主催したイベント情報を見ることができる' do
        visit '/events'
        click_link "マイページ"
        expect(page).to have_content("#{User.first.events.first.title}")
        expect(page).to have_content("#{User.first.events.last.title}")
      end
      #
      it '自分が主催したイベントにはもうしこみできない' do
        visit '/events'
        click_link "#{User.first.events.first.title}の詳細を確認"
        expect(page).to_not have_content("申し込みする")
      end



    end
  end
end
