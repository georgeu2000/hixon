require 'spec_helper'


describe 'Post' do
  let( :title ){ 'First Post!' }
  let( :body  ){ 'This is the body for the first post.' }

  specify 'create, view all and view single' do
    visit '/'
    find( '#nav_new_post' ).click

    within 'form.new-post' do
      fill_in 'title', with:'First Post!'
      fill_in 'body',  with:body
      click_button 'save'
    end

    sleep 0.2

    cid = find( 'form.new-post' )[ 'data-cid' ]
    
    find( '#nav_all_posts' ).click

    sleep 0.3

    expect( all( ".post" ).count ).to eq 1
    expect( all( ".post" ).map{| e | e[ 'data-cid' ]}).to eq [ cid ]
    expect( all( ".post [ name='title' ]" ).map{| e | e.text }).to eq [ title ]
    expect( all( ".post [ name='body'  ]" ).map{| e | e.text }).to eq []
    
    find( ".post[ data-cid='#{ cid }' ]" ).click
    sleep 0.3

    expect( all( ".post" ).count ).to eq 1
    expect( all( ".post" ).map{| e | e[ 'data-cid' ]}).to eq [ cid ]
    expect( all( ".post [ name='title' ]" ).map{| e | e.text }).to eq [ title ]
    expect( all( ".post [ name='body'  ]" ).map{| e | e.text }).to eq [ body  ]
  end
end