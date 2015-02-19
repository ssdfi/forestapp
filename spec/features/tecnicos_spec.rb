require 'rails_helper'

feature "Técnicos" do

  before :each do
    login_admin
  end

  scenario "Crear Nuevo Técnico" do
    visit tecnicos_path
    click_on 'nav-new-tecnico'
    within('#new_tecnico') do
      fill_in 'tecnico_nombre', with: 'Pepe Hongo'
      toggle_switch '#tecnico_activo'
      click_on 'save-tecnico'
    end
    expect(current_path).to eq(tecnico_path(Tecnico.last))
  end

  scenario "Listar Técnicos sin filtro" do
    visit tecnicos_path
    expect(page).to have_selector('#tecnicos tbody tr')
  end

  scenario "Buscar Técnicos por nombre" do
    visit tecnicos_path
    within("#new_tecnico") do
      fill_in 'tecnico_nombre', with: 'Pepe Hongo'
      choose('tecnico_activo_')
      click_on 'search'
    end
    expect(page).to have_selector('#tecnicos tbody tr')
  end

  scenario "Buscar Titulares por activo" do
    visit tecnicos_path
    within("#new_tecnico") do
      choose('tecnico_activo_false')
      click_on 'search'
    end
    expect(page).to have_selector('#tecnicos tbody tr')
  end

  scenario "Mostrar Técnico" do
    tecnico = Tecnico.last
    visit tecnico_path(tecnico)
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{tecnico.nombre}']")
    expect(page).to have_selector('table#expedientes')
  end

  scenario "Editar Técnico" do
    tecnico = Tecnico.last
    visit tecnico_path(tecnico)
    click_on 'nav-edit-tecnico'
    within("#edit_tecnico_#{tecnico.id}") do
      toggle_switch '#tecnico_activo'
      click_on 'save-tecnico'
    end
    expect(current_path).to eq(tecnico_path(tecnico))
  end

  scenario "Eliminar Técnico" do
    tecnico = Tecnico.last
    visit tecnico_path(tecnico)
    accept_alert do
      click_on 'nav-delete-tecnico'
    end
    wait_for_ajax
    expect(current_path).to eq(tecnicos_path)
  end
end