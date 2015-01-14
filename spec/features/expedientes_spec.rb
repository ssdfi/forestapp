require 'rails_helper'

feature "Expedientes" do

  scenario "Listing Expedientes without filter" do
    visit expedientes_path
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by numero_interno" do
    visit expedientes_path
    within("#new_expediente") do
      fill_in 'expediente_numero_interno', :with => '/'
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by numero_expediente" do
    visit expedientes_path
    within("#new_expediente") do
      fill_in 'expediente_numero_expediente', :with => 'Exp'
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by zona" do
    zona = Zona.joins(:expedientes).group("zonas.id").having("count(zonas.id) > ?", 1).first.descripcion
    visit expedientes_path
    within("#new_expediente") do
      select zona, :from => 'expediente_zona_id'
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by anio/etapa" do
    visit expedientes_path
    within("#new_expediente") do
      fill_in 'expediente_etapa', :with => '2012'
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by fecha" do
    visit expedientes_path
    within("#new_expediente") do
      fill_in 'expediente_fecha_desde', :with => '01/01/2012'
      fill_in 'expediente_fecha_hasta', :with => '01/01/2013'
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by responsable" do
    responsable = Responsable.joins(:movimientos).group("responsables.id").having("count(responsables.id) > ?", 1).first.nombre
    visit expedientes_path
    within("#new_expediente") do
      select responsable, :from => 'expediente_responsable_id'
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by titular" do
    tecnico = Tecnico.joins(:expedientes).group("tecnicos.id").having("count(tecnicos.id) > ?", 1).first.nombre
    visit expedientes_path
    within("#new_expediente") do
      select tecnico, :from => 'expediente_tecnico_id'
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by activo" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_activo_true')
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by plurianual" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_plurianual_true')
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by agrupado" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_agrupado_true')
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by pendiente" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_pendiente_true')
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by validado" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_validado_false')
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by estabilidad_fiscal" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_estabilidad_fiscal_true')
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Search Expedientes by incompleto" do
    visit expedientes_path
    within("#new_expediente") do
      choose('expediente_incompleto_false')
      click_on 'buscar'
    end
    expect(page).to have_selector('#expedientes tbody tr')
  end

  scenario "Export Expedientes as CSV" do
    tecnico = Tecnico.joins(:expedientes).first.nombre
    visit expedientes_path + '.csv?expediente[etapa]=2014'
    expect(page.response_headers['Content-Type']).to eq('text/csv')
    expect(page.response_headers['Content-Disposition']).to match(/attachment; filename=\"expedientes.csv\"/)
  end

  scenario "Search Expedientes with only one result" do
    expediente = Expediente.offset(rand(Expediente.count)).first
    visit expedientes_path
    within("#new_expediente") do
      fill_in 'expediente_numero_interno', :with => expediente.numero_interno
      click_on 'buscar'
    end
    puts current_path
    expect(current_path).to eq(expediente_path(expediente))
  end

end