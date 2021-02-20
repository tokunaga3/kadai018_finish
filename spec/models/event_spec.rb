require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'イベントのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        event = Event.new(title: '')
        expect(event).not_to be_valid
      end
    end
    context 'イベントの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        event = Event.new(content: '')
        expect(event).not_to be_valid
      end
    end
    context 'イベントのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        event = Event.new(title: '', content: '')
        expect(event).not_to be_valid
      end
    end
  end
end
