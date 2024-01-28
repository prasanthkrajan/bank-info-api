#encoding: utf-8 
require "rails_helper"

RSpec.describe UserDetailsPresenter do
  describe 'name' do
    let(:expected_name) { "John Smith" }
    subject { described_class.new(user_details).name }

    context 'when user details has valid data' do
      let(:user_details) { 
        { 
          "data" => {
            "attributes" => {
              "account_ids" => [1, 3, 5], 
              "id" => 1, 
              "name" => expected_name
            }
          }
        }
      }

      it 'returns expected name' do
        expect(subject).to eql(expected_name)
      end
    end

    context 'but user details is empty' do
      let(:user_details) { }

      it 'returns null' do
        expect(subject).to be_nil
      end
    end  

    context 'but user details is malformed' do
      let(:user_details) { 
        { 
          "data" => {
            "account_ids" => [1, 3, 5], 
            "id" => 1, 
            "name" => expected_name
          }
        }
      }

      it 'returns null' do
        expect(subject).to be_nil
      end
    end    
  end

  describe 'id' do
    let(:expected_id) { 10 }
    subject { described_class.new(user_details).id }

    context 'when user details has valid data' do
      let(:user_details) { 
        { 
          "data" => {
            "attributes" => {
              "account_ids" => [1, 3, 5], 
              "id" => expected_id, 
              "name" => "Alice"
            }
          }
        }
      }

      it 'returns expected id' do
        expect(subject).to eql(expected_id)
      end
    end

    context 'but user details is empty' do
      let(:user_details) { }

      it 'returns null' do
        expect(subject).to be_nil
      end
    end  

    context 'but user details is malformed' do
      let(:user_details) { 
        { 
          "data" => {
            "account_ids" => [1, 3, 5], 
            "id" => expected_id, 
            "name" => "Alice"
          }
        }
      }

      it 'returns null' do
        expect(subject).to be_nil
      end
    end    
  end

  describe 'account_ids' do
    let(:expected_account_ids) { [1, 3, 5] }
    subject { described_class.new(user_details).account_ids }

    context 'when user details has valid data' do
      let(:user_details) { 
        { 
          "data" => {
            "attributes" => {
              "account_ids" => [1, 3, 5], 
              "id" => 1, 
              "name" => "Alice"
            }
          }
        }
      }

      it 'returns expected account_ids' do
        expect(subject).to eql(expected_account_ids)
      end
    end

    context 'but user details is empty' do
      let(:user_details) { }

      it 'returns null' do
        expect(subject).to be_nil
      end
    end  

    context 'but user details is malformed' do
      let(:user_details) { 
        { 
          "data" => {
            "account_ids" => expected_account_ids, 
            "id" => 1, 
            "name" => "Alice"
          }
        }
      }

      it 'returns null' do
        expect(subject).to be_nil
      end
    end    
  end
end