require 'spec_helper'

describe 'Home Page', type: :feature do
  specify do
    visit '/'

    expect( page.status_code ).to eq 200
  end
end


describe 'Message to server', type: :feature ,focus:true do
  before do
    allow( Store ).to receive( :message )
  end

  specify do
    visit '/'
    click_link 'click me'

    expect( Store ).to have_received( :message )
  end
end