load "services/logging.rb"

module QTEvents
  @@qtlog = QTLog.new

  def self.run
    @@qtlog.debug("test")
  end
end

QTEvents.run
