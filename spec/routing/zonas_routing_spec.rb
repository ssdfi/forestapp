require "rails_helper"

RSpec.describe ZonasController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/zonas").to route_to("zonas#index")
    end

    it "routes to #new" do
      expect(:get => "/zonas/new").to route_to("zonas#new")
    end

    it "routes to #show" do
      expect(:get => "/zonas/1").to route_to("zonas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/zonas/1/edit").to route_to("zonas#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/zonas").to route_to("zonas#create")
    end

    it "routes to #update" do
      expect(:put => "/zonas/1").to route_to("zonas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/zonas/1").to route_to("zonas#destroy", :id => "1")
    end

  end
end
