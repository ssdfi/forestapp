require 'rails_helper'

RSpec.describe "Actividades", :type => :request do
  describe "GET /actividades" do
    it "works! (now write some real specs)" do
      get actividades_path
      expect(response.status).to be(200)
    end
  end
end
