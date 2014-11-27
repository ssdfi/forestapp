require 'rails_helper'

RSpec.describe "Plantaciones", :type => :request do
  describe "GET /plantaciones" do
    it "works! (now write some real specs)" do
      get plantaciones_path
      expect(response.status).to be(200)
    end
  end
end
