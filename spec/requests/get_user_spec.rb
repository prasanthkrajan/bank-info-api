require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /show' do
    before do
      get "/api/v1/users/#{id}"
    end
    context 'and if user is present', vcr: 'requests/get_user/ok' do
      let(:id) { 1 }
      
      it 'returns the preferred user' do
        expect(json['id']).to eql(id.to_s)
        expect(json['name']).to eql('Alice')
        expect(json['accounts']).to match_array([{
          "name" => "A銀行",
          "balance" => 20000
        }, {
          "name" => "C信用金庫",
          "balance" => 120000,
        }, {
          "name" => "E銀行",
          "balance" => 5000
        }])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'but if no user is present', vcr: 'requests/get_user/not_found' do
      let(:id) { 1000 }
      
      it 'returns no user' do
        expect(json.size).to eq(0)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end