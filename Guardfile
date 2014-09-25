guard :process, name:'WebSockets', command:'ruby ./app/websockets.rb' do
  watch('Gemfile.lock')
  watch(%r{^app/(.+)\.rb$})
  watch(%r{^ruby/(.+)\.rb$}) 
  watch(%r{^models/(.+)\.rb$})
  watch('config.ru')
end

guard :process, name:'Rack', command:'rackup' do
  watch('Gemfile.lock')
  watch(%r{^app/(.+)\.rb$})
  watch(%r{^ruby/(.+)\.rb$}) 
  watch(%r{^models/(.+)\.rb$})
  watch('config.ru')
end

guard :rspec, cmd: 'rspec spec' do
  watch(%r{^app/(.+)\.rb$})        { 'spec' }
  watch(%r{^ruby/(.+)\.rb$})         { 'spec' }
  watch(%r{^models/(.+)\.rb$})     { 'spec' }
  watch(%r{^pages/(.+)\.html$})    { 'spec' }
  watch(%r{^public/js/(.+)\.js$})  { 'spec' }
  watch(%r{^spec/(.+)\.rb$})       { 'spec' }
end
