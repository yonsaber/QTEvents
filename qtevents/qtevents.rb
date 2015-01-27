load "services/logging.rb"
load "utils/config.rb"

module QTEvents
  @@qtlog = QTLog.new
  @@config = QTConfig.new
  def self.run
    @@config.readconfig
  end
end

QTEvents.run
