require 'rails_helper'

RSpec.describe "tecnicos/index", :type => :view do
  before(:each) do
    assign(:tecnicos, [
      Tecnico.create!(
        :nombre => "Nombre",
        :activo => false
      ),
      Tecnico.create!(
        :nombre => "Nombre",
        :activo => false
      )
    ])
  end

  it "renders a list of tecnicos" do
    render
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
