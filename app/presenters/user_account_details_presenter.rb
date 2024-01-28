class UserAccountDetailsPresenter
	def initialize(user_account_details = {})
		@user_account_details = user_account_details
	end

	def account_name_and_balance
		raw_data.map { |s| { name: s["attributes"]["name"], balance: s["attributes"]["balance"] } }
	end

	private

	def raw_data
		@user_account_details["data"]
	rescue
		{}
	end
end