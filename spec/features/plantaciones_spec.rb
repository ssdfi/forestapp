require 'rails_helper'

feature "Plantaciones" do

  before :each do
    login_admin
  end

  scenario "Crear Nueva Plantacion" do
    titular = Titular.order(:nombre).first
    especies = Especie.order(:codigo_sp).first(3)
    visit plantaciones_path
    click_on 'nav-new-plantacion'
    within('#new_plantacion') do
      click_on 'add-titular'
    end
    within('#titulares-modal') do
      click_on 'titulares-modal-search'
      page.has_selector?('#titulares-list li')
      choose "titular-#{titular.id}"
      click_on 'titulares-modal-select'
    end
    within('#new_plantacion') do
      click_on 'add-especie'
    end
    within('#especies-modal') do
      click_on 'especies-modal-search'
      page.has_selector?('#especies-list li')
      especies.each do |especie|
        check "especie-#{especie.id}"
      end
      click_on 'especies-modal-add'
    end
    within('#new_plantacion') do
      fill_in 'plantacion_anio_plantacion', with: '2010'
      select_random_option find('#plantacion_tipo_plantacion_id')
      fill_in 'plantacion_nomenclatura_catastral', with: '100000000000001-01'
      select_random_option find('#plantacion_estado_plantacion_id')
      fill_in 'plantacion_distancia_plantas', with: '8'
      fill_in 'plantacion_cantidad_filas', with: '8'
      fill_in 'plantacion_distancia_filas', with: '8'
      fill_in 'plantacion_densidad', with: '8'
      select_random_option find('#plantacion_fuente_informacion_id')
      fill_in 'plantacion_fecha_informacion', with: '2010'
      select_random_option find('#plantacion_fuente_imagen_id')
      fill_in 'plantacion_fecha_imagen', with: '2010'
      select_random_option find('#plantacion_zona_id')
      page.has_selector?('#plantacion_departamento_id option')
      select_random_option find('#plantacion_departamento_id')
      select_random_option find('#plantacion_estrato_desarrollo_id')
      select_random_option find('#plantacion_uso_forestal_id')
      select_random_option find('#plantacion_uso_anterior_id')
      select_random_option find('#plantacion_objetivo_plantacion_id')
      toggle_switch('plantacion_activo')
      click_on 'save-plantacion'
    end
    expect(current_path).to eq(plantacion_path(Plantacion.last))
  end

  scenario "Listar Plantaciones" do
    visit plantaciones_path
    expect(page).to have_selector('#plantaciones tbody tr')
  end

  scenario "Mostrar Plantación" do
    plantacion = Plantacion.joins(:expedientes).last
    visit plantacion_path(plantacion)
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{plantacion.id}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{plantacion.zona.descripcion}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{plantacion.tipo_plantacion.descripcion}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd/ul/li[.='#{plantacion.especies.last.nombre_cientifico}']")
    expect(page).to have_selector('table#expedientes')
  end

  scenario "Editar Plantación" do
    plantacion = Plantacion.last
    visit plantacion_path(plantacion)
    especies = plantacion.especies.pluck(:nombre_cientifico)
    click_on 'nav-edit-plantacion'
    within("#edit_plantacion_#{plantacion.id}") do
      fill_in 'plantacion_anio_plantacion', with: '2015'
      expect(page).to have_select('plantacion_especie_ids', options: especies)
      select(especies[0], from: 'plantacion_especie_ids')
      click_on 'remove-especie'
      expect(page).not_to have_select('plantacion_especie_ids', options: especies)
      click_on 'save-plantacion'
    end
    expect(current_path).to eq(plantacion_path(plantacion))
  end

  scenario "Eliminar Plantación" do
    plantacion = Plantacion.last
    visit plantacion_path(plantacion)
    accept_alert do
      click_on 'nav-delete-plantacion'
    end
    wait_for_ajax
    expect(current_path).to eq(plantaciones_path)
  end

  scenario "Ver Mapa de Plantación" do
    plantacion = Plantacion.where.not(geom: nil).where(tipo_plantacion_id: 1).first
    visit plantacion_path(plantacion)
    click_on 'nav-map-plantacion'
    page.driver.browser.switch_to.window page.driver.browser.window_handles.last do
      expect(page).to have_selector('div.leaflet-overlay-pane svg g')
      all('svg g')[0].click
      wait_for_ajax
      expect(page).to have_selector(:xpath, "//div[@class='leaflet-popup-content']/div/div[contains(., '#{plantacion.id}')]")
    end
  end

  scenario "Reemplazar Plantación" do
    plantacion_nueva = Plantacion.last
    plantacion_anterior = Plantacion.first
    visit plantacion_path(plantacion_anterior)
    click_on 'nav-replace-plantacion'
    within('#plantaciones-modal') do
      fill_in 'plantaciones_nuevas_ids', with: plantacion_nueva.id
      click_on 'plantaciones-modal-replace'
    end
    expect(page).to have_selector(:xpath, "//table[@id='plantaciones_nuevas']/tbody/tr/td[contains(., '#{plantacion_nueva.id}')]")
    visit plantacion_path(plantacion_nueva)
    expect(page).to have_selector(:xpath, "//table[@id='plantaciones_anteriores']/tbody/tr/td[contains(., '#{plantacion_anterior.id}')]")
  end
end