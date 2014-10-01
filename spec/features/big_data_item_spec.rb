require 'spec_helper'

describe 'Create big data item creates and reads' do
  specify do
    visit '/'
    find( '#nav_big_data_item_form' ).click

    within 'form.big_data_item' do
      fill_in 'name', with:'Item Name'
      fill_in 'birthday', with:'1/20/2003'
      fill_in 'favorite_car', with:'BMW'
      fill_in 'sushi', with:'Yes'
      fill_in 'drink', with:'Coke'
      # find( :css, "input[ value='Coke' ]").set true
      click_button 'submit'
    end
    
    cid = find( 'form.big_data_item' )[ 'data-cid' ]
    expect( cid.length ).to be > 18

    expect( BigDataItem.count ).to eq 1
    expect( BigDataItem.first.name  ).to eq 'Item Name'
    expect( BigDataItem.first.cid   ).to eq  cid
    expect( BigDataItem.first.drink ).to eq 'Coke'

    expect( find( ".big_data_item_read" )[ 'data-cid' ]).to eq cid
    expect( find( ".big_data_item_read span[ name='name' ]" ).text ).to eq 'Item Name'
  end
end