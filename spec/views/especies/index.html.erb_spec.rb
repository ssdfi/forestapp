require 'rails_helper'

RSpec.describe "especies/index", :type => :view do
  before(:each) do
    assign(:especies, [
      Especie.create!(
        :genero_id => 1,
        :codigo_sp => "Codigo Sp",
        :codigo => "Codigo",
        :nombre_cientifico => "Nombre Cientifico",
        :nombre_comun => "Nombre Comun",
        :inscripcion_inase => "Inscripcion Inase"
      ),
      Especie.create!(
        :genero_id => 1,
        :codigo_sp => "Codigo Sp",
        :codigo => "Codigo",
        :nombre_cientifico => "Nombre Cientifico",
        :nombre_comun => "Nombre Comun",
        :inscripcion_inase => "Inscripcion Inase"
      )
    ])
  end

  it "renders a list of especies" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Codigo Sp".to_s, :count => 2
    assert_select "tr>td", :text => "Codigo".to_s, :count => 2
    assert_select "tr>td", :text => "Nombre Cientifico".to_s, :count => 2
    assert_select "tr>td", :text => "Nombre Comun".to_s, :count => 2
    assert_select "tr>td", :text => "Inscripcion Inase".to_s, :count => 2
  end
end
