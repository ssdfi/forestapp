require 'rails_helper'

RSpec.describe "titulares/new", :type => :view do
  before(:each) do
    assign(:titular, Titular.new())
  end

  it "renders new titular form" do
    render

    assert_select "form[action=?][method=?]", titulares_path, "post" do
    end
  end
end
