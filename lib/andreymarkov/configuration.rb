require "singleton"

class AndreyMarkovConfiguration
  attr_accessor :channel, :server, :nick, :speak_percent, :verbose
  include Singleton

  def configure(&blk)
    instance_eval &blk
    return self.class.instance
  end

  def channel_matches?(message)
    message.channel.name == channel
  end

  def user_matches?(message)
    message.user.name == nick
  end

  def useful_message?(message)
    channel_matches?(message) and not user_matches?(message)
  end

end

