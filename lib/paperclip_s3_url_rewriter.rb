class PaperclipS3UrlRewriter
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    if response.is_a?(ActionController::Response) && response.request.protocol == 'https://' && headers["Content-Type"].include?("text/html")
      body = response.body.gsub('http://s3.amazonaws.com', 'https://s3.amazonaws.com')
      headers["Content-Length"] = body.length.to_s
      [status, headers, body]
    else
      [status, headers, response]
    end
  end
end

