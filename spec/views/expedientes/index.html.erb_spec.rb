require 'rails_helper'

RSpec.describe "expedientes/index", :type => :view do
  before(:each) do
    assign(:expedientes, [
      Expediente.create!(
        :numero_interno => "Numero Interno",
        :numero_expediente => "Numero Expediente",
        :titular => "Titular",
        :tecnico => "Tecnico",
        :plurianual => false,
        :agregado => false,
        :activo => false
      ),
      Expediente.create!(
        :numero_interno => "Numero Interno",
        :numero_expediente => "Numero Expediente",
        :titular => "Titular",
        :tecnico => "Tecnico",
        :plurianual => false,
        :agregado => false,
        :activo => false
      )
    ])
  end

  it "renders a list of expedientes" do
    render
    assert_select "tr>td", :text => "Numero Interno".to_s, :count => 2
    assert_select "tr>td", :text => "Numero Expediente".to_s, :count => 2
    assert_select "tr>td", :text => "Titular".to_s, :count => 2
    assert_select "tr>td", :text => "Tecnico".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
