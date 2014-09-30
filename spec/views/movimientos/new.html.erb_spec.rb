require 'rails_helper'

RSpec.describe "movimientos/new", :type => :view do
  before(:each) do
    assign(:movimiento, Movimiento.new(
      :expediente => nil,
      :numero_ficha => 1,
      :inspector => nil,
      :reinspector => 1,
      :responsable => nil,
      :anio_inspeccion => "MyString",
      :destino => nil,
      :etapa => "MyString",
      :observacion => "MyText",
      :observacion_interna => "MyText",
      :auditar => false,
      :validado => false
    ))
  end

  it "renders new movimiento form" do
    render

    assert_select "form[action=?][method=?]", movimientos_path, "post" do

      assert_select "input#movimiento_expediente_id[name=?]", "movimiento[expediente_id]"

      assert_select "input#movimiento_numero_ficha[name=?]", "movimiento[numero_ficha]"

      assert_select "input#movimiento_inspector_id[name=?]", "movimiento[inspector_id]"

      assert_select "input#movimiento_reinspector[name=?]", "movimiento[reinspector]"

      assert_select "input#movimiento_responsable_id[name=?]", "movimiento[responsable_id]"

      assert_select "input#movimiento_anio_inspeccion[name=?]", "movimiento[anio_inspeccion]"

      assert_select "input#movimiento_destino_id[name=?]", "movimiento[destino_id]"

      assert_select "input#movimiento_etapa[name=?]", "movimiento[etapa]"

      assert_select "textarea#movimiento_observacion[name=?]", "movimiento[observacion]"

      assert_select "textarea#movimiento_observacion_interna[name=?]", "movimiento[observacion_interna]"

      assert_select "input#movimiento_auditar[name=?]", "movimiento[auditar]"

      assert_select "input#movimiento_validado[name=?]", "movimiento[validado]"
    end
  end
end
