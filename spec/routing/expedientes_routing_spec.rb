require "rails_helper"

RSpec.describe ExpedientesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/expedientes").to route_to("expedientes#index")
    end

    it "routes to #new" do
      expect(:get => "/expedientes/new").to route_to("expedientes#new")
    end

    it "routes to #show" do
      expect(:get => "/expedientes/1").to route_to("expedientes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/expedientes/1/edit").to route_to("expedientes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/expedientes").to route_to("expedientes#create")
    end

    it "routes to #update" do
      expect(:put => "/expedientes/1").to route_to("expedientes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/expedientes/1").to route_to("expedientes#destroy", :id => "1")
    end

  end
end
