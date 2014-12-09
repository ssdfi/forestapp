require 'rails_helper'

RSpec.describe "Zonas", :type => :request do
  describe "GET /zonas" do
    it "works! (now write some real specs)" do
      get zonas_path
      expect(response.status).to be(200)
    end
  end
end
