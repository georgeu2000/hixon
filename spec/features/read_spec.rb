require 'spec_helper'


describe 'Read item' do
  specify do
    visit '/'
    find( '#nav_create' ).click

    within 'div#new_item' do
      fill_in 'name', with:'Name'
      click_button 'submit'
    end
    
    find( '#nav_read' ).click
    
    expect( page.text ).to include 'Read Items'
    expect( find( '#items .item'  ).text ).to include 'Name'
  end
end