require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /show' do
    before do
      get "/api/v1/users/#{user_id}"
    end
    context 'and if user is present' do
      let(:user_id) { 1 }
      
      it 'returns the preferred user' do
        expect(json[:id]).to eql(user_id)
        expect(json[:name]).to eql('Alice')
        expect(json[:account]).to match_array([{
          name: "A銀行",
          balance: 20000
        }, {
          name: "C信用金庫",
          balance: 120000,
        }, {
          name: "E銀行",
          balance: 5000
        }])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'but if no user is present' do
      let(:user_id) { 1000 }
      
      it 'returns no user' do
        expect(json.size).to eq(0)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end