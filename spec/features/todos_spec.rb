describe 'Todos' do
  specify 'Init and Asyc' do
    visit '/'
    find( '#nav_todos' ).click

    within 'form' do
      fill_in 'text', with:'get coffee'
    end
    find( "form input[ name='text' ]" ).native.send_key :Enter

    sleep 0.1

    cid = Todo.first.cid
    signature = Todo.first.signature

    cid_2 = Cid.generate
    Todo.create_for( text:'buy food', cid:cid_2, view:'all', signature:signature )

    sleep 0.2

    # Server push:
    expect( all( ".todo" ).count ).to eq 2
    expect( all( ".todo" ).map{| e | e[ 'data-cid' ]}).to eq [ cid, cid_2 ]
    expect( all( ".todo input[ name='text' ]" ).map{| e | e.value }).to eq [ 'get coffee', 'buy food' ]

    # Not done to start
    expect( all( ".todo input[ name='done' ]" ).map{| e | e.checked? }).to eq [ false, false ]
  end


  specify 'updates' do
    visit '/'
    find( '#nav_todos' ).click

    within 'form.new-todo' do
      fill_in 'text', with:'get coffee'
    end
    find( "form.new-todo input[ name='text' ]" ).native.send_key :Enter

    within 'form.new-todo' do
      fill_in 'text', with:'buy milk'
    end
    find( "form.new-todo input[ name='text' ]" ).native.send_key :Enter

    sleep 0.2

    expect( all( ".todo" ).count ).to eq 2
    expect( all( ".todo input[ name='text' ]" ).map{| e | e.value }).to eq [ 'get coffee', 'buy milk' ]

    cid = all( ".todo" ).map{| e | e[ 'data-cid' ]}.first

    within( "form.todo[ data-cid='#{ cid }' ]" ) do
      fill_in 'text', with:'new text'
    end
    find( "form.todo[ data-cid='#{ cid }' ] input[ name='text' ]" ).native.send_key :Enter

    find( '#nav_todos' ).click
    sleep 0.1

    expect( find( ".todo[ data-cid='#{ cid }' ] input[ name='text' ]" ).value ).to eq 'new text'

    within( ".todo[ data-cid='#{ cid }' ]" ) do
      click_link 'x'
    end

    sleep 0.2
    expect( all( ".todo[ data-cid='#{ cid }' ]" )).to be_empty
  end
end
