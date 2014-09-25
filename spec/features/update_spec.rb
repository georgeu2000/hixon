require 'spec_helper'


describe 'Update item', type: :feature do
  before do
    skip
  end
  
  specify do
    visit '/'
    within 'div#new_item' do
      fill_in 'name', with:'Name'
      click_button 'submit'
    end
    
    sleep 0.1
    
    within 'div#new_item' do
      fill_in 'name', with:'new name'
      click_button 'submit'
    end

    sleep 0.1

    expect( Item.first.name ).to eq 'new name'
  end
end