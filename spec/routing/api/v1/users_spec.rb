require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :routing do
  base_folder = 'api/v1'

  it 'routes to index when hits /api/v1/users/1' do
    expect(get("/#{base_folder}/users/1")).to route_to({controller: "#{base_folder}/users", action: 'show', id: '1'})
  end

  it 'does not support other generic routes' do
    expect(post("/#{base_folder}/users")).not_to be_routable
    expect(get("/#{base_folder}/menus")).not_to be_routable
    expect(delete("/#{base_folder}/menus/1")).not_to be_routable
    expect(put("/#{base_folder}/menus/1")).not_to be_routable
    expect(patch("/#{base_folder}/menus/1")).not_to be_routable
  end
end