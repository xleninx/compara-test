class DealerService

  def initialize(token)
    @token = token
    @response_status = 200
  end

  def expired_token?
    @response_status == 405
  end

  def get_hand(num_cards = 5)
    @token.present? ? get_cards(num_cards) : false
  end

  def get_cards(num_cards)
    begin
      response = RestClient::Request.execute(method: :get, 
                                             url: dealer_url(num_cards), 
                                             timeout: 5)
      JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
      @response_status = e.http_code
      create_new_token if e.http_code == 405
      get_cards(num_cards)
    end
  end

  private

  def create_new_token
    @token = DealerConnectionService.new.generate_token
  end

  def dealer_url(num_cards)
    "https://services.comparaonline.com/dealer/deck/#{@token}/deal/#{num_cards}"
  end

end