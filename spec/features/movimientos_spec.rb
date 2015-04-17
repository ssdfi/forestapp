require 'rails_helper'

feature "Movimientos" do

  before :each do
    login_admin
  end

  scenario "Crear Nuevo Movimiento" do
    expediente = Expediente.last
    visit expediente_path(expediente)
    click_on 'nav-new-movimiento'
    within('#new_movimiento') do
      fill_in 'movimiento_numero_ficha', with: '10000000'
      select_random_option find('#movimiento_inspector_id')
      select_random_option find('#movimiento_reinspector_id')
      select_random_option find('#movimiento_responsable_id')
      fill_in 'movimiento_anio_inspeccion', with: '2015'
      select_random_option find('#movimiento_destino_id')
      fill_in 'movimiento_fecha_entrada', with: '01/01/2014'
      fill_in 'movimiento_fecha_salida', with: '01/01/2015'
      fill_in 'movimiento_etapa', with: '2015'
      toggle_all_switches
      fill_in 'movimiento_observacion', with: 'Observación'
      fill_in 'movimiento_observacion_interna', with: 'Observación Interna'
      click_on 'save-movimiento'
    end
    expect(current_path).to eq(expediente_movimiento_path(expediente, Movimiento.last))
  end

  scenario "Mostrar Movimiento" do
    movimiento = Movimiento.last
    visit expediente_movimiento_path(movimiento.expediente, movimiento)
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{movimiento.expediente.id}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{movimiento.id}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{I18n.l movimiento.fecha_entrada}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{movimiento.inspector.descripcion}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{movimiento.observacion}']")
    expect(find('.panel-footer .label-danger').text).to eq('Sin validar')
    expect(page).to have_selector('table#actividades')
  end

  scenario "Editar Movimiento" do
    movimiento = Movimiento.last
    visit expediente_movimiento_path(movimiento.expediente, movimiento)
    click_on 'nav-edit-movimiento'
    within("#edit_movimiento_#{movimiento.id}") do
      fill_in 'movimiento_numero_ficha', with: '11111111'
      select_random_option find('#movimiento_validador_id')
      click_on 'save-movimiento'
    end
    expect(current_path).to eq(expediente_movimiento_path(movimiento.expediente, movimiento))
    expect(find('.panel-footer .label-success').text).to eq('Validado')
  end

  scenario "Eliminar Movimiento" do
    movimiento = Movimiento.last
    expediente = movimiento.expediente
    visit expediente_movimiento_path(expediente, movimiento)
    accept_alert do
      click_on 'nav-delete-movimiento'
    end
    wait_for_ajax
    expect(current_path).to eq(expediente_path(expediente))
  end

  scenario "Generar Reporte" do
    movimiento = Movimiento.last
    visit expediente_movimiento_path(movimiento.expediente, movimiento)
    click_on 'nav-report-movimiento'
    page.driver.browser.switch_to.window page.driver.browser.window_handles.last do
      expect(current_path).to eq(expediente_movimiento_report_path(movimiento.expediente, movimiento))
      expect(page).to have_selector(:xpath, "//p[contains(., '#{movimiento.expediente.numero_interno}')]")
    end
  end
end