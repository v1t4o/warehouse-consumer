require 'rails_helper'

describe 'Visitor register a warehouse' do
  it 'from a link on the home page' do
    warehouses = []
    allow(Warehouse).to receive(:all).and_return(warehouses)

    visit root_path
    click_on 'Cadastrar Galpão'

    expect(current_path).to eq new_warehouse_path
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Área Total'
    expect(page).to have_field 'Área Útil'
    expect(page).to have_button 'Gravar'
  end

  it 'successfully' do
    warehouses = []
    warehouse_post = Warehouse.new(name: 'Juiz de Fora', code: 'JDF', description: 'Um galpão mineiro com o pé no Rio', address: 'Av Rio Branco', city: 'Juiz de Fora', state: 'MG', postal_code: '36000-000', total_area: '5000', useful_area: '3000')
    warehouse = Warehouse.new(id: 1, name: 'Juiz de Fora', code: 'JDF', description: 'Um galpão mineiro com o pé no Rio', address: 'Av Rio Branco', city: 'Juiz de Fora', state: 'MG', postal_code: '36000-000', total_area: '5000', useful_area: '3000')
    allow(Warehouse).to receive(:all).and_return(warehouses)
    allow_any_instance_of(Warehouse).to receive(:save).and_return(warehouse)
    allow(Warehouse).to receive(:find).with(warehouse.id.to_s).and_return(warehouse)
    
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: 'Juiz de Fora'
    fill_in 'Código', with: 'JDF'
    fill_in 'Endereço', with: 'Av Rio Branco'
    fill_in 'Cidade', with: 'Juiz de Fora'
    fill_in 'Estado', with: 'MG'
    fill_in 'CEP', with: '36000-000'
    fill_in 'Descrição', with: 'Um galpão mineiro com o pé no Rio'
    fill_in 'Área Total', with: '5000'
    fill_in 'Área Útil', with: '3000'
    click_on 'Gravar'

    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_css('h2', text: 'Juiz de Fora')
    expect(page).to have_css('h4', text: 'JDF')
    expect(page).to have_css('dt', text: 'Descrição:')
    expect(page).to have_css('dd', text: 'Um galpão mineiro com o pé no Rio')
    expect(page).to have_css('dt', text: 'Endereço:')
    expect(page).to have_css('dd', text: 'Av Rio Branco - Juiz de Fora/MG')
    expect(page).to have_css('dt', text: 'CEP:')
    expect(page).to have_css('dd', text: '36000-000')
    expect(page).to have_css('dt', text: 'Área Total:')
    expect(page).to have_css('dd', text: '5000 m2')
    expect(page).to have_css('dt', text: 'Área Útil:')
    expect(page).to have_css('dd', text: '3000 m2')
    expect(page).to have_content 'Galpão registrado com sucesso'
  end
end