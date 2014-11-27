require 'rails_helper'

RSpec.describe "plantaciones/edit", :type => :view do
  before(:each) do
    @plantacion = assign(:plantacion, Plantacion.create!())
  end

  it "renders the edit plantacion form" do
    render

    assert_select "form[action=?][method=?]", plantacion_path(@plantacion), "post" do
    end
  end
end
