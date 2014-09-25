require 'spec_helper'


describe 'Create item creates', type: :feature do
  specify do
    visit '/'
    click_link 'create item'

    expect( Item.count ).to eq 1
  end
end


describe 'Create item sends update to browser', type: :feature  do
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

    # click_link 'create item in browser'

    # expect( page.html ).to have_css "div.item"
    # expect( page.html ).to have_css "div.item input[type='text']"
    # expect( page.html ).to have_css "div.item input[name='name']"
  end
end