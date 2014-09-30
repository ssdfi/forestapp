require 'rails_helper'

RSpec.describe "actividades/edit", :type => :view do
  before(:each) do
    @actividad = assign(:actividad, Actividad.create!(
      :movimiento => nil,
      :tipo_actividad => nil,
      :superficie_presentada => "9.99",
      :superficie_certificada => "9.99",
      :superficie_inspeccionada => "9.99",
      :superficie_registrada => "9.99"
    ))
  end

  it "renders the edit actividad form" do
    render

    assert_select "form[action=?][method=?]", actividad_path(@actividad), "post" do

      assert_select "input#actividad_movimiento_id[name=?]", "actividad[movimiento_id]"

      assert_select "input#actividad_tipo_actividad_id[name=?]", "actividad[tipo_actividad_id]"

      assert_select "input#actividad_superficie_presentada[name=?]", "actividad[superficie_presentada]"

      assert_select "input#actividad_superficie_certificada[name=?]", "actividad[superficie_certificada]"

      assert_select "input#actividad_superficie_inspeccionada[name=?]", "actividad[superficie_inspeccionada]"

      assert_select "input#actividad_superficie_registrada[name=?]", "actividad[superficie_registrada]"
    end
  end
end
