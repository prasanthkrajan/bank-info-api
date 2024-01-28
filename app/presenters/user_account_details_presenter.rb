class UserAccountDetailsPresenter
	def initialize(user_account_details = {})
		@user_account_details = user_account_details
	end

	def account_name_and_balance
		raw_data.map { |s| { name: s.try(:[], "attributes").try(:[], "name"), balance: s.try(:[], "attributes").try(:[], "balance") } }
	end

	private

	def raw_data
		@user_account_details.try(:[], "data") || {}
	end
end