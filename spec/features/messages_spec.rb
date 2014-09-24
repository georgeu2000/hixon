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


describe 'Message from server', type: :feature  do
  specify do
    visit '/'
    
    # Set up the Store object with signature for this client.
    click_link 'click me' 

    Store.send_message
    sleep 0.1

    expect( page.html ).to include 'message from server'
  end
end