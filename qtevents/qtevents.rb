load "core/qt.rb"

module QTEvents
  @@core = QT.new

  def self.run
    @@core.welcome
    @@core.getconfig
    @@core.dbconnect
    @@core.close
  end
end

QTEvents.run
