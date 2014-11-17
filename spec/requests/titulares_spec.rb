require 'rails_helper'

RSpec.describe "Titulares", :type => :request do
  describe "GET /titulares" do
    it "works! (now write some real specs)" do
      get titulares_path
      expect(response.status).to be(200)
    end
  end
end
