require 'rails_helper'

feature "Expedientes" do

  before :each do
    login_admin
  end

  scenario "Crear Nuevo Expediente" do
    tecnico = Tecnico.first.nombre
    titulares = Titular.order(:nombre).first(3)
    visit expedientes_path
    click_on 'nav_new_expediente'
    within('#new_expediente') do
      fill_in 'expediente_numero_interno', with: '01-001-000/00'
      fill_in 'expediente_numero_expediente', with: 'Exp-S00:0000000/0000'
      select tecnico, from: 'expediente_tecnico_id'
      page.execute_script("$('.bootstrap-switch-container input').bootstrapSwitch('toggleState')")
      click_on 'add_titular'
    end
    within('#modal_titulares') do
      click_on 'modal_titulares_search'
      page.has_selector?('#titulares_list li')
      titulares.each do |titular|
        check "titular_#{titular.id}"
      end
      click_on 'modal_titulares_add'
    end
    page.has_selector?('#expediente_titular_ids option')
    within('#new_expediente') do
      expect(page).to have_select('expediente_titular_ids', options: titulares.map { |t| t.nombre })
      click_on 'save_expediente'
    end
    expect(current_path).to eq(expediente_path(Expediente.last))
  end

  scenario "Listar Expedientes sin filtro" do
    visit expedientes_path
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por numero_interno" do
    expediente = Expediente.last
    visit expedientes_path
    within("#new_expediente") do
      fill_in 'expediente_numero_interno', with: '/'
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por numero_expediente" do
    expediente = Expediente.last
    visit expedientes_path
    within("#new_expediente") do
      fill_in 'expediente_numero_expediente', with: 'Exp'
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por zona" do
    expediente = Expediente.last
    visit expedientes_path
    within("#new_expediente") do
      select expediente.zona.descripcion, from: 'expediente_zona_id'
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por anio/etapa" do
    expediente = Expediente.last
    visit expedientes_path
    within("#new_expediente") do
      fill_in 'expediente_etapa', with: expediente.anio
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por fecha" do
    visit expedientes_path
    within("#new_expediente") do
      fill_in 'expediente_fecha_desde', with: '01/01/2012'
      fill_in 'expediente_fecha_hasta', with: '01/01/2013'
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por responsable" do
    responsable = Responsable.joins(:movimientos).group("responsables.id").having("count(responsables.id) > ?", 1).first.nombre
    visit expedientes_path
    within("#new_expediente") do
      select responsable, from: 'expediente_responsable_id'
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por técnico" do
    expediente = Expediente.last
    visit expedientes_path
    within("#new_expediente") do
      select expediente.tecnico.nombre, from: 'expediente_tecnico_id'
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por activo" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_activo_true')
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por plurianual" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_plurianual_true')
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por agrupado" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_agrupado_true')
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por pendiente" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_pendiente_true')
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por validado" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_validado_false')
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por estabilidad_fiscal" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_estabilidad_fiscal_true')
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Buscar Expedientes por incompleto" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_incompleto_')
      click_on 'search'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Exportar Expedientes como CSV", :js => true do
    tecnico = Tecnico.joins(:expedientes).first.nombre
    visit expedientes_path + '.csv?expediente[etapa]=2014'
    expect(page.response_headers['Content-Type']).to eq('text/csv')
    expect(page.response_headers['Content-Disposition']).to match(/attachment; filename=\"expedientes.csv\"/)
  end

  scenario "Buscar Expedientes con un sólo resultado" do
    expediente = Expediente.last
    puts expediente.numero_interno
    visit expedientes_path
    within("#new_expediente") do
      fill_in 'expediente_numero_interno', with: expediente.numero_interno
      choose('expediente_incompleto_')
      click_on 'search'
    end
    expect(current_path).to eq(expediente_path(expediente))
  end

  scenario "Mostrar Expediente" do
    expediente = Expediente.last
    visit expediente_path(expediente)
    expect(find('#nav_expediente')).to have_content(expediente.numero_interno)
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{expediente.id}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{expediente.zona.descripcion}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{expediente.departamento.descripcion}']")
    expect(page).to have_selector(:xpath, "//div[@class='panel-body']/dl/dd[.='#{expediente.anio}']")
    expect(page).to have_selector('table#movimientos')
  end

  scenario "Editar Expediente" do
    expediente = Expediente.last
    visit expediente_path(expediente)
    titulares = expediente.titulares.pluck(:nombre)
    click_on 'nav_edit_expediente'
    within("#edit_expediente_#{expediente.id}") do
      fill_in 'expediente_numero_interno', with: '11-111-111/11'
      expect(page).to have_select('expediente_titular_ids', options: titulares)
      select(titulares[0], from: 'expediente_titular_ids')
      click_on 'remove_titular'
      expect(page).not_to have_select('expediente_titular_ids', options: titulares)
      click_on 'save_expediente'
    end
    expect(current_path).to eq(expediente_path(expediente))
  end

  scenario "Eliminar Expediente" do
    expediente = Expediente.last
    visit expediente_path(expediente)
    accept_alert do
      click_on 'nav_delete_expediente'
    end
    expect(current_path).to eq(expedientes_path)
  end
end