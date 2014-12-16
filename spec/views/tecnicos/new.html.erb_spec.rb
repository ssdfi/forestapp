require 'rails_helper'

RSpec.describe "tecnicos/new", :type => :view do
  before(:each) do
    assign(:tecnico, Tecnico.new(
      :nombre => "MyString",
      :activo => false
    ))
  end

  it "renders new tecnico form" do
    render

    assert_select "form[action=?][method=?]", tecnicos_path, "post" do

      assert_select "input#tecnico_nombre[name=?]", "tecnico[nombre]"

      assert_select "input#tecnico_activo[name=?]", "tecnico[activo]"
    end
  end
end
