require 'spec_helper'


describe 'Update item' do
  specify do
    skip 'Depricated'
    
    visit '/'
    find( '#nav_create' ).click

    within 'div#new_item' do
      fill_in 'name', with:'Name'
      click_button 'submit'
    end
    
    find( '#nav_update' ).click
    
    within 'div#items' do
      fill_in 'name', with:'New Name'
      click_button 'update'
    end

    find( '#nav_read' ).click

    expect( find( '#page_content' ).text ).to include 'Read Items'
    expect( find( '#items .item'  ).text ).to include 'New Name'
  end
end