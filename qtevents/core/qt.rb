load "core/database.rb"
load "services/logging.rb"
load "utils/config.rb"

class QT
  @@qtlog = QTLog.new
  @@config = QTConfig.new
  @@qtdb = nil

  def initialize
  end

  def welcome
    @@qtlog.info("QT", "Starting up QTEvents")
  end

  def getconfig
    @@config.readconfig
  end

  def dbconnect
    if @@config.keyexists("database")
      db = @@config.getvalue("database")
      @@qtdb = QTDatabase.new(
        db["server"],
        db["username"],
        db["password"],
        db["dbname"]
      )
    else
      @@qtlog.error("QT", "No database connection settings")
    end
  end

  def close
    @@qtdb.close
  end
end
