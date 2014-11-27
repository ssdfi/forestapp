require "rails_helper"

RSpec.describe PlantacionesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/plantaciones").to route_to("plantaciones#index")
    end

    it "routes to #new" do
      expect(:get => "/plantaciones/new").to route_to("plantaciones#new")
    end

    it "routes to #show" do
      expect(:get => "/plantaciones/1").to route_to("plantaciones#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/plantaciones/1/edit").to route_to("plantaciones#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/plantaciones").to route_to("plantaciones#create")
    end

    it "routes to #update" do
      expect(:put => "/plantaciones/1").to route_to("plantaciones#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/plantaciones/1").to route_to("plantaciones#destroy", :id => "1")
    end

  end
end
