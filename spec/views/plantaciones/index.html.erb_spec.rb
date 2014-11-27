require 'rails_helper'

RSpec.describe "plantaciones/index", :type => :view do
  before(:each) do
    assign(:plantaciones, [
      Plantacion.create!(),
      Plantacion.create!()
    ])
  end

  it "renders a list of plantaciones" do
    render
  end
end
