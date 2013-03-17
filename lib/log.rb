require "logger"

module Centron
  class Log
    attr_accessor :log, :tag
    def initialize(io, tag)
      @tag = tag
      @log = Logger.new(io)
      log.level = Logger::INFO
      log.datetime_format = "%Y-%m-%d %H:%M:%S"
      log.formatter = proc do |severity, datetime, progname, msg|
        datetime = datetime.strftime("%Y-%m-%d %H:%M:%S")
        "[#{self.tag}:#{severity}@#{datetime}] #{msg}\n"
      end
      log.info("Logging Initialized")
    end
    def debug msg
      @log.debug msg
    end
    def info msg
      @log.info msg
    end
    def warn msg
      @log.warn msg
    end
    def error msg
      @log.error msg
    end
    def dbg msg
      self.debug msg
    end
  end
end
