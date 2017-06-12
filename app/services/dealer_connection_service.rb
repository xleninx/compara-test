class DealerConnectionService

  def initialize
    @token_url = "https://services.comparaonline.com/dealer/deck"
  end

  def generate_token
    begin
      res = RestClient.post(@token_url, {})
      res.body
    rescue RestClient::ExceptionWithResponse => e
      false
    end
  end

end