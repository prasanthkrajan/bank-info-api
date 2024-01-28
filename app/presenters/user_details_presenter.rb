class UserDetailsPresenter
	def initialize(user_details = {})
		@user_details = user_details
	end

	def name
		raw_data["name"]
	end

	def id
		raw_data["id"]
	end

	def account_ids
		raw_data["account_ids"]
	end

	private

	def raw_data
		@user_details.try(:[], "data").try(:[], "attributes") || {}
	end
end