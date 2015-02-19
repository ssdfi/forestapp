require 'rails_helper'

feature "Actividades" do

  before :each do
    login_admin
  end

  scenario "Crear Nueva Actividad" do
    movimiento = Movimiento.last
    visit expediente_movimiento_path(movimiento.expediente, movimiento)
    click_on 'nav-new-actividad'
    within('#new_actividad') do
      select_random_option find('#actividad_tipo_actividad_id')
      fill_in 'actividad_superficie_presentada', with: random_area
      fill_in 'actividad_superficie_certificada', with: random_area
      fill_in 'actividad_superficie_inspeccionada', with: random_area
      click_on 'add-plantacion'
    end
    plantacion = Plantacion.last
    superficie = random_area
    within(:xpath, "//table[@id='plantaciones']/tbody/tr[1]") do
      find(:xpath, ".//input[contains(@id, 'plantacion_id')]").set plantacion.id
      find(:xpath, ".//input[contains(@id, 'fecha')]").set '01/01/2015'
      find(:xpath, ".//input[contains(@id, 'numero_plantas')]").set rand(100)
      find(:xpath, ".//input[contains(@id, 'superficie_registrada')]").set superficie
      select_random_option find(:xpath, ".//select[contains(@id, 'estado_aprobacion_id')]")
      find(:xpath, ".//textarea[contains(@id, 'observaciones')]").set 'Observaciones'
    end
    within('#new_actividad') do
      click_on 'save-actividad'
    end
    expect(current_path).to eq(expediente_movimiento_actividad_path(movimiento.expediente, movimiento, Actividad.last))
    visit expediente_movimiento_path(movimiento.expediente, movimiento)
    expect(page).to have_selector(:xpath, "//table[@id='actividades']/tbody/tr/td[.='#{superficie}']")
  end

  scenario "Mostrar Actividad" do
    actividad = Actividad.last
    visit expediente_movimiento_actividad_path(actividad.movimiento.expediente, actividad.movimiento, actividad)
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{actividad.movimiento.id}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{actividad.id}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{actividad.superficie_registrada}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{actividad.tipo_actividad.descripcion}']")
    expect(page).to have_selector('table#plantaciones')
  end

  scenario "Editar Actividad" do
    actividad = Actividad.last
    visit expediente_movimiento_actividad_path(actividad.movimiento.expediente, actividad.movimiento, actividad)
    click_on 'nav-edit-actividad'
    within("#edit_actividad_#{actividad.id}") do
      fill_in 'actividad_superficie_presentada', with: random_area
      fill_in 'actividad_superficie_certificada', with: random_area
      fill_in 'actividad_superficie_inspeccionada', with: random_area
    end
    find(:xpath, "//table[@id='plantaciones']/tbody/tr[1]/td[last()]/a").click
    plantaciones = Plantacion.last(5)
    click_on 'add-plantaciones'
    within('#plantaciones-modal') do
      fill_in 'plantaciones-ids', with: plantaciones.map{ |plantacion| plantacion.id }.join("\r\n")
      click_on 'plantaciones-modal-add'
    end
    total = 0
    all(:xpath, "//table[@id='plantaciones']/tbody/tr").each do |plantacion|
      superficie = random_area
      within(plantacion) do
        find(:xpath, ".//input[contains(@id, 'fecha')]").set '01/01/2015'
        find(:xpath, ".//input[contains(@id, 'numero_plantas')]").set rand(100)
        find(:xpath, ".//input[contains(@id, 'superficie_registrada')]").set superficie
        select_random_option find(:xpath, ".//select[contains(@id, 'estado_aprobacion_id')]")
        find(:xpath, ".//textarea[contains(@id, 'observaciones')]").set 'Observaciones'
      end
      total += superficie
    end
    total = total.round(1)
    within("#edit_actividad_#{actividad.id}") do
      click_on 'save-actividad'
    end
    expect(current_path).to eq(expediente_movimiento_actividad_path(actividad.movimiento.expediente, actividad.movimiento, actividad))
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{total}']")
  end

  scenario "Eliminar Actividad" do
    actividad = Actividad.last
    movimiento = actividad.movimiento
    visit expediente_movimiento_actividad_path(movimiento.expediente, movimiento, actividad)
    accept_alert do
      click_on 'nav-delete-actividad'
    end
    wait_for_ajax
    expect(current_path).to eq(expediente_movimiento_path(movimiento.expediente, movimiento))
  end

  scenario "Ver Mapa de Actividad" do
    actividad = ActividadPlantacion.last.actividad
    visit expediente_movimiento_actividad_path(actividad.movimiento.expediente, actividad.movimiento, actividad)
    all('.glyphicon-globe')[0].click
    page.driver.browser.switch_to.window page.driver.browser.window_handles.last do
      expect(page).to have_selector('div.leaflet-overlay-pane svg g')
      all('svg g')[0].click
      wait_for_ajax
      expect(page).to have_selector('.leaflet-popup-content')
    end
  end
end