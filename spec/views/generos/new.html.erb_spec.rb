require 'rails_helper'

RSpec.describe "generos/new", :type => :view do
  before(:each) do
    assign(:genero, Genero.new(
      :codigo => "MyString",
      :descripcion => "MyString"
    ))
  end

  it "renders new genero form" do
    render

    assert_select "form[action=?][method=?]", generos_path, "post" do

      assert_select "input#genero_codigo[name=?]", "genero[codigo]"

      assert_select "input#genero_descripcion[name=?]", "genero[descripcion]"
    end
  end
end
