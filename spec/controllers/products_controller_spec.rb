RSpec.describe ProductsController, type: :controller do

  describe "GET #search" do
    it "returns http success" do
      get :search, name: ''
      expect(response).to have_http_status(:success)
    end
  end

end
