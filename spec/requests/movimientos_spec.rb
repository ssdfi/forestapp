require 'rails_helper'

RSpec.describe "Movimientos", :type => :request do
  describe "GET /movimientos" do
    it "works! (now write some real specs)" do
      get movimientos_path
      expect(response.status).to be(200)
    end
  end
end
