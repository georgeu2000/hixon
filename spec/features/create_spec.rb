require 'spec_helper'


describe 'Create item creates' do
  specify do
    skip 'Depricated'

    visit '/'
    find( '#nav_create' ).click
    click_link 'create item'

    sleep 0.1
    expect( Item.count ).to eq 1
  end
end

describe 'Create item sends update to browser' do
  specify do
    skip 'Deprecated'

    visit '/create'
    click_link 'create item'

    sleep 0.1

    expect( page.html ).to include 'item created'
  end
end

describe 'Show Create Item HTML' do
  specify do
    skip 'Depricated'

    visit '/'
    find( '#nav_create' ).click
    click_link 'create item in browser'

    expect( page.html ).to have_css "div#create_items"
    expect( page.html ).to have_css "div#create_items input[type='text']"
    expect( page.html ).to have_css "div#create_items input[name='name']"
  end
end

describe 'Create item saves item' do
  specify do
    skip 'Depricated'

    visit '/'
    find( '#nav_create' ).click

    within 'div#new_item' do
      fill_in 'name', with:'new item name'
      click_button 'submit'
    end
    
    sleep 0.1
    expect( Item.count      ).to eq 1
    expect( Item.first.name ).to eq 'new item name'
  end
end

describe 'Create item sets CID in DOM'  do
  specify do
    skip 'Depricated'

    visit '/'
    find( '#nav_create' ).click

    within 'div#new_item' do
      fill_in 'name', with:'new item name'
      click_button 'submit'
    end
    
    expect( find( 'div#new_item' )[ 'data-cid' ].length ).to be > 18
  end
end

describe 'Create item sets CID in DB' do
  specify do
    skip 'Depricated'
    
    visit '/'
    find( '#nav_create' ).click

    within 'div#new_item' do
      fill_in 'name', with:'new item name'
      click_button 'submit'
    end
    
    cid = find( 'div#new_item' )[ 'data-cid' ]

    expect( Item.first.cid ).to eq cid
  end
end

