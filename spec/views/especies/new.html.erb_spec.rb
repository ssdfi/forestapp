require 'rails_helper'

RSpec.describe "especies/new", :type => :view do
  before(:each) do
    assign(:especie, Especie.new(
      :genero_id => 1,
      :codigo_sp => "MyString",
      :codigo => "MyString",
      :nombre_cientifico => "MyString",
      :nombre_comun => "MyString",
      :inscripcion_inase => "MyString"
    ))
  end

  it "renders new especie form" do
    render

    assert_select "form[action=?][method=?]", especies_path, "post" do

      assert_select "input#especie_genero_id[name=?]", "especie[genero_id]"

      assert_select "input#especie_codigo_sp[name=?]", "especie[codigo_sp]"

      assert_select "input#especie_codigo[name=?]", "especie[codigo]"

      assert_select "input#especie_nombre_cientifico[name=?]", "especie[nombre_cientifico]"

      assert_select "input#especie_nombre_comun[name=?]", "especie[nombre_comun]"

      assert_select "input#especie_inscripcion_inase[name=?]", "especie[inscripcion_inase]"
    end
  end
end
