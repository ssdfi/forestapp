require 'rails_helper'

RSpec.describe "titulares/index", :type => :view do
  before(:each) do
    assign(:titulares, [
      Titular.create!(),
      Titular.create!()
    ])
  end

  it "renders a list of titulares" do
    render
  end
end
