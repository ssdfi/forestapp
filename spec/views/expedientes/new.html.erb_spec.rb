require 'rails_helper'

RSpec.describe "expedientes/new", :type => :view do
  before(:each) do
    assign(:expediente, Expediente.new(
      :numero_interno => "MyString",
      :numero_expediente => "MyString",
      :titular => "MyString",
      :tecnico => "MyString",
      :plurianual => false,
      :agregado => false,
      :activo => false
    ))
  end

  it "renders new expediente form" do
    render

    assert_select "form[action=?][method=?]", expedientes_path, "post" do

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
