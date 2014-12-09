require 'rails_helper'

RSpec.describe "zonas/index", :type => :view do
  before(:each) do
    assign(:zonas, [
      Zona.create!(
        :codigo => "Codigo",
        :descripcion => "Descripcion",
        :srid => 1,
        :provincia => "Provincia",
        :codigo_indec => "Codigo Indec"
      ),
      Zona.create!(
        :codigo => "Codigo",
        :descripcion => "Descripcion",
        :srid => 1,
        :provincia => "Provincia",
        :codigo_indec => "Codigo Indec"
      )
    ])
  end

  it "renders a list of zonas" do
    render
    assert_select "tr>td", :text => "Codigo".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Provincia".to_s, :count => 2
    assert_select "tr>td", :text => "Codigo Indec".to_s, :count => 2
  end
end
