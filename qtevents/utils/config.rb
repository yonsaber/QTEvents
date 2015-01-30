require "JSON"
load "services/logging.rb"

class QTConfig
  @@config = nil # Full config array
  @@qtconfig = nil # Config items under the 'qtevents' key
  @@qtlog = QTLog.new
  CONFIGFILE = "config.json"

  def initalize
  end

  # Reads the configuaion file from the set config file
  # and converts it to a JSON object
  def readconfig
    @@qtlog.info("QTConfig", "Attempting to read configuraion from #{CONFIGFILE}")

    begin
      @@config = JSON.parse(File.open(CONFIGFILE).read)
    rescue Exception => e
      @@qtlog.error("QTConfig", "#{e.message}, using default config")
    end

    if !@@config.nil?
      @@qtconfig = @@config['qtevents']

      @@qtlog.info("QTConfig", "Configuraion sucessfully read from #{CONFIGFILE}")
    else
      @@config = self.defaultconfig
      @@qtconfig = @@config['qtevents']

      @@qtlog.info("QTConfig", "Default configuraion sucessfully read")
    end
  end

  # Finds a value in the config array, if the value exists
  # then the key and value are returned otherwise nil is returned
  def getvalue(key)
    qt = nil
    if keyexists(key)
      qt = @@qtconfig.fetch(key)
    else
      @@qtlog.error("QTConfig", "Key '#{key}' not found in config")
    end

    if !qt.nil?
      return qt
    else
      return nil
    end
  end

  def keyexists(key)
    return @@qtconfig.include?(key)
  end

  def setvalue

  end

  def defaultconfig
    return {'qtevents' => '{ "logging" : true }, "database": { "server" : "localhost", "username" : "root", "password" : "root", "dbname" : "qtevents" }'}
  end
end
