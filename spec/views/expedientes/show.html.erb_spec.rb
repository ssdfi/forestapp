require 'rails_helper'

RSpec.describe "expedientes/show", :type => :view do
  before(:each) do
    @expediente = assign(:expediente, Expediente.create!(
      :numero_interno => "Numero Interno",
      :numero_expediente => "Numero Expediente",
      :titular => "Titular",
      :tecnico => "Tecnico",
      :plurianual => false,
      :agregado => false,
      :activo => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Numero Interno/)
    expect(rendered).to match(/Numero Expediente/)
    expect(rendered).to match(/Titular/)
    expect(rendered).to match(/Tecnico/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
