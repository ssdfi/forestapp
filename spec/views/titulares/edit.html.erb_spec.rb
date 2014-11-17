require 'rails_helper'

RSpec.describe "titulares/edit", :type => :view do
  before(:each) do
    @titular = assign(:titular, Titular.create!())
  end

  it "renders the edit titular form" do
    render

    assert_select "form[action=?][method=?]", titular_path(@titular), "post" do
    end
  end
end
