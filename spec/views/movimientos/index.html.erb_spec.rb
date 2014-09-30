require 'rails_helper'

RSpec.describe "movimientos/index", :type => :view do
  before(:each) do
    assign(:movimientos, [
      Movimiento.create!(
        :expediente => nil,
        :numero_ficha => 1,
        :inspector => nil,
        :reinspector => 2,
        :responsable => nil,
        :anio_inspeccion => "Anio Inspeccion",
        :destino => nil,
        :etapa => "Etapa",
        :observacion => "MyText",
        :observacion_interna => "MyText",
        :auditar => false,
        :validado => false
      ),
      Movimiento.create!(
        :expediente => nil,
        :numero_ficha => 1,
        :inspector => nil,
        :reinspector => 2,
        :responsable => nil,
        :anio_inspeccion => "Anio Inspeccion",
        :destino => nil,
        :etapa => "Etapa",
        :observacion => "MyText",
        :observacion_interna => "MyText",
        :auditar => false,
        :validado => false
      )
    ])
  end

  it "renders a list of movimientos" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Anio Inspeccion".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Etapa".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
