require 'spec_helper'


describe 'Get Home Page' do
  specify do
    visit '/'

    expect( page.status_code ).to eq 200
  end
end