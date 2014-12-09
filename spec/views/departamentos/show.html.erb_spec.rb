require 'rails_helper'

RSpec.describe "departamentos/show", :type => :view do
  before(:each) do
    @departamento = assign(:departamento, Departamento.create!(
      :zona_id => 1,
      :codigo => "Codigo",
      :descripcion => "Descripcion",
      :codigo_indec => "Codigo Indec"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Codigo/)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/Codigo Indec/)
  end
end
