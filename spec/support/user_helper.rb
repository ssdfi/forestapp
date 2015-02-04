module UserHelper
  def login_admin
    visit login_path
    fill_in 'username', with: RSpec.configuration.admin_user
    fill_in 'password', with: RSpec.configuration.admin_password
    click_on 'login'
  end

  def login_editor
    visit login_path
    fill_in 'username', with: RSpec.configuration.editor_user
    fill_in 'password', with: RSpec.configuration.editor_password
    click_on 'login'
  end

  def login_public
    visit login_path
    fill_in 'username', with: RSpec.configuration.public_user
    fill_in 'password', with: RSpec.configuration.public_password
    click_on 'login'
  end
end

RSpec.configure do |config|
  config.include UserHelper, type: :feature
end