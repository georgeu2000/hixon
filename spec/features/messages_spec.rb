require 'spec_helper'

describe 'Home Page', type: :feature do
  specify do
    visit '/'

    expect( page.status_code ).to eq 200
  end
end


describe 'Message to server', type: :feature do
 specify do
    visit '/'
    click_link 'click me'

    expect( Store.count ).to eq 1
  end
end