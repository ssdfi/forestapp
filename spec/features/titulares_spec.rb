require 'rails_helper'

feature "Titulares" do

  before :each do
    login_admin
  end

  scenario "Crear Nuevo Titular" do
    visit titulares_path
    click_on 'nav-new-titular'
    within('#new_titular') do
      fill_in 'titular_nombre', with: 'Pepe Hongo'
      fill_in 'titular_dni', with: '22222222'
      fill_in 'titular_cuit', with: '20-22222222-3'
      click_on 'save-titular'
    end
    expect(current_path).to eq(titular_path(Titular.last))
  end

  scenario "Listar Titulares sin filtro" do
    visit titulares_path
    expect(page).to have_selector('#titulares tbody tr')
  end

  scenario "Buscar Titulares por nombre" do
    visit titulares_path
    within("#new_titular") do
      fill_in 'titular_nombre', with: 'Pepe Hongo'
      click_on 'search'
    end
    expect(page).to have_selector('#titulares tbody tr')
  end

  scenario "Buscar Titulares por dni" do
    visit titulares_path
    within("#new_titular") do
      fill_in 'titular_dni', with: '22222222'
      click_on 'search'
    end
    expect(page).to have_selector('#titulares tbody tr')
  end

  scenario "Buscar Titulares por cuit" do
    visit titulares_path
    within("#new_titular") do
      fill_in 'titular_cuit', with: '20-22222222-3'
      click_on 'search'
    end
    expect(page).to have_selector('#titulares tbody tr')
  end

  scenario "Mostrar Titular" do
    titular = Titular.last
    visit titular_path(titular)
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{titular.nombre}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{titular.dni}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{titular.cuit}']")
    expect(page).to have_selector('table#expedientes')
  end

  scenario "Editar Titular" do
    titular = Titular.last
    visit titular_path(titular)
    click_on 'nav-edit-titular'
    within("#edit_titular_#{titular.id}") do
      fill_in 'titular_dni', with: '33333333'
      click_on 'save-titular'
    end
    expect(current_path).to eq(titular_path(titular))
  end

  scenario "Eliminar Titular" do
    titular = Titular.last
    visit titular_path(titular)
    accept_alert do
      click_on 'nav-delete-titular'
    end
    wait_for_ajax
    expect(current_path).to eq(titulares_path)
  end
end