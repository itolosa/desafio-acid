class WebServiceClient
  def self.post(email, image)
    # configura la conexion hacia el WebService2
    conn = Faraday.new(url: 'http://serene-shore-63130.herokuapp.com') do |faraday|
      faraday.request  :url_encoded
      # usar Net::HTTP por defecto
      faraday.adapter  Faraday.default_adapter
    end

    # consulta la api del WebService2
    # fija content-type = application/json
    # permite que WebService2 convierta el request-body a hash (Rails)
    conn.post do |req|
      req.url "/rest/verifyUser/#{CGI.escape(email)}"
      req.headers['Content-Type'] = 'application/json'
      req.body = { image: image }.to_json
    end
  end
end