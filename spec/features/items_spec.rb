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