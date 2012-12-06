class EmailOrSite

  def initialize str, protocol
    @str = str
    @protocol = protocol
    raise "no string given" if @str.nil?
  end

  def subdomain
    if @str.present?
      unless @str.match /htt(p|ps):\/\//
        @protocol=@protocol
        @str=[@protocol, @str].join
      end
      @str=URI.parse @str
      @str.host.split(".").first
    else
      ""
    end
  end

  def email
    if @str.match /@/
      @str
    else
      nil
    end
  end

  def type
    if @str.match /@/
      "email1"
    else
      "subdomain"
    end
  end

  def to_s
    if @str.match /@/
      email
    else
      subdomain
    end
  end

end
