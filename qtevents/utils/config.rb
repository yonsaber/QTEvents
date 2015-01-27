require "JSON"
load "services/logging.rb"

class QTConfig
  @@config = nil
  @@qtconfig = nil
  @@qtlog = QTLog.new
  CONFIGFILE = "config.json"

  def initalize
  end

  def readconfig
    @@qtlog.info("QTConfig", "Attempting to read configuraion from #{CONFIGFILE}")

    begin
      @@config = JSON.parse(File.open(CONFIGFILE).read)
    rescue Exception => e
      @@qtlog.error("QTConfig", "#{e.message} \n #{e.backtrace.inspect}")
    end

    if !@@config.nil?
      @@qtconfig = @@config['qtevents']

      @@qtlog.info("QTConfig", "Configuraion sucessfully read from #{CONFIGFILE}")
    end
  end

  # Finds a value in the config array, if the value exists
  # then the key and value are returned otherwise nil is returned
  def getvalue(key)
    qt = nil
    begin
      qt = @@qtconfig.fetch(key)
    rescue Exception
      @@qtlog.error("QTConfig", "Key '#{key}' not found in config file")
    end

    if !qt.nil?
      return qt
    else
      return nil
    end
  end

  def setvalue

  end
end
