require "rails_helper"

RSpec.describe DepartamentosController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/departamentos").to route_to("departamentos#index")
    end

    it "routes to #new" do
      expect(:get => "/departamentos/new").to route_to("departamentos#new")
    end

    it "routes to #show" do
      expect(:get => "/departamentos/1").to route_to("departamentos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/departamentos/1/edit").to route_to("departamentos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/departamentos").to route_to("departamentos#create")
    end

    it "routes to #update" do
      expect(:put => "/departamentos/1").to route_to("departamentos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/departamentos/1").to route_to("departamentos#destroy", :id => "1")
    end

  end
end
