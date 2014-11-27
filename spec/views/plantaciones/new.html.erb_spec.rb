require 'rails_helper'

RSpec.describe "plantaciones/new", :type => :view do
  before(:each) do
    assign(:plantacion, Plantacion.new())
  end

  it "renders new plantacion form" do
    render

    assert_select "form[action=?][method=?]", plantaciones_path, "post" do
    end
  end
end
