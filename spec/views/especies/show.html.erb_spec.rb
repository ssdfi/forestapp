require 'rails_helper'

RSpec.describe "especies/show", :type => :view do
  before(:each) do
    @especie = assign(:especie, Especie.create!(
      :genero_id => 1,
      :codigo_sp => "Codigo Sp",
      :codigo => "Codigo",
      :nombre_cientifico => "Nombre Cientifico",
      :nombre_comun => "Nombre Comun",
      :inscripcion_inase => "Inscripcion Inase"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Codigo Sp/)
    expect(rendered).to match(/Codigo/)
    expect(rendered).to match(/Nombre Cientifico/)
    expect(rendered).to match(/Nombre Comun/)
    expect(rendered).to match(/Inscripcion Inase/)
  end
end
