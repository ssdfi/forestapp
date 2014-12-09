require 'rails_helper'

RSpec.describe "zonas/edit", :type => :view do
  before(:each) do
    @zona = assign(:zona, Zona.create!(
      :codigo => "MyString",
      :descripcion => "MyString",
      :srid => 1,
      :provincia => "MyString",
      :codigo_indec => "MyString"
    ))
  end

  it "renders the edit zona form" do
    render

    assert_select "form[action=?][method=?]", zona_path(@zona), "post" do

      assert_select "input#zona_codigo[name=?]", "zona[codigo]"

      assert_select "input#zona_descripcion[name=?]", "zona[descripcion]"

      assert_select "input#zona_srid[name=?]", "zona[srid]"

      assert_select "input#zona_provincia[name=?]", "zona[provincia]"

      assert_select "input#zona_codigo_indec[name=?]", "zona[codigo_indec]"
    end
  end
end
