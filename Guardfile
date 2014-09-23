
# guard :foreman, command:'foreman start websockets' do
#   watch('Gemfile.lock')
#   watch(%r{^app/(.+)\.rb$})
#   watch(%r{^js/(.+)\.rb$}) 
#   watch(%r{^models/(.+)\.rb$})
#   watch('config.ru')

#   callback( :stop_begin ){ `foreman stop` }
# end

# guard :shell do
#   watch('Gemfile.lock')
#   watch(%r{^app/(.+)\.rb$})
#   watch(%r{^js/(.+)\.rb$}) 
#   watch(%r{^models/(.+)\.rb$}){ ''}
#   watch('config.ru')
# end

guard :process, name:'WebSockets', command:'ruby ./app/websockets.rb' do
  watch('Gemfile.lock')
  watch(%r{^app/(.+)\.rb$})
  watch(%r{^js/(.+)\.rb$}) 
  watch(%r{^models/(.+)\.rb$})
  watch('config.ru')

  callback( :exit_begin ){ `sleep 2` }
end

guard :process, name:'Rack', command:'rackup' do
  watch('Gemfile.lock')
  watch(%r{^app/(.+)\.rb$})
  watch(%r{^js/(.+)\.rb$}) 
  watch(%r{^models/(.+)\.rb$})
  watch('config.ru')
end

guard :rspec, cmd: 'rspec spec' do
  watch(%r{^app/(.+)\.rb$})     { 'spec' }
  watch(%r{^js/(.+)\.rb$})      { 'spec' }
  watch(%r{^models/(.+)\.rb$})  { 'spec' }
  watch(%r{^spec/(.+)\.rb$})    { 'spec' }
end
