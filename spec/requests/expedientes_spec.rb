require 'rails_helper'

RSpec.describe "Expedientes", :type => :request do
  describe "GET /expedientes" do
    it "works! (now write some real specs)" do
      get expedientes_path
      expect(response.status).to be(200)
    end
  end
end
