require 'colorize'

# Logging functionality
class QTLog
  def initialize
  end

  def log(app, level, msg)
    strmsg = msg.to_s
    strmsg = {
        :warn  => strmsg.colorize(:yellow),
        :error => strmsg.colorize(:red),
        :debug => strmsg.colorize(:green),
      }[level] || strmsg.colorize(:cyan)

    logmsg = "[#{Time.now}] [#{app}] #{level} > #{strmsg}"
    self.write_to_syslog(logmsg)
    puts logmsg
  end

  def info(app, msg)
    self.log(app, :info, msg)
  end

  def debug(app, msg)
    self.log(app, :debug, msg)
  end

  def warning(app, msg)
    self.log(app, :warn, msg)
  end

  def error(app, msg)
    self.log(app, :error, msg)
  end

  def write_to_syslog(msg)
    File.open("logs/log_#{Time.now.strftime('%F')}.log", 'a') { |file|
      file.puts msg
    }
  end
end
