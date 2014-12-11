require 'rails_helper'

RSpec.describe "generos/edit", :type => :view do
  before(:each) do
    @genero = assign(:genero, Genero.create!(
      :codigo => "MyString",
      :descripcion => "MyString"
    ))
  end

  it "renders the edit genero form" do
    render

    assert_select "form[action=?][method=?]", genero_path(@genero), "post" do

      assert_select "input#genero_codigo[name=?]", "genero[codigo]"

      assert_select "input#genero_descripcion[name=?]", "genero[descripcion]"
    end
  end
end
