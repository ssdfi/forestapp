require 'rails_helper'

RSpec.describe "Especies", :type => :request do
  describe "GET /especies" do
    it "works! (now write some real specs)" do
      get especies_path
      expect(response.status).to be(200)
    end
  end
end
