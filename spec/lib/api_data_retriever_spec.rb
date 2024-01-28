#encoding: utf-8 
require "rails_helper"

RSpec.describe ApiDataRetriever do
  describe '.call' do
    subject { described_class.call(path: path) }

    context 'when testing users endpoint' do
      context 'and endpoint is valid and up and running', vcr: 'lib/api_data_retriever/users/ok' do
        let(:path) { '/users/1' }

        it 'returns raw data successfully' do
          expect(subject).to eql({
            "data" => {
              "attributes" => {
                "account_ids" => [1, 3, 5], 
                "id" => 1, 
                "name" => "Alice"
              }
            }
          })
        end
      end

      context 'but user is not found', vcr: 'lib/api_data_retriever/users/not_found' do
        let(:path) { '/users/1000' }
        
        it 'returns error' do
          expect(subject).to eql({ "error" => 'Unable to fetch data due to error 404' })
        end
      end

      context 'but endpoint is malformed', vcr: 'lib/api_data_retriever/users/malformed' do
        let(:path) { '/userss/1' }
        
        it 'returns error' do
          expect(subject).to eql({ "error" => 'Unable to fetch data due to error 404' })
        end
      end
    end

   

    context 'when testing accounts endpoint' do
      context 'and endpoint is valid and up and running', vcr: 'lib/api_data_retriever/accounts/ok' do
        let(:path) { '/users/1/accounts' }

        it 'returns raw data successfully' do
          expect(subject).to eql({
            "data" => [
              { 
                "attributes" => {
                  "balance" => 20000, 
                  "id" => 1,
                  "name" => "A銀行",
                  "user_id" => 1 }
                }, 
              { 
                "attributes" => {
                  "balance" => 120000, 
                  "id" => 3,  
                  "name" => "C信用金庫", 
                  "user_id" => 1
                }
              }, 
              { 
                "attributes" => {
                  "balance" => 5000, 
                  "id" => 5, 
                  "name" => "E銀行", 
                  "user_id" => 1
                }
              }
            ]
          })
        end
      end

      context 'but account is not found', vcr: 'lib/api_data_retriever/accounts/not_found' do
        let(:path) { '/users/1000/accounts' }
        
        it 'returns error' do
          expect(subject).to eql({ "error" => 'Unable to fetch data due to error 404' })
        end
      end

      context 'but endpoint is malformed', vcr: 'lib/api_data_retriever/accounts/malformed' do
        let(:path) { '/userss/1/accounts' }
        
        it 'returns error' do
          expect(subject).to eql({ "error" => 'Unable to fetch data due to error 404' })
        end
      end
    end

    context 'when testing specific account endpoint' do
      context 'and endpoint is valid and up and running', vcr: 'lib/api_data_retriever/specific_account/ok' do
        let(:path) { '/accounts/2' }

        it 'returns raw data successfully' do
          expect(subject).to eql({
            "data" => {
              "attributes" => {
                "balance" => 200, 
                "id" => 2, 
                "name" => "Bカード", 
                "user_id" => 2
              }
            }
          })
        end
      end

      context 'but account is not found', vcr: 'lib/api_data_retriever/specific_account/not_found' do
        let(:path) { '/accounts/2000' }
        
        it 'returns error' do
          expect(subject).to eql({ "error" => 'Unable to fetch data due to error 404' })
        end
      end

      context 'but endpoint is malformed', vcr: 'lib/api_data_retriever/specific_account/malformed' do
        let(:path) { '/accountss/2' }
        
        it 'returns error' do
          expect(subject).to eql({ "error" => 'Unable to fetch data due to error 404' })
        end
      end
    end
  end
end