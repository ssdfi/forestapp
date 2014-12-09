require 'rails_helper'

RSpec.describe "zonas/show", :type => :view do
  before(:each) do
    @zona = assign(:zona, Zona.create!(
      :codigo => "Codigo",
      :descripcion => "Descripcion",
      :srid => 1,
      :provincia => "Provincia",
      :codigo_indec => "Codigo Indec"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Codigo/)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Provincia/)
    expect(rendered).to match(/Codigo Indec/)
  end
end
