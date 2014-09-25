require 'spec_helper'


describe 'Create item creates', type: :feature do
  specify do
    visit '/'
    click_link 'create item'

    sleep 0.1
    expect( Item.count ).to eq 1
  end
end


describe 'Create item sends update to browser', type: :feature do
  specify do
    visit '/'
    click_link 'create item' 

    sleep 0.1

    expect( page.html ).to include 'item created'
  end
end


describe 'Create item creates item in browser', type: :feature do
  specify do
    visit '/'
    click_link 'create item in browser'

    expect( page.html ).to have_css "div#items"
    expect( page.html ).to have_css "div#items input[type='text']"
    expect( page.html ).to have_css "div#items input[name='name']"
  end
end


describe 'Create item saves item', type: :feature do
  specify do
    visit '/'
    within 'div#new_item' do
      fill_in 'name', with:'new item name'
      click_button 'submit'
    end
    
    sleep 0.1
    expect( Item.count      ).to eq 1
    expect( Item.first.name ).to eq 'new item name'
  end
end

describe 'Create item sets CID', type: :feature do
  specify do
    visit '/'
    within 'div#new_item' do
      fill_in 'name', with:'new item name'
      click_button 'submit'
    end
    
    expect( find( 'div#new_item' )[ 'data-cid' ].length ).to be > 18
  end
end

describe 'Update item', type: :feature ,focus:false do
  specify do
    visit '/'
    within 'div#new_item' do
      fill_in 'name', with:'new item name'
      click_button 'submit'
    end
    
    sleep 0.1
    expect( Item.count      ).to eq 1
    expect( Item.first.name ).to eq 'new item name'
  end
end
