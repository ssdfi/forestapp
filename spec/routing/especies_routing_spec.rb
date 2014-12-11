require "rails_helper"

RSpec.describe EspeciesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/especies").to route_to("especies#index")
    end

    it "routes to #new" do
      expect(:get => "/especies/new").to route_to("especies#new")
    end

    it "routes to #show" do
      expect(:get => "/especies/1").to route_to("especies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/especies/1/edit").to route_to("especies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/especies").to route_to("especies#create")
    end

    it "routes to #update" do
      expect(:put => "/especies/1").to route_to("especies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/especies/1").to route_to("especies#destroy", :id => "1")
    end

  end
end
