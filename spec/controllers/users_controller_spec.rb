require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #fetch_by_inn" do
    it "returns http success" do
      get :fetch_by_inn
      expect(response).to have_http_status(:success)
    end
  end

end
