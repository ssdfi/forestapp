require 'rails_helper'

RSpec.describe "plantaciones/show", :type => :view do
  before(:each) do
    @plantacion = assign(:plantacion, Plantacion.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
