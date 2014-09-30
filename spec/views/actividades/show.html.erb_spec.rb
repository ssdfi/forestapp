require 'rails_helper'

RSpec.describe "actividades/show", :type => :view do
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

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
  end
end
