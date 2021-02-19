require 'rails_helper'
describe 'ユーザーモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'サインアップ時' do

      it 'ユーザーの名前が空の場合' do
        user = User.new(name: '')
        expect(user).not_to be_valid
      end

      it 'ユーザーのemailが空の場合' do
        user = User.new(email: '')
        expect(user).not_to be_valid
      end

      it 'ユーザーのpasswordが空の場合' do
        user = User.new(password: '')
        expect(user).not_to be_valid
      end

      it '名前、email、passが入力された場合無事サインアップできる' do
        user = FactoryBot.create(:user)
        expect(user).to be_valid
      end

    end
  end
end
