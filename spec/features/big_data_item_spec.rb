require 'spec_helper'

describe 'Create big data item creates' do
  specify do
    visit '/'
    find( '#nav_big_data_item_view' ).click

    within 'div.big_data_item' do
      fill_in 'name', with:'Item Name'
      fill_in 'birthday', with:'1/20/2003'
      fill_in 'birthtime', with:'13:30'
      click_button 'submit'
    end
    
    cid = find( 'div.big_data_item' )[ 'data-cid' ]
    expect( cid.length ).to be > 18

    expect( BigDataItem.first.name ).to eq 'Item Name'
    expect( BigDataItem.first.cid  ).to eq cid
  end
end