require 'rails_helper'

RSpec.describe "titulares/show", :type => :view do
  before(:each) do
    @titular = assign(:titular, Titular.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
