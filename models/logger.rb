class Logger
  class << self
    def write message
      if RUBY_ENGINE == 'ruby' && ENV[ 'VERBOSE_LOGGING' ]
        puts message
        return
      end

      if not_browser_test?
         puts message
      end
    end


    def not_browser_test?
      RUBY_ENGINE == 'opal' && ! `!!window.callPhantom`
    end
  end
end