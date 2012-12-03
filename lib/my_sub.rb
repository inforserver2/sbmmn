class MySub

  def initialize url, user
    @url=url
    @user=user
  end

  def host
   [@user.subdomain , @url.domain].compact.join(".")
  end

  def path
    path=@url.query_parameters
  end

  def handle_path
    path[:redir_from]= @url.subdomains.join(".")
    path.to_param
  end

  def url
    url=URI.parse(@url.url)
    url.host=host
    url.query=handle_path
    url.to_s
  end

end

