require 'rails_helper'

RSpec.describe "tecnicos/show", :type => :view do
  before(:each) do
    @tecnico = assign(:tecnico, Tecnico.create!(
      :nombre => "Nombre",
      :activo => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/false/)
  end
end
