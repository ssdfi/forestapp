require 'rails_helper'

RSpec.describe "expedientes/edit", :type => :view do
  before(:each) do
    @expediente = assign(:expediente, Expediente.create!(
      :numero_interno => "MyString",
      :numero_expediente => "MyString",
      :titular => "MyString",
      :tecnico => "MyString",
      :plurianual => false,
      :agregado => false,
      :activo => false
    ))
  end

  it "renders the edit expediente form" do
    render

    assert_select "form[action=?][method=?]", expediente_path(@expediente), "post" do

      assert_select "input#expediente_numero_interno[name=?]", "expediente[numero_interno]"

      assert_select "input#expediente_numero_expediente[name=?]", "expediente[numero_expediente]"

      assert_select "input#expediente_titular[name=?]", "expediente[titular]"

      assert_select "input#expediente_tecnico[name=?]", "expediente[tecnico]"

      assert_select "input#expediente_plurianual[name=?]", "expediente[plurianual]"

      assert_select "input#expediente_agregado[name=?]", "expediente[agregado]"

      assert_select "input#expediente_activo[name=?]", "expediente[activo]"
    end
  end
end
