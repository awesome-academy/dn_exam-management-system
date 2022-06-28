require 'rails_helper'

RSpec.describe "Histories", type: :request do

  describe "GET /update" do
    it "returns http success" do
      get "/histories/update"
      expect(response).to have_http_status(:success)
    end
  end

end
