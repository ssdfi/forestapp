require "rails_helper"

RSpec.describe ActividadesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/actividades").to route_to("actividades#index")
    end

    it "routes to #new" do
      expect(:get => "/actividades/new").to route_to("actividades#new")
    end

    it "routes to #show" do
      expect(:get => "/actividades/1").to route_to("actividades#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/actividades/1/edit").to route_to("actividades#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/actividades").to route_to("actividades#create")
    end

    it "routes to #update" do
      expect(:put => "/actividades/1").to route_to("actividades#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/actividades/1").to route_to("actividades#destroy", :id => "1")
    end

  end
end
