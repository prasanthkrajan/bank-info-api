#encoding: utf-8 
require "rails_helper"

RSpec.describe UserAccountDetailsPresenter do
  describe 'account_name_and_balance' do
    subject { described_class.new(user_account_details).account_name_and_balance }

    context 'when user account details has valid data' do
      let(:user_account_details) { 
        { 
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
        }
      }

      it 'returns expected account name and balance' do
        expect(subject).to match_array([
          { 
            balance: 20000, 
            name: "A銀行"
          }, 
          { 
            balance: 120000, 
            name: "C信用金庫"
          }, 
          { 
            balance: 5000, 
            name: "E銀行"
          }
        ])
      end
    end

    context 'but user account details is empty' do
      let(:user_account_details) { }

      it 'returns empty' do
        expect(subject).to eql([])
      end
    end  

    context 'but user account details is malformed' do
      let(:user_account_details) { 
        { 
          "datas" => [
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
        }
      }

      it 'returns empty' do
        expect(subject).to eql([])
      end
    end

    context 'but user account details data is malformed' do
      let(:user_account_details) { 
        { 
          "data" => [
            { 
              "balance" => 20000, 
              "id" => 1,
              "name" => "A銀行",
              "user_id" => 1
            },
            { 
              "balance" => 120000, 
              "id" => 3,  
              "name" => "C信用金庫", 
              "user_id" => 1
            }, 
            { 
              "balance" => 5000, 
              "id" => 5, 
              "name" => "E銀行", 
              "user_id" => 1
            }
          ]
        }
      }

      it 'returns a collection of null values' do
        expect(subject).to match_array([
          { 
            balance: nil, 
            name: nil
          }, 
          { 
            balance: nil, 
            name: nil
          }, 
          { 
            balance: nil, 
            name: nil
          }
        ])
      end
    end    
  end
end