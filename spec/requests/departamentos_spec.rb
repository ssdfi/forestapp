require 'rails_helper'

RSpec.describe "Departamentos", :type => :request do
  describe "GET /departamentos" do
    it "works! (now write some real specs)" do
      get departamentos_path
      expect(response.status).to be(200)
    end
  end
end
