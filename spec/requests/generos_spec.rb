require 'rails_helper'

RSpec.describe "Generos", :type => :request do
  describe "GET /generos" do
    it "works! (now write some real specs)" do
      get generos_path
      expect(response.status).to be(200)
    end
  end
end
