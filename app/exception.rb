class Exception
  alias_method :original_backtrace, :backtrace

  def backtrace
    original_backtrace.first if original_backtrace
  end
end