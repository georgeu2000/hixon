require 'spec_helper'


describe 'Create item creates' do
  specify do
    visit '/'
    find( '#nav_item_view' ).click

    within 'div.item' do
      fill_in 'name', with:'Item Name'
      click_button 'submit'
    end
    
    cid = find( 'div.item' )[ 'data-cid' ]
    expect( cid.length ).to be > 18

    find( '#nav_read' ).click

    expect( find( '#page_content' ).text ).to include 'Read Items'
    expect( find( "#items .item span[ data-name='name' ]" ).text ).to eq 'Item Name'
    expect( find( "#items .item" )[ 'data-cid' ]).to eq cid
  end
end


describe 'View Model creates and reads Item' do
  specify do
    visit '/'
    find( '#nav_create' ).click

    within 'div.item' do
      fill_in 'name', with:'Item Name'
      find( "button[ name='submit' ]" ).click
    end
    
    find( '#nav_read' ).click
    
    expect( find( '#page_content' ).text ).to include 'Read Items'
    expect( find( "#items .item span[ data-name='name' ]" ).text ).to eq 'Item Name'
  end
end


describe 'View Model updates item' do
  specify do
    visit '/'
    find( '#nav_create' ).click

    within 'div.item' do
      fill_in 'name', with:'Item Name'
      click_button 'submit'
    end
    
    find( '#nav_update' ).click
    
    within 'div#items' do
      fill_in 'name', with:'New Name'
      find( "button[ name='submit' ]" ).click
    end

    find( '#nav_read' ).click

    expect( find( '#page_content' ).text ).to include 'Read Items'
    expect( find( "#items .item span[ data-name='name' ]" ).text ).to eq 'New Name'
  end
end


describe 'View Model deletes item' do
  specify do
    visit '/'
    find( '#nav_create' ).click

    within 'div.item' do
      fill_in 'name', with:'Item Name'
      click_button 'submit'
    end
    
    find( '#nav_delete' ).click
    
    within 'div#items .item' do
      find( "button[ name='delete' ]" ).click
    end

    find( '#nav_read' ).click

    expect( find( '#page_content' ).text ).to include 'Read Items'
    expect( find( "#items" ).text ).to_not include 'Item Name'
  end
end