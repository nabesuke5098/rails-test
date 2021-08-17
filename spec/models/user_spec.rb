# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  birthday        :date
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#age' do
    before do
      allow(Time.zone).to receive(:now).and_return(Time.zone.parse('2021/08/18'))
    end

    context '20年前の生年月日の場合' do
      let(:user) { User.new(birthday: Time.zone.now - 20.years) }

      it '年齢が20歳であること' do
        expect(user.age).to eq 20
      end
    end

    context '10年前に生まれた場合で丁度誕生日の場合' do
      let(:user) { User.new(birthday: Time.zone.parse('2011/08/18')) }

      it '年齢が10歳であること' do
        expect(user.age).to eq 10
      end
    end

    context '10年前に生まれた場合で誕生日前日である場合' do
      let(:user) { User.new(birthday: Time.zone.parse('2011/08/19')) }

      it '年齢が9歳であること' do
        expect(user.age).to eq 9
      end
    end
  end
end
