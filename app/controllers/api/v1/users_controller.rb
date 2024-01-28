class Api::V1::UsersController < Api::V1::BaseController
	def show
		data = UsersFacade.new(params[:id]).user_and_account_details
		render json: data, status: :ok
	end
end