require 'rails_helper'

RSpec.describe "departamentos/index", :type => :view do
  before(:each) do
    assign(:departamentos, [
      Departamento.create!(
        :zona_id => 1,
        :codigo => "Codigo",
        :descripcion => "Descripcion",
        :codigo_indec => "Codigo Indec"
      ),
      Departamento.create!(
        :zona_id => 1,
        :codigo => "Codigo",
        :descripcion => "Descripcion",
        :codigo_indec => "Codigo Indec"
      )
    ])
  end

  it "renders a list of departamentos" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Codigo".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => "Codigo Indec".to_s, :count => 2
  end
end
