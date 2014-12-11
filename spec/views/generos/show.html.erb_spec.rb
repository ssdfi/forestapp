require 'rails_helper'

RSpec.describe "generos/show", :type => :view do
  before(:each) do
    @genero = assign(:genero, Genero.create!(
      :codigo => "Codigo",
      :descripcion => "Descripcion"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Codigo/)
    expect(rendered).to match(/Descripcion/)
  end
end
