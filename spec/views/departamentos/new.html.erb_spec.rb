require 'rails_helper'

RSpec.describe "departamentos/new", :type => :view do
  before(:each) do
    assign(:departamento, Departamento.new(
      :zona_id => 1,
      :codigo => "MyString",
      :descripcion => "MyString",
      :codigo_indec => "MyString"
    ))
  end

  it "renders new departamento form" do
    render

    assert_select "form[action=?][method=?]", departamentos_path, "post" do

      assert_select "input#departamento_zona_id[name=?]", "departamento[zona_id]"

      assert_select "input#departamento_codigo[name=?]", "departamento[codigo]"

      assert_select "input#departamento_descripcion[name=?]", "departamento[descripcion]"

      assert_select "input#departamento_codigo_indec[name=?]", "departamento[codigo_indec]"
    end
  end
end
