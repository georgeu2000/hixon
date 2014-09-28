require 'spec_helper'


describe 'Read item' do
  specify do
    skip 'Deprecated'
    
    visit '/'
    find( '#nav_create' ).click

    within 'div.new_item' do
      fill_in 'name', with:'Name'
      click_button 'submit'
    end
    
    find( '#nav_read' ).click
    
    expect( find( '#page_content' ).text ).to include 'Read Items'
    expect( find( '#items .item'  ).text ).to include 'Name'
  end
end