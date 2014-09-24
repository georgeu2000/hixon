require 'spec_helper'


describe 'Home Page', type: :feature do
  specify do
    visit '/'

    expect( page.status_code ).to eq 200
  end
end