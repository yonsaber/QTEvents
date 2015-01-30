require 'colorize'

# Logging functionality
class QTLog
  def initialize
  end

  # Logs a message to the system console and a file
  # if enabled in config
  def log(app, level, msg)
    strmsg = msg.to_s
    strmsg = {
        :warn  => strmsg.colorize(:yellow),
        :error => strmsg.colorize(:red),
        :debug => strmsg.colorize(:green),
      }[level] || strmsg.colorize(:cyan)

    logmsg = "[#{Time.now}] [#{app}] #{level} > #{strmsg}"
    self.write_to_log(logmsg)
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

  # Creates a file using the current date and writes any log
  # messages to it (only creates one file per day)
  def write_to_log(msg)
    File.open("logs/log_#{Time.now.strftime('%F')}.log", 'a') { |file|
      file.puts msg
    }
  end
end
