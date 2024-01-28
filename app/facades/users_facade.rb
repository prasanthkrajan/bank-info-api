class UsersFacade
	def initialize(user_id)
		@user_id = user_id
	end

	def user_details
		@user_details ||= ApiDataRetriever.call(path: "/users/#{@user_id}")
		raise Exceptions::UserNotFoundError if @user_details["error"]
		@user_details
	end

	def user_account_details
		@user_account_details ||= ApiDataRetriever.call(path: "/users/#{@user_id}/accounts")
		raise Exceptions::UserNotFoundError if @user_account_details["error"]
		@user_account_details
	end

	def user_and_account_details
		{
			id: @user_id,
			name: user_details["data"]["attributes"]["name"],
			accounts: user_account_details["data"].map { |s| { name: s["attributes"]["name"], balance: s["attributes"]["balance"] } }
		}
	end
end
