require 'rails_helper'

RSpec.describe "actividades/index", :type => :view do
  before(:each) do
    assign(:actividades, [
      Actividad.create!(
        :movimiento => nil,
        :tipo_actividad => nil,
        :superficie_presentada => "9.99",
        :superficie_certificada => "9.99",
        :superficie_inspeccionada => "9.99",
        :superficie_registrada => "9.99"
      ),
      Actividad.create!(
        :movimiento => nil,
        :tipo_actividad => nil,
        :superficie_presentada => "9.99",
        :superficie_certificada => "9.99",
        :superficie_inspeccionada => "9.99",
        :superficie_registrada => "9.99"
      )
    ])
  end

  it "renders a list of actividades" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
