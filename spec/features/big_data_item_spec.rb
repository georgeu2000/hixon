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

describe 'Big Data Item collection gets updates' do
  specify do
    visit '/'
    find( '#nav_big_data_item_form' ).click

    within 'form.big_data_item' do
      fill_in 'name', with:'Item 1'
      fill_in 'birthday', with:'1/20/2003'
      fill_in 'favorite_car', with:'BMW'
      fill_in 'sushi', with:'Yes'
      fill_in 'drink', with:'Coke'
      click_button 'submit'
    end

    sleep 0.1

    cid = find( 'form.big_data_item' )[ 'data-cid' ]

    # Get signature for this client from the item. #sneaky
    signature = BigDataItem.where( cid:cid ).first.signature

    find( '#nav_big_data_item_collection' ).click

    sleep 0.1

    expect( all(  ".big_data_item_read" ).count ).to eq 1
    expect( find( '.big_data_item_read' )[ 'data-cid' ]).to eq cid

    cid_2 = Cid.generate
    BigDataItem.create( name:'Item 2', cid:cid_2, signature:signature )

    sleep 0.2

    # Async update:
    expect( all( ".big_data_item_read" ).count ).to eq 2
    expect( all( ".big_data_item_read" ).map{| e | e[ 'data-cid' ]}).to eq [ cid, cid_2 ]
    expect( all( ".big_data_item_read span[name='name']" ).map{| e | e.text }).to eq [ 'Item 1', 'Item 2' ]
  end
end

describe 'Big Data Item filter' do
  specify do
    visit '/'
    find( '#nav_big_data_item_form' ).click

    within 'form.big_data_item' do
      fill_in 'name', with:'Item 1'
      fill_in 'drink', with:'Coke'
      click_button 'submit'
    end

    within 'form.big_data_item' do
      fill_in 'name', with:'Item 2'
      fill_in 'drink', with:'Orange Juice'
      click_button 'submit'
    end

    within 'form.big_data_item' do
      fill_in 'name', with:'Item 3'
      fill_in 'drink', with:'Coke'
      click_button 'submit'
    end

    sleep 0.3

    find( '#nav_big_data_item_filter' ).click

    sleep 0.3

    expect( all( '.big_data_item_read' ).count ).to eq 2
    expect( all( ".big_data_item_read span[name='name'  ]" ).map{| e | e.text }).to eq [ 'Item 1', 'Item 3' ]
    expect( all( ".big_data_item_read span[name='drink' ]" ).map{| e | e.text }).to eq [ 'Coke',   'Coke'   ]
  end
end