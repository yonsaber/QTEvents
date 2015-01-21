# Logging functionality
class QTLog
  def initialize
  end

  def log(level, message)
    logmsg = "[#{Time.now}] #{level} > #{message}"
    self.writetolog(logmsg)
    puts logmsg
  end

  def info(message)
    self.log("info", message)
  end

  def debug(message)
    self.log("debug", message)
  end

  def warning(message)
    self.log("warning", message)
  end

  def error(message)
    self.log("error", message)
  end
end
