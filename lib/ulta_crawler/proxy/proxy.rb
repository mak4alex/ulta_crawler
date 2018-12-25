class Proxy

  attr_reader :host, :port, :user, :pass, :separator, :banned_at

  def initialize(string, banned_at: nil, separator: ':')
    @host, @port, @user, @pass, @separator = string.split(separator)
    @banned_at = banned_at
  end

  def ban(timestamp = Time.now.to_i)
    @banned_at = timestamp
  end

  def ban?
    !!@banned_at
  end

  def unban
    @banned_at = nil
  end

  def to_s
    [host, port, user, pass].map(&:to_s).reject(&:empty?).join(separator)
  end

end
