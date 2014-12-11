require 'rails_helper'

RSpec.describe "generos/index", :type => :view do
  before(:each) do
    assign(:generos, [
      Genero.create!(
        :codigo => "Codigo",
        :descripcion => "Descripcion"
      ),
      Genero.create!(
        :codigo => "Codigo",
        :descripcion => "Descripcion"
      )
    ])
  end

  it "renders a list of generos" do
    render
    assert_select "tr>td", :text => "Codigo".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
  end
end
