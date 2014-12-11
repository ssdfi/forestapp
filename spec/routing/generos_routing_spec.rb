require "rails_helper"

RSpec.describe GenerosController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/generos").to route_to("generos#index")
    end

    it "routes to #new" do
      expect(:get => "/generos/new").to route_to("generos#new")
    end

    it "routes to #show" do
      expect(:get => "/generos/1").to route_to("generos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/generos/1/edit").to route_to("generos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/generos").to route_to("generos#create")
    end

    it "routes to #update" do
      expect(:put => "/generos/1").to route_to("generos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/generos/1").to route_to("generos#destroy", :id => "1")
    end

  end
end
