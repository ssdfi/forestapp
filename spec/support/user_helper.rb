require 'spec_helper'

module UserHelper
  def login_admin
    visit login_path
    fill_in 'username', with: 'maumiranda'
    fill_in 'password', with: 'Alta2015'
    click_on 'login'
  end
end

RSpec.configure do |config|
  config.include UserHelper, :type => :feature
end