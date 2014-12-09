require 'rails_helper'

RSpec.describe "departamentos/edit", :type => :view do
  before(:each) do
    @departamento = assign(:departamento, Departamento.create!(
      :zona_id => 1,
      :codigo => "MyString",
      :descripcion => "MyString",
      :codigo_indec => "MyString"
    ))
  end

  it "renders the edit departamento form" do
    render

    assert_select "form[action=?][method=?]", departamento_path(@departamento), "post" do

      assert_select "input#departamento_zona_id[name=?]", "departamento[zona_id]"

      assert_select "input#departamento_codigo[name=?]", "departamento[codigo]"

      assert_select "input#departamento_descripcion[name=?]", "departamento[descripcion]"

      assert_select "input#departamento_codigo_indec[name=?]", "departamento[codigo_indec]"
    end
  end
end
