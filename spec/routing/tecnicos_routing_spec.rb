require "rails_helper"

RSpec.describe TecnicosController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/tecnicos").to route_to("tecnicos#index")
    end

    it "routes to #new" do
      expect(:get => "/tecnicos/new").to route_to("tecnicos#new")
    end

    it "routes to #show" do
      expect(:get => "/tecnicos/1").to route_to("tecnicos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/tecnicos/1/edit").to route_to("tecnicos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/tecnicos").to route_to("tecnicos#create")
    end

    it "routes to #update" do
      expect(:put => "/tecnicos/1").to route_to("tecnicos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tecnicos/1").to route_to("tecnicos#destroy", :id => "1")
    end

  end
end
