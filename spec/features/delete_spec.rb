require 'spec_helper'


describe 'Delete item' do
  specify do
    visit '/'
    find( '#nav_create' ).click

    within 'div#new_item' do
      fill_in 'name', with:'Item Name'
      click_button 'submit'
    end
    
    find( '#nav_read' ).click

    expect( find( '#page_content' ).text ).to include 'Read Items'
    expect( find( '#items .item'  ).text ).to include 'Item Name'
    
    find( '#nav_delete' ).click

    within 'div#items' do
      click_button 'delete'
    end

    find( '#nav_read' ).click

    expect( find( '#page_content' ).text ).to     include 'Read Items'
    expect( find( '#items'        ).text ).to_not include 'Item Name'
  end
end