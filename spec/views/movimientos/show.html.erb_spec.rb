require 'rails_helper'

RSpec.describe "movimientos/show", :type => :view do
  before(:each) do
    @movimiento = assign(:movimiento, Movimiento.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Anio Inspeccion/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Etapa/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
