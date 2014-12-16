require 'rails_helper'

RSpec.describe "tecnicos/edit", :type => :view do
  before(:each) do
    @tecnico = assign(:tecnico, Tecnico.create!(
      :nombre => "MyString",
      :activo => false
    ))
  end

  it "renders the edit tecnico form" do
    render

    assert_select "form[action=?][method=?]", tecnico_path(@tecnico), "post" do

      assert_select "input#tecnico_nombre[name=?]", "tecnico[nombre]"

      assert_select "input#tecnico_activo[name=?]", "tecnico[activo]"
    end
  end
end
