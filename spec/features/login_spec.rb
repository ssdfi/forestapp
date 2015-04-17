require 'rails_helper'

feature "Login" do

  scenario "Iniciar Sesión" do
    login_admin
    expect(current_path).to eq(root_path)
  end

  scenario "Cerrar Sesión" do
    login_admin
    accept_alert do
      click_on 'nav-logout'
    end
    wait_for_ajax
    expect(current_path).to eq(login_path)
  end
end