require "mysql"
require "sqlite3"
load "services/logging.rb"

class QTDatabase
  @@con = nil
  @@qtlog = QTLog.new

  # Create a new connection to the MySQL database
  def initialize(server, user, password, database)
    if !server.nil? && !user.nil? && !password.nil? && !database.nil?
      begin
        @@qtlog.info("QTDatabase", "Attemting login to MySQL server #{server} with user #{user}")
        @@con = Mysql.real_connect(server, user, password, database)
        @@qtlog.info("QTDatabase", "Connected to database #{database}")
      rescue Mysql::Error => e
        @@qtlog.error("QTDatabase", "An error was thrown trying to connect to the server '#{server}'. Error: #{e}")
      end
    else
      @@qtlog.error("QTDatabase", "Nil value passed in")
    end
  end

  # Close our connection to the database
  def close
    if !@@con.nil?
      @@qtlog.info("QTDatabase", "Connection to database has been closed")
      @@con.close
    end
  end
end
