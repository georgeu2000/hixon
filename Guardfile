guard :rack do
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