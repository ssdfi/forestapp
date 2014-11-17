require "rails_helper"

RSpec.describe TitularesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/titulares").to route_to("titulares#index")
    end

    it "routes to #new" do
      expect(:get => "/titulares/new").to route_to("titulares#new")
    end

    it "routes to #show" do
      expect(:get => "/titulares/1").to route_to("titulares#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/titulares/1/edit").to route_to("titulares#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/titulares").to route_to("titulares#create")
    end

    it "routes to #update" do
      expect(:put => "/titulares/1").to route_to("titulares#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/titulares/1").to route_to("titulares#destroy", :id => "1")
    end

  end
end
